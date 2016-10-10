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
from ..security import group_in
from ..models.isipkd import(
      Pegawai, ObjekPajak, WajibPajak, ARInvoice,
      Unit, Wilayah, Pajak, Rekening, UserUnit
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
                    auto_op_nm, auto_unit_nm, auto_wp_nm
                    )
########                    
# List #
########    
@view_config(route_name='arinvoice', renderer='templates/arinvoice/list.pt',
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
        q = DBSession.query(ARInvoice).filter_by(id=uid)
        r = q.first()
    else:
        r = None
            
class MasterAddSchema(colander.Schema):
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
                    
    wajibpajak_id = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    title="Penyetor",
                    oid = "wajibpajak_id"
                    )
                    
    objekpajak_id = colander.SchemaNode(
                    colander.Integer(),
                    title="Objek",
                    widget=widget.HiddenWidget(),
                    oid = "objekpajak_id"
                    )
    objekpajak_nm = colander.SchemaNode(
                    colander.String(),
                    #widget=auto_op_nm,
                    title="Objek",
                    oid = "objekpajak_nm"
                    )
    op_nama = colander.SchemaNode(
                    colander.String(),
                    title="Nama Lain",
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
class AdminUserAddSchema(MasterAddSchema):
    wajibpajak_nm = colander.SchemaNode(
                    colander.String(),
                    #widget=auto_wp_nm,
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

class AdminAddSchema(AdminUserAddSchema):
    unit_nama = colander.SchemaNode(
                    colander.String(),
                    widget=auto_unit_nm, 
                    title="OPD",
                    oid="unit_nama"
                    )
                    
class UserAddSchema(AdminUserAddSchema):
    unit_nama = colander.SchemaNode(
                    colander.String(),
                    widget=widget.TextInputWidget(readonly=True),
                    title="OPD",
                    oid="unit_nama",
                    missing="",
                    )

class WpAddSchema(MasterAddSchema):
    unit_nama = colander.SchemaNode(
                    colander.String(),
                    widget=widget.TextInputWidget(readonly=True),
                    title="OPD",
                    oid="unit_nama"
                    )
    wajibpajak_nm = colander.SchemaNode(
                    colander.String(),
                    widget=widget.TextInputWidget(readonly=True),
                    title="Penyetor",
                    oid = "wajibpajak_nm"
                    )
                    
    wp_nama = colander.SchemaNode(
                    colander.String(),
                    widget=widget.TextInputWidget(readonly=True),
                    title="Nama Lain",
                    oid = "wp_nama"
                    )
                    
    wp_alamat_1 = colander.SchemaNode(
                    colander.String(),
                    widget=widget.TextInputWidget(readonly=True),
                    title="Alamat Subjek",
                    oid = "wp_alamat_1"
                    )

    wp_alamat_2 = colander.SchemaNode(
                    colander.String(),
                    widget=widget.TextInputWidget(readonly=True),
                    title="Alamat Subjek",
                    oid = "wp_alamat_2"
                    )                  
                    
class AdminEditSchema(AdminAddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True)
            )
            
class UserEditSchema(UserAddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True)
            )
            
