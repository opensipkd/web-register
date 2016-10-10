from email.utils import parseaddr
from sqlalchemy import not_, func
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
from ..models import DBSession
from ..models.isipkd import(
      ObjekPajak,
      WajibPajak,
      Unit,
      UserUnit,
      Wilayah,
      Pajak,
      Rekening,
      ARInvoice,
      User
      )
from ..models.__init__ import(
      UserGroup
      )
from datatables import (
    ColumnDT, DataTables)
    
from daftar import (STATUS, deferred_status,
                    daftar_wajibpajak, deferred_wajibpajak,
                    daftar_wilayah, deferred_wilayah,
                    daftar_unit, deferred_unit,
                    daftar_pajak, deferred_pajak, 
                    auto_wp_nm,
                    auto_pajak_nm
                    )
from ..tools import _DTactive
SESS_ADD_FAILED = 'Gagal tambah Objek Pajak'
SESS_EDIT_FAILED = 'Gagal edit Objek Pajak'
from daftar import STATUS
########                    
# List #
########    
@view_config(route_name='op', renderer='templates/op/list.pt',
             permission='read')
def view_list(request):
    return dict(rows={})
    

#######    
# Add #
#######

class AddSchema(colander.Schema):
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
    # wajibpajak_us = colander.SchemaNode(
                    # colander.Integer(),
                    # widget=widget.HiddenWidget(),
                    # oid = "wajibpajak_us"
                    # )
    # wajibpajak_un = colander.SchemaNode(
                    # colander.Integer(),
                    # widget=widget.HiddenWidget(),
                    # oid = "wajibpajak_un"
                    # )
    unit_id = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    oid="unit_id",
                    title="OPD",
                    )
    # unit_nm = colander.SchemaNode(
                    # colander.String(),
                    # widget=widget.HiddenWidget(),
                    # title="OPD",
                    # oid="unit_nm"
                    # )
    wilayah_id = colander.SchemaNode(
                    colander.Integer(),
                    widget=deferred_wilayah,
                    title="Wilayah"
                    )
    pajak_id = colander.SchemaNode(
                    colander.Integer(),
                    widget=widget.HiddenWidget(),
                    oid="pajak_id",
                    #widget=deferred_pajak,
                    #title="Rekening"
                    )
					
    pajak_nm = colander.SchemaNode(
                    colander.String(),
                    #widget=auto_pajak_nm,
                    title="Rekening",
                    oid="pajak_nm"
                    )
    kode   = colander.SchemaNode(
                    colander.String(),
                    #widget=widget.HiddenWidget(),
                    oid="kode",
                    missing=colander.drop)
    nama = colander.SchemaNode(
                    colander.String(),
                    #widget=widget.HiddenWidget(),
                    oid="nama",
                    missing=colander.drop)
    status = colander.SchemaNode(
                    colander.Integer(),
                    widget=deferred_status,
                    title="Status")

class EditSchema(AddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True),
            title="")
                    

def get_form(request, class_form):
    schema = class_form()
    schema = schema.bind(daftar_status=STATUS,
                         daftar_wajibpajak=daftar_wajibpajak(),
                         daftar_pajak=daftar_pajak(),
                         #daftar_unit=daftar_unit(),
                         daftar_wilayah=daftar_wilayah())
    schema.request = request
    return Form(schema, buttons=('simpan','batal'))
    
def save(values, row=None):
    if not row:
        row = ObjekPajak()
    row.from_dict(values)
	
    p = values['pajak_id']
    x = values['kode']
    y = values['nama']
    if not x and not y:
        row1 = DBSession.query(Pajak).filter(Pajak.id==p).first()
        row.kode = row1.kode
        row.nama = row1.nama

    DBSession.add(row)
    DBSession.flush()
    return row
    
def save_request(values, request, row=None):
    if 'id' in request.matchdict:
        values['id'] = request.matchdict['id']
    print "****",values, "****", request
    row = save(values, row)
    request.session.flash('Objek %s sudah disimpan.' % row.kode)
        
def route_list(request):
    return HTTPFound(location=request.route_url('op'))
    
def session_failed(request, session_name):
    r = dict(form=request.session[session_name])
    del request.session[session_name]
    return r
    
@view_config(route_name='op-add', renderer='templates/op/add.pt',
             permission='add')
