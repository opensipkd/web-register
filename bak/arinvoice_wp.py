import sys
import re
from email.utils import parseaddr
from sqlalchemy import not_, func
from datetime import datetime
from time import gmtime, strftime
from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPFound,
    )
import colander
from deform import (
    Form,
    widget,
    ValidationFailure,
    )
from ..tools import _DTnumberformat
from ..models import DBSession
from ..models.isipkd import(
      Pegawai, ObjekPajak, WajibPajak, ARInvoice,
      Unit, Wilayah, Pajak, Rekening,
      User
      )

from datatables import (
    ColumnDT, DataTables)
    
from ..security import group_finder

SESS_ADD_FAILED = 'Gagal tambah Tagihan'
SESS_EDIT_FAILED = 'Gagal edit Tagihan'
from daftar import (STATUS, deferred_status,
                    daftar_wajibpajak, deferred_wajibpajak,
                    daftar_objekpajak, deferred_objekpajak,
                    daftar_wilayah, deferred_wilayah,
                    daftar_unit, deferred_unit,
                    daftar_pajak, deferred_pajak,
                    auto_op_nm, auto_unit_nm, auto_wp_nm, auto_wp_nm4
                    )
########                    
# List #
########    
@view_config(route_name='arinvoicewp', renderer='templates/arinvoice/list_wp.pt',
             permission='read')
def view_list(request):
    return dict(rows={})
    

#######    
# Add #
#######
def form_validator(form, value):
    def err_kode():
        raise colander.Invalid(form,
            'Kode invoice %s sudah digunakan oleh ID %d' % (
                value['kode'], found.id))

    def err_name():
        raise colander.Invalid(form,
            'Uraian  %s sudah digunakan oleh ID %d' % (
                value['nama'], found.id))
                
    if 'id' in form.request.matchdict:
        uid = form.request.matchdict['id']
        q = DBSession.query(ARInvoice).filter_by(id=uid)
        r = q.first()
    else:
        r = None
            
class AddSchema(colander.Schema):
    moneywidget = widget.MoneyInputWidget(
            size=20, options={'allowZero':True,
                              'precision':0
                              })
            
    unit_id = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    oid="unit_id",
                    title="OPD",
                    )
    unit_nm = colander.SchemaNode(
                    colander.String(),
                    title="OPD",
                    oid="unit_nm"
                    )
    wajibpajak_id = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    title="Penyetor",
                    oid = "wajibpajak_id"
                    )
    wajibpajak_nm = colander.SchemaNode(
                    colander.String(),
                    widget=auto_wp_nm4,
                    title="Penyetor",
                    oid = "wajibpajak_nm"
                    )
    wajib_pajak_us = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    oid = "wajib_pajak_us"
                    )
    wajib_pajak_un = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    oid = "wajib_pajak_un"
                    )
    objekpajak_id = colander.SchemaNode(
                    colander.Integer(),
                    title="Objek",
                    widget=widget.HiddenWidget(),
                    oid = "objekpajak_id"
                    )
    objekpajak_nm = colander.SchemaNode(
                    colander.String(),
                    widget=auto_op_nm,
                    title="Objek",
                    oid = "objekpajak_nm"
                    )
                    
    kode   = colander.SchemaNode(
                    colander.String(),
                    title="Kode Bayar",
                    missing = colander.drop,
                    )
                    
    periode_1 = colander.SchemaNode(
                    colander.Date(),
                    title="Periode 1",
                    widget = widget.DateInputWidget()
                    )
    periode_2 = colander.SchemaNode(
                    colander.Date(),
                    title="Periode 2"
                    )
    tgl_tetap = colander.SchemaNode(
                    colander.Date(),
                    )
    jatuh_tempo = colander.SchemaNode(
                    colander.Date(),
                    )
    dasar = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "dasar"
                    )
    tarif = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "tarif",
                    missing=colander.drop
                    )
    pokok = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    missing=colander.drop,
                    oid = "pokok"
                    )
    denda = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "denda"
                    )
    bunga = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "bunga"
                    )
    jumlah = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    missing=colander.drop,
                    oid = "jumlah"
                    )
                    
class EditSchema(AddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True)
            )
                    

def get_form(request, class_form):
    schema = class_form(validator=form_validator)
    schema = schema.bind(daftar_status=STATUS,
                         daftar_wajibpajak=daftar_wajibpajak(),
                         daftar_unit=daftar_unit(),
                         daftar_objekpajak=daftar_objekpajak(),
                         )
    schema.request = request
    return Form(schema, buttons=('simpan','batal'))
    