class WpEditSchema(WpAddSchema):
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
    row.penambah  = re.sub("[^0-9]", "", row.penambah)
    row.pengurang  = re.sub("[^0-9]", "", row.pengurang)
    row.terutang  = re.sub("[^0-9]", "", row.terutang)
    row.denda  = re.sub("[^0-9]", "", row.denda)
    row.bunga  = re.sub("[^0-9]", "", row.bunga)
    row.jumlah = re.sub("[^0-9]", "", row.jumlah)
    
    if not row.tahun_id:
        row.tahun_id = datetime.now().strftime('%Y')
        
    unit = Unit.get_by_id(row.unit_id)
    row.unit_kode = unit.kode
    row.unit_nama = unit.nama
    
    ref = WajibPajak.get_by_id(row.wajibpajak_id)
    row.wp_kode = ref.kode
    #row.wp_nama = ref.nama
    #row.wp_alamat_1 = ref.alamat_1
    #row.wp_alamat_2 = ref.alamat_2
    
    ref = ObjekPajak.get_by_id(row.objekpajak_id)
    row.op_kode = ref.kode
    #row.op_nama = ref.nama
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
    
    # if not row.kode and not row.no_id:
        # invoice_no = DBSession.query(func.max(ARInvoice.no_id)).\
                               # filter(ARInvoice.tahun_id==row.tahun_id,
                                      # ARInvoice.unit_id==row.unit_id).scalar()
        # if not invoice_no:
            # row.no_id = 1
        # else:
            # row.no_id = invoice_no+1

    # row.kode = "".join([prefix, re.sub("[^0-9]", "", row.wilayah_kode), 
                        # str(tanggal).rjust(2,'0'), 
                        # str(bulan).rjust(2,'0'),
                        # str(tahun).rjust(2,'0'),
                        # str(row.no_id).rjust(4,'0')])

    if not row.kode and not row.no_id:
        invoice_no = DBSession.query(func.max(ARInvoice.no_id)).\
                               filter(ARInvoice.tahun_id==row.tahun_id,
                                      ARInvoice.unit_id==row.unit_id).scalar()
        if not invoice_no:
            row.no_id = 1
        else:
            row.no_id = invoice_no+1

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
    return HTTPFound(location=request.route_url('arinvoice'))
    
def session_failed(request, session_name):
    try:
        session_name.set_appstruct(request.session[SESS_ADD_FAILED])
    except:
        pass
    r = dict(form=session_name) #request.session[session_name])
    del request.session[SESS_ADD_FAILED]
    return r
    
@view_config(route_name='arinvoice-add', renderer='templates/arinvoice/add.pt',
             permission='add')
def view_add(request):
    #Initilaize data
    req = request
    values = {}
    if req.user.id!=1:
        if group_in(request,'wp'):
            row = DBSession.query(WajibPajak).\
                      filter(WajibPajak.email==req.user.email).first()
            if not row:
                request.session.flash('Default Wajib Setor Tidak Ditemukan')
                return route_list(request)
                
            values['unit_id'] = row.units.id
            values['unit_nama'] = row.units.nama
            values['wajibpajak_id'] = row.id
            values['wajibpajak_nm'] = row.nama
            values['wp_nama'] = row.nama
            values['wp_alamat_1'] = row.alamat_1
            values['wp_alamat_2'] = row.alamat_2 or '-'
            form = get_form(request, WpAddSchema)
        else:
            row = DBSession.query(Unit.id, Unit.nama).join(UserUnit).\
                      filter(UserUnit.user_id==req.user.id).first()
            if not row:
                request.session.flash('Default SKPD tidak ditemukan')
                return route_list(request)
             
            values['unit_id'] = row.id
            values['unit_nama'] = row.nama
            form = get_form(request, UserAddSchema)
    else:
        form = get_form(request, AdminAddSchema)
    #END OF INITIALIZE 
    
    if request.POST:
        if 'simpan' in request.POST:
            if 'unit_nama' not in request.POST:
                request.POST['unit_nama'] = values['unit_nama'] 
            if 'wajibpajak_nm' not in request.POST:
                request.POST['wajibpajak_nm'] = values['wajibpajak_nm']
                request.POST['wp_nama'] = values['wp_nama'] 
                request.POST['wp_alamat_1'] = values['wp_alamat_1'] 
                request.POST['wp_alamat_2'] = values['wp_alamat_2'] or None
            controls = request.POST.items()
            controls_dicted = dict(controls)
                                          
            # Cek Kode
            # if not controls_dicted['kode']=='':
                # a = form.validate(controls)
                # b = a['kode']
                # c = "%s" % b
                # cek = DBSession.query(ARInvoice).filter(ARInvoice.kode==c).first()
                # if cek :
                    # request.session.flash('Kode Bayar %s sudah digunakan.' % b, 'error')
                    # return HTTPFound(location=request.route_url('arinvoice-add'))

            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                    
                return dict(form=form)

            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, form) #SESS_ADD_FAILED)
    
    
    values['tgl_tetap']   = datetime.now()
    values['jatuh_tempo'] = datetime.now()
    values['periode_1']   = datetime.now()
    values['periode_2']   = datetime.now()
    form.set_appstruct(values)

    return dict(form=form, is_unit=0, is_sp=0)

