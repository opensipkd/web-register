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
from ..tools import _DTnumberformat, _DTstrftime
from ..models import DBSession
from ..models.isipkd import(
      ObjekPajak,
      WajibPajak,
      Unit,
      Wilayah,
      Pajak,
      Rekening,
      ARTbp,
      ARInvoice,
      Unit,
	  UserUnit
      )
from ..models.__init__ import(
      UserGroup
      )
from datatables import (
    ColumnDT, DataTables)

SESS_ADD_FAILED = 'Gagal tambah Pembayaran'
SESS_EDIT_FAILED = 'Gagal edit Pembayaran'
from daftar import (STATUS, deferred_status,
                    daftar_wajibpajak, deferred_wajibpajak,
                    daftar_objekpajak, deferred_objekpajak,
                    daftar_wilayah, deferred_wilayah,
                    daftar_unit, deferred_unit,
                    daftar_pajak, deferred_pajak,
                    auto_op_nm, auto_unit_nm, auto_wp_nm
                    )
########                    
# List #
########    
@view_config(route_name='artbpinv', renderer='templates/artbpinv/list.pt',
             permission='read')
def view_list(request):
    awal = 'awal' in request.GET and request.GET['awal'] or datetime.now().strftime('%Y-%m-%d')
    akhir = 'akhir' in request.GET and request.GET['akhir'] or datetime.now().strftime('%Y-%m-%d')
    return dict(rows={"awal":awal, "akhir":akhir})

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
        q = DBSession.query(ARTbp).filter_by(id=uid)
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
                    widget=auto_unit_nm, 
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
                    widget=auto_wp_nm,
                    title="Penyetor",
                    oid = "wajibpajak_nm"
                    )
    wp_nama = colander.SchemaNode(
                    colander.String(),
                    title="Nama Lain",
                    oid = "wp_nama"
                    )                    
    wp_alamat_1 = colander.SchemaNode(
                    colander.String(),
                    title="Alamat Subjek",
                    oid = "wp_alamat_1"
                    )

    wp_alamat_2 = colander.SchemaNode(
                    colander.String(),
                    title="Alamat Subjek",
                    oid = "wp_alamat_2"
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
                    
    op_nama = colander.SchemaNode(
                    colander.String(),
                    title="Nama OP Lainnya",
                    oid = "op_nama"
                    )                    
    op_alamat_1 = colander.SchemaNode(
                    colander.String(),
                    title="Alamat Objek",
                    oid = "op_alamat_1"
                    )

    op_alamat_2 = colander.SchemaNode(
                    colander.String(),
                    title="Alamat Objek",
                    oid = "op_alamat_2"
                    )                  

    # rekening_id = colander.SchemaNode(
                    # colander.String(),
                    # #widget=widget.HiddenWidget(),
                    # title="Rekening ID",
                    # oid = "rekening_id"
                    # )                  
                    
    # rekening_nm = colander.SchemaNode(
                    # colander.String(),
                    # title="Rekening",
                    # oid = "rekening_nm"
                    # )                  
                    
    kode   = colander.SchemaNode(
                    colander.String(),
                    title="Kode",
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
    tgl_terima = colander.SchemaNode(
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
                    missing=colander.drop,
                    title = "Tarif (%)"
                    )
    pokok = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    missing=colander.drop,
                    oid = "pokok"
                    )
    penambah = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "penambah",
                    missing=colander.drop
                    )
    pengurang = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "pengurang",
                    missing=colander.drop
                    )
    terutang = colander.SchemaNode(
                    colander.Integer(),
                    default = 0,
                    widget = moneywidget,
                    oid = "terutang"
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
        row = ARTbp()
    row.from_dict(values)
    row.dasar  = re.sub("[^0-9]", "", row.dasar)
    row.tarif  = re.sub("[^0-9]", "", row.tarif)
    row.pokok  = re.sub("[^0-9]", "", row.pokok)
    row.denda  = re.sub("[^0-9]", "", row.denda)
    row.bunga  = re.sub("[^0-9]", "", row.bunga)
    row.jumlah = re.sub("[^0-9]", "", row.jumlah)
    
    if not row.tahun_id:
        row.tahun_id = datetime.now().strftime('%Y')
        
    # unit = Unit.get_by_id(row.unit_id)
    # row.unit_kd = unit.kode
    # row.unit_nm = unit.nama
    
    ref = Unit.get_by_id(row.unit_id)
    row.unit_kode = ref.kode
    row.unit_nama = ref.nama
    
    ref = WajibPajak.get_by_id(row.wajibpajak_id)
    row.wp_kode = ref.kode
    row.wp_nama = ref.nama
    #row.wp_alamat_1 = ref.alamat_1
    #row.wp_alamat_2 = ref.alamat_2
    
    ref = ObjekPajak.get_by_id(row.objekpajak_id)
    row.op_kode = ref.kode
    row.op_nama = ref.nama
    #row.op_alamat_1 = ref.alamat_1
    #row.op_alamat_2 = ref.alamat_2
    row.wilayah_id = ref.wilayah_id
    row.rekening_id = ref.pajaks.rekening_id
    row.rek_kode = ref.pajaks.rekenings.kode
    row.rek_nama = ref.pajaks.rekenings.nama
    
    ref = Wilayah.get_by_id(row.wilayah_id)
    row.wilayah_kode = ref.kode
    
    prefix  = '20' 
    tanggal = datetime.now().strftime('%d')
    bulan   = datetime.now().strftime('%m')
    tahun   = datetime.now().strftime('%y')
    
    if not row.kode and not row.no_id:
        tbp_no = DBSession.query(func.max(ARTbp.no_id)).\
                               filter(ARTbp.tahun_id==row.tahun_id,
                                      ARTbp.unit_id==row.unit_id).scalar()
        if not tbp_no:
            row.no_id = 1
        else:
            row.no_id = tbp_no+1

    row.kode = "".join([prefix, #2
                        str(tahun).rjust(2,'0'),
                        #str(bulan).rjust(2,'0'),
                        str(row.unit_id).rjust(4,'0'),
                        str(row.no_id).rjust(8,'0')])
    
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
    return HTTPFound(location=request.route_url('artbpinv'))
    
def session_failed(request, session_name):
    try:
        session_name.set_appstruct(request.session[SESS_ADD_FAILED])
    except:
        pass
    r = dict(form=session_name) #request.session[session_name])
    del request.session[SESS_ADD_FAILED]
    return r
    
@view_config(route_name='artbpinv-add', renderer='templates/artbpinv/add.pt',
             permission='add')
def view_add(request):
    
    form = get_form(request, AddSchema)
    values = {}
    values['tgl_tetap']   = datetime.now()
    values['jatuh_tempo'] = datetime.now()
    values['periode_1']   = datetime.now()
    values['periode_2']   = datetime.now()
    #TODO Defaut unit_id
    form.set_appstruct(values)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            controls_dicted = dict(controls)
            print '>>>>>>>>>>>>>>>>>>',controls_dicted
            #TODO Validate Kode
            # Cek Kode
            # if not controls_dicted['kode']=='':
                # a = form.validate(controls)
                # b = a['kode']
                # c = "%s" % b
                # cek = DBSession.query(ARInvoice).filter(ARInvoice.kode==c).first()
                # if cek :
                    # request.session.flash('Kode Bayar %s sudah digunakan.' % b, 'error')
                    # return HTTPFound(location=request.route_url('artbpinv-add'))

            try:
                c = form.validate(controls)
                #TODO validate security unitkerja
            except ValidationFailure, e:
                return dict(form=form)
                #request.session[SESS_ADD_FAILED] = request.params   
                #print e.render()
                #return HTTPFound(location=request.route_url('artbpinv-add'))
                
            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, form) #SESS_ADD_FAILED)
    return dict(form=form, is_unit=0, is_sp=0)