def save(request, values, row=None):
    if not row:
        row = ARInvoice()
    row.from_dict(values)
    row.dasar  = re.sub("[^0-9]", "", row.dasar)
    row.tarif  = re.sub("[^0-9]", "", row.tarif)
    row.pokok  = re.sub("[^0-9]", "", row.pokok)
    row.denda  = re.sub("[^0-9]", "", row.denda)
    row.bunga  = re.sub("[^0-9]", "", row.bunga)
    row.jumlah = re.sub("[^0-9]", "", row.jumlah)
    
    if not row.tahun_id:
        row.tahun_id = datetime.now().strftime('%Y')
        
    unit = Unit.get_by_id(row.unit_id)
    row.unit_kd = unit.kode
    row.unit_nm = unit.nama
    
    ref = Unit.get_by_id(row.unit_id)
    row.unit_kode = ref.kode
    row.unit_nama = ref.nama
    ref = WajibPajak.get_by_id(row.wajibpajak_id)
    row.wp_kode = ref.kode
    row.wp_nama = ref.nama
    row.wp_alamat_1 = ref.alamat_1
    row.wp_alamat_2 = ref.alamat_2
    
    ref = ObjekPajak.get_by_id(row.objekpajak_id)
    row.op_kode = ref.kode
    row.op_nama = ref.nama
    row.op_alamat_1 = ref.alamat_1
    row.op_alamat_2 = ref.alamat_2
    row.wilayah_id = ref.wilayah_id
    row.rekening_id = ref.pajaks.rekening_id
    row.rek_kode = ref.pajaks.rekenings.kode
    row.rek_nama = ref.pajaks.rekenings.nama
    
    ref = Wilayah.get_by_id(row.wilayah_id)
    row.wilayah_kode = ref.kode
    
    prefix  = '22' 
    tanggal = datetime.now().strftime('%d')
    bulan   = datetime.now().strftime('%m')
    tahun   = datetime.now().strftime('%y')
    
    if not row.kode and not row.no_id:
        invoice_no = DBSession.query(func.max(ARInvoice.no_id)).\
                               filter(ARInvoice.tahun_id==row.tahun_id,
                                      ARInvoice.unit_id==row.unit_id).scalar()
        if not invoice_no:
            row.no_id = 1
        else:
            row.no_id = invoice_no+1

    row.kode = "".join([prefix, re.sub("[^0-9]", "", row.wilayah_kode), 
                        str(tanggal).rjust(2,'0'), 
                        str(bulan).rjust(2,'0'),
                        str(tahun).rjust(2,'0'),
                        str(row.no_id).rjust(4,'0')])

    row.owner_id = request.user.id
    #if values['password']:
    #    row.password = values['password']
    DBSession.add(row)
    DBSession.flush()
    return row
    
def save_request(values, request, row=None):
    if 'id' in request.matchdict:
        values['id'] = request.matchdict['id']
    row = save(request, values, row)
    request.session.flash('No Bayar %s sudah disimpan.' % row.kode)
        
def route_list(request):
    return HTTPFound(location=request.route_url('arinvoicewp'))
    
def session_failed(request, session_name):
    try:
        session_name.set_appstruct(request.session[SESS_ADD_FAILED])
    except:
        pass
    r = dict(form=session_name) #request.session[session_name])
    del request.session[SESS_ADD_FAILED]
    return r
    
@view_config(route_name='arinvoicewp-add', renderer='templates/arinvoice/add_wp.pt',
             permission='add')