########
# Edit #
########
def query_id(request):
    query = DBSession.query(ARInvoice).filter(ARInvoice.id==request.matchdict['id'],)
                         #ARInvoice.status_bayar==0)
    if group_in(request, 'wp'):
        query = query.join(WajibPajak).filter(WajibPajak.email==request.user.email)
    elif request.user.id > 1:
        query = query.join(Unit).join(UserUnit).\
                      filter(UserUnit.user_id==request.user.id)
    return query                      
    
def id_not_found(request):    
    msg = 'No Bayar ID %s tidak ditemukan atau sudah dibayar.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='arinvoice-edit', renderer='templates/arinvoice/add.pt',
             permission='edit')
def view_edit(request):
    row = query_id(request).first()
    if not row:
        return id_not_found(request)
    if row.status_bayar:
        request.session.flash('Data sudah masuk di Penerimaan', 'error')
        return route_list(request)
        
    uid  = row.id
    kode = row.kode
    values = {}
    if group_in(request,'wp'):
        form = get_form(request, WpEditSchema)
    elif request.user.id!=1:
        form = get_form(request, UserEditSchema)
    else:
        form = get_form(request, AdminEditSchema)
    #END OF INITIALIZE 
        
    #form = get_form(request, EditSchema)
    if request.POST:
        if 'simpan' in request.POST:
            if 'unit_nama' not in request.POST:
                request.POST['unit_nama'] = row.unit_nama
            if 'wajibpajak_nm' not in request.POST:
                request.POST['wajibpajak_nm'] = row.wp_nama
                request.POST['wp_nama'] = row.wp_nama
                request.POST['wp_alamat_1'] = row.wp_alamat_1
                request.POST['wp_alamat_2'] = row.wp_alamat_2
                
            controls = request.POST.items()
            
            # Cek kode
            # a = form.validate(controls)
            # b = a['kode']
            # c = "%s" % b
            # cek = DBSession.query(ARInvoice).filter(ARInvoice.kode==c).first()
            # if cek:
                # kode1 = DBSession.query(ARInvoice).filter(ARInvoice.id==uid).first()
                # d     = kode1.kode
                # if d!=c:
                    # request.session.flash('Kode Bayar %s sudah digunakan' % b, 'error')
                    # return HTTPFound(location=request.route_url('arinvoice-edit',id=row.id))
                    
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
                #request.session[SESS_EDIT_FAILED] = e.render()               
                return HTTPFound(location=request.route_url('arinvoice-edit',
                                  id=row.id))
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    values['objekpajak_nm'] = row.objekpajaks.nama
    values['wajibpajak_nm'] = row.wajibpajaks.nama
    values['unit_nama'] = row.units.nama
    #print values
    form.set_appstruct(values)
    return dict(form=form)

##########
# Delete #
##########    
@view_config(route_name='arinvoice-delete', renderer='templates/arinvoice/delete.pt',
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

@view_config(route_name='arinvoice-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict
    user = req.user
    awal = 'awal' in request.GET and request.GET['awal'] or datetime.now().strftime('%Y-%m-%d')
    akhir = 'akhir' in request.GET and request.GET['akhir'] or datetime.now().strftime('%Y-%m-%d')
    if url_dict['act']=='grid':
        u = request.user.id
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('kode'))
        columns.append(ColumnDT('wp_nama'))
        columns.append(ColumnDT('op_kode'))
        columns.append(ColumnDT('op_nama'))
        columns.append(ColumnDT('rek_nama'))
        columns.append(ColumnDT('terutang',  filter=_DTnumberformat))
        columns.append(ColumnDT('denda',  filter=_DTnumberformat))
        columns.append(ColumnDT('bunga',  filter=_DTnumberformat))
        columns.append(ColumnDT('jumlah',  filter=_DTnumberformat))
        columns.append(ColumnDT('unit_nama'))
        query = DBSession.query(ARInvoice)\
                         .filter(ARInvoice.tgl_tetap.between(awal,akhir))
        if group_in(request, 'wp'):
            query = query.join(WajibPajak).filter(WajibPajak.email==request.user.email)
        elif request.user.id > 1:
            query = query.join(Unit).join(UserUnit).\
                          filter(UserUnit.user_id==request.user.id)
        
        rowTable = DataTables(req.GET, ARInvoice, query, columns)
        return rowTable.output_result()