########
# Edit #
########
def query_id(request):
    return DBSession.query(ARTbp).filter(ARTbp.id==request.matchdict['id'],)
                         #ARInvoice.status_bayar==0)
    
def id_not_found(request):    
    msg = 'No Bayar ID %s tidak ditemukan atau sudah dibayar.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='artbpinv-edit', renderer='templates/artbpinv/add.pt',
             permission='edit')
def view_edit(request):
    row = query_id(request).first()
    uid  = row.id
    kode = row.kode

    if not row:
        return id_not_found(request)
    if row.status_invoice:
        request.session.flash('Data sudah masuk di Nomor Bayar', 'error')
        return route_list(request)
        
    form = get_form(request, EditSchema)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            
            # # Cek kode
            # a = form.validate(controls)
            # b = a['kode']
            # c = "%s" % b
            # cek = DBSession.query(ARInvoice).filter(ARInvoice.kode==c).first()
            # if cek:
                # kode1 = DBSession.query(ARInvoice).filter(ARInvoice.id==uid).first()
                # d     = kode1.kode
                # if d!=c:
                    # request.session.flash('Kode Bayar %s sudah digunakan' % b, 'error')
                    # return HTTPFound(location=request.route_url('artbpinv-edit',id=row.id))
                    
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
                #request.session[SESS_EDIT_FAILED] = e.render()               
                return HTTPFound(location=request.route_url('artbpinv-edit',
                                  id=row.id))
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    values['objekpajak_nm'] = row.objekpajaks.nama
    values['wajibpajak_nm'] = row.wajibpajaks.nama
    values['unit_nm'] = row.units.nama
    #print values
    form.set_appstruct(values)
    return dict(form=form)

##########
# Delete #
##########    
@view_config(route_name='artbpinv-delete', renderer='templates/artbpinv/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    
    if not row:
        return id_not_found(request)
    if row.status_invoice:
        request.session.flash('Data sudah masuk di No Bayar', 'error')
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
@view_config(route_name='artbpinv-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict
    user     = req.user
    if url_dict['act']=='grid':
        awal = 'awal' in request.GET and request.GET['awal'] or datetime.now().strftime('%Y-%m-%d')
        akhir = 'akhir' in request.GET and request.GET['akhir'] or datetime.now().strftime('%Y-%m-%d')	
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('kode'))
        columns.append(ColumnDT('wp_nama'))
        columns.append(ColumnDT('op_nama'))
        columns.append(ColumnDT('rek_nama'))
        columns.append(ColumnDT('tgl_terima',  filter=_DTstrftime))
        columns.append(ColumnDT('terutang',  filter=_DTnumberformat))
        columns.append(ColumnDT('denda',  filter=_DTnumberformat))
        columns.append(ColumnDT('bunga',  filter=_DTnumberformat))
        columns.append(ColumnDT('jumlah',  filter=_DTnumberformat))
        columns.append(ColumnDT('status_invoice'))
        query = DBSession.query(ARTbp)\
                         .filter(ARTbp.tgl_terima.between(awal,akhir))
        #TODO Filter BY SKPD
        rowTable = DataTables(req.GET, ARTbp, query, columns)
        return rowTable.output_result()