def view_add(request):
    form = get_form(request, AddSchema)
    values = {}
	
    u = request.user.id
    if u != 1 :
        a = DBSession.query(User.email).filter(User.id==u).first()
        print '----------------Email---------------------',a
        rows = DBSession.query(WajibPajak.id.label('sid'), WajibPajak.nama.label('snm'), WajibPajak.unit_id.label('sui'), WajibPajak.user_id.label('sus'),
                       ).filter(WajibPajak.email==a,
                       ).first()
        values['wajibpajak_id'] = rows.sid
        print '----------------Subjek id-----------------------',values['wajibpajak_id']
        values['wajibpajak_nm'] = rows.snm
        print '----------------Subjek nama---------------------',values['wajibpajak_nm']
        values['wajib_pajak_us'] = rows.sus
        print '----------------Subjek user---------------------',values['wajib_pajak_us']
        values['wajib_pajak_un'] = rows.sui
        print '----------------Subjek unit 1-------------------',values['wajib_pajak_un']
        values['unit_id'] = rows.sui
        print '----------------Subjek unit---------------------',values['unit_id'] 
        unit = DBSession.query(Unit.nama.label('unm')
                       ).filter(Unit.id==values['unit_id'],
                       ).first()
        values['unit_nm'] = unit.unm	
        print '----------------Unit nama-----------------------',values['unit_nm'] 
	
    values['tgl_tetap']   = datetime.now()
    values['jatuh_tempo'] = datetime.now()
    values['periode_1']   = datetime.now()
    values['periode_2']   = datetime.now()
    form.set_appstruct(values)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            controls_dicted = dict(controls)
            
            # Cek Kode
            if not controls_dicted['kode']=='':
                a = form.validate(controls)
                b = a['kode']
                c = "%s" % b
                cek = DBSession.query(ARInvoice).filter(ARInvoice.kode==c).first()
                if cek :
                    request.session.flash('Kode Bayar %s sudah digunakan.' % b, 'error')
                    return HTTPFound(location=request.route_url('arinvoicewp-add'))

            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, form) 
    return dict(form=form, is_unit=0, is_sp=0)

########
# Edit #
########
def query_id(request):
    return DBSession.query(ARInvoice).filter(ARInvoice.id==request.matchdict['id'],)
                         #ARInvoice.status_bayar==0)
    
def id_not_found(request):    
    msg = 'No Bayar ID %s tidak ditemukan atau sudah dibayar.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='arinvoicewp-edit', renderer='templates/arinvoice/add_wp.pt',
             permission='edit')
def view_edit(request):
    row = query_id(request).first()
    uid  = row.id
    kode = row.kode

    if not row:
        return id_not_found(request)
    if row.status_bayar:
        request.session.flash('Data sudah masuk di Penerimaan', 'error')
        return route_list(request)
        
    form = get_form(request, EditSchema)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            
            # Cek kode
            a = form.validate(controls)
            b = a['kode']
            c = "%s" % b
            cek = DBSession.query(ARInvoice).filter(ARInvoice.kode==c).first()
            if cek:
                kode1 = DBSession.query(ARInvoice).filter(ARInvoice.id==uid).first()
                d     = kode1.kode
                if d!=c:
                    request.session.flash('Kode Bayar %s sudah digunakan' % b, 'error')
                    return HTTPFound(location=request.route_url('arinvoicewp-edit',id=row.id))
                    
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)             
                return HTTPFound(location=request.route_url('arinvoicewp-edit',
                                  id=row.id))
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    values['objekpajak_nm'] = row.objekpajaks.nama
    values['wajibpajak_nm'] = row.wajibpajaks.nama
    values['unit_nm'] = row.units.nama
    form.set_appstruct(values)
    return dict(form=form)

##########
# Delete #
##########    
@view_config(route_name='arinvoicewp-delete', renderer='templates/arinvoice/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    
    if not row:
        return id_not_found(request)
    if row.status_bayar:
        request.session.flash('Data sudah masuk di Penerimaan', 'error')
        return route_list(request)
        
    if row.arsspds:
        form = Form(colander.Schema(), buttons=('cancel',))
    else:
        form = Form(colander.Schema(), buttons=('delete', 'cancel'))
    if request.POST:
        if 'delete' in request.POST:
            msg = 'No Bayar ID %d %s sudah dihapus.' % (row.id, row.kode)
            q.delete()
            DBSession.flush()
            request.session.flash(msg)
        return route_list(request)
    return dict(row=row,
                 form=form.render())

##########
# Action #
##########    
def qry_arinv():
    return DBSession.query(ARInvoice).\
                            join(Unit)

@view_config(route_name='arinvoicewp-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict
    user = req.user
    if url_dict['act']=='grid':
        u = request.user.id
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('kode'))
        columns.append(ColumnDT('wp_nama'))
        columns.append(ColumnDT('op_kode'))
        columns.append(ColumnDT('op_nama'))
        columns.append(ColumnDT('rek_nama'))
        columns.append(ColumnDT('jumlah',  filter=_DTnumberformat))
        columns.append(ColumnDT('unit_nama'))
        query = DBSession.query(ARInvoice
                        ).filter(ARInvoice.owner_id==u, ARInvoice.status_grid==0
                        )                  
        rowTable = DataTables(req, ARInvoice, query, columns)
        return rowTable.output_result()