def view_add(request):
    form = get_form(request, AddSchema)
    values = {}
    # u = request.user.id
    # print '----------------User_Login---------------',u
    # x = DBSession.query(UserGroup.group_id).filter(UserGroup.user_id==u).first()
    # y = '%s' % x
    # z = int(y)        
    # print '----------------Group_id-----------------',z
    
    # if z == 1:
        # a = DBSession.query(User.email).filter(User.id==u).first()
        # print '----------------Email---------------------',a
        # rows = DBSession.query(WajibPajak.id.label('sid'), WajibPajak.nama.label('snm'), WajibPajak.unit_id.label('sui'), WajibPajak.user_id.label('sus'),
                       # ).filter(WajibPajak.email==a,
                       # ).first()
        # values['wajibpajak_id'] = rows.sid
        # print '----------------Subjek id-----------------------',values['wajibpajak_id']
        # values['wajibpajak_nm'] = rows.snm
        # print '----------------Subjek nama---------------------',values['wajibpajak_nm']
        # values['wajibpajak_us'] = rows.sus
        # print '----------------Subjek user---------------------',values['wajibpajak_us']
        # values['wajibpajak_un'] = rows.sui
        # print '----------------Subjek unit 1-------------------',values['wajibpajak_un']
        # values['unit_id'] = rows.sui
        # print '----------------Subjek unit---------------------',values['unit_id'] 
        # unit = DBSession.query(Unit.nama.label('unm')
                       # ).filter(Unit.id==values['unit_id'],
                       # ).first()
        # values['unit_nm'] = unit.unm	
        # print '----------------Unit nama-----------------------',values['unit_nm'] 
		
    # elif z == 2:
        # print '----------------User_id-------------------',u
        # a = DBSession.query(UserUnit.unit_id).filter(UserUnit.user_id==u).first()
        # b = '%s' % a
        # c = int(b)
        # values['unit_id'] = c
        # print '----------------Unit id-------------------------',values['unit_id'] 
        # unit = DBSession.query(Unit.nama.label('unm')
                       # ).filter(Unit.id==c,
                       # ).first()
        # values['unit_nm'] = unit.unm
        # print '----------------Unit nama-----------------------',values['unit_nm'] 

    # form.set_appstruct(values)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            try:
                c = form.validate(controls)
                #TODO: Cek WP/BENDAHARA disini
            except ValidationFailure, e:
                return dict(form=form)
            
            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, SESS_ADD_FAILED)
    return dict(form=form)

########
# Edit #
########
def query_id(request):
    query =  DBSession.query(ObjekPajak).filter_by(id=request.matchdict['id'])
    if request.user.id != 1:
        query = query.join(WajibPajak).join(Unit).join(UserUnit).\
                      filter(UserUnit.user_id==request.user.id)
    return query
    
def id_not_found(request):    
    msg = 'Objek ID %s not found.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='op-edit', renderer='templates/op/add.pt',
             permission='edit')
def view_edit(request):
    row = query_id(request).first()
    id  = row.id
    
    if not row:
        return id_not_found(request)
        
    form = get_form(request, EditSchema)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    values['wajibpajak_nm']  = row and row.wajibpajaks.nama or None
    values['unit_id']        = row and row.wajibpajaks.units.id        or None
    values['pajak_nm']       = row and row.pajaks.nama       or None
    form.set_appstruct(values)
    return dict(form=form)

##########
# Delete #
##########    
@view_config(route_name='op-delete', renderer='templates/op/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    if not row:
        return id_not_found(request)
    id = row.id
    x = DBSession.query(ARInvoice).filter(ARInvoice.objekpajak_id==id).first()
    if x:
        request.session.flash('Tidak bisa dihapus, karena objek sudah digunakan di daftar bayar.','error')
        return route_list(request)
    form = Form(colander.Schema(), buttons=('delete','cancel'))
    if request.POST:
        if 'delete' in request.POST:
            msg = 'Objek %s sudah dihapus.' % (row.kode)
            q.delete()
            DBSession.flush()
            request.session.flash(msg)
        return route_list(request)
    return dict(row=row, form=form.render())

##########
# Action #
##########    
@view_config(route_name='op-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict
    if url_dict['act']=='grid':
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('wajibpajaks.nama'))
        columns.append(ColumnDT('kode'))
        columns.append(ColumnDT('nama'))
        columns.append(ColumnDT('pajaks.kode'))
        columns.append(ColumnDT('wilayahs.nama'))
        columns.append(ColumnDT('status', filter=_DTactive))
        query = DBSession.query(ObjekPajak).join(WajibPajak).outerjoin(Pajak).\
                          outerjoin(Wilayah)
        if request.user.id != 1:
            query = query.join(Unit).join(UserUnit).\
                          filter(UserUnit.user_id==request.user.id)
                      
        
        rowTable = DataTables(req.GET, ObjekPajak, query, columns)
        return rowTable.output_result()

    elif url_dict['act']=='hon':
        term = 'term' in params and params['term'] or '' 
        query = DBSession.query(ObjekPajak).join(Pajak).\
                         filter(ObjekPajak.nama.ilike('%%%s%%' % term))
        
        wp_id = 'wpid' in req.params and req.params['wpid'] or None
        if wp_id:
            query = query.filter(ObjekPajak.wajibpajak_id==wp_id)
            
        rows = query.all()
        r = []
        for k in rows:
            d={}
            d['id']          = k.id
            d['value']       = k.nama
            d['alamat_1']    = k.alamat_1
            d['alamat_2']    = k.alamat_2
            d['tarif']       = k.pajaks.tarif
            r.append(d)
        return r             

    elif url_dict['act']=='hon1':
        x = request.user.id
        term = 'term' in params and params['term'] or '' 
		
        d    = DBSession.query(User.email).filter(User.id==x).first()
		
        rows = DBSession.query(ObjekPajak).join(WajibPajak).join(Pajak).\
                         filter(ObjekPajak.nama.ilike('%%%s%%' % term),
                                ObjekPajak.wajibpajak_id==WajibPajak.id,
                                WajibPajak.email==d,
                                ObjekPajak.pajak_id==Pajak.id).all()
        r = []
        for k in rows:
            print k
            d={}
            d['id']          = k.id
            d['value']       = k.nama
            d['sp_id']       = k.wajibpajaks.id
            d['sp_nm']       = k.wajibpajaks.nama
            d['unit_id']     = k.units.id
            d['unit_nm']     = k.units.nama
            d['tarif']       = k.pajaks.tarif
            
            r.append(d)
        return r         