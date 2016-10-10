from email.utils import parseaddr
from sqlalchemy import not_
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
      Wilayah,
      )
from daftar import (
     deferred_wilayah, daftar_wilayah, auto_wilayah_nm, deferred_wilayah1, daftar_wilayah1)
from datatables import (
    ColumnDT, DataTables)

SESS_ADD_FAILED = 'Gagal tambah wilayah'
SESS_EDIT_FAILED = 'Gagal edit wilayah'

########                    
# List #
########    
@view_config(route_name='wilayah', renderer='templates/wilayah/list.pt',
             permission='read')
def view_list(request):
    return dict(rows={})
    

#######    
# Add #
#######
def form_validator(form, value):
    def err_kode():
        raise colander.Invalid(form,
            'Kode wilayah %s sudah digunakan oleh ID %d' % (
                value['kode'], found.id))

    def err_name():
        raise colander.Invalid(form,
            'Uraian  %s sudah digunakan oleh ID %d' % (
                value['nama'], found.id))
                
    if 'id' in form.request.matchdict:
        uid = form.request.matchdict['id']
        q = DBSession.query(Wilayah).filter_by(id=uid)
        r = q.first()
    else:
        r = None
    q = DBSession.query(Wilayah).filter_by(kode=value['kode'])
    found = q.first()
    if r:
        if found and found.id != r.id:
            err_kode()
    elif found:
        err_kode()
    if 'nama' in value: # optional
        found = Wilayah.get_by_nama(value['nama'])
        if r:
            if found and found.id != r.id:
                err_name()
        elif found:
            err_name()

class AddSchema(colander.Schema):
    kode   = colander.SchemaNode(
                    colander.String(),
                              )
    nama = colander.SchemaNode(
                    colander.String())
    level_id = colander.SchemaNode(
                    colander.Integer(),
                    title="Level")
    parent_id = colander.SchemaNode(
                    colander.Integer(),
                    widget = deferred_wilayah,
                    oid="parent_id",
                    title="Parent",
                    missing=colander.drop)
    """
    parent_nm = colander.SchemaNode(
                    colander.String(),
                    widget=auto_wilayah_nm,
                    oid="parent_nm",
                    title="Parent",
                    missing=colander.drop)
    """

class EditSchema(AddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True))
                    

def get_form(request, class_form):
    schema = class_form(validator=form_validator)
    schema = schema.bind(daftar_wilayah=daftar_wilayah(),daftar_wilayah1=daftar_wilayah1())
    schema.request = request
    return Form(schema, buttons=('simpan','batal'))
    
def save(values, row=None):
    if not row:
        row = Wilayah()
    row.from_dict(values)
    if not row.parent_id or row.parent_id==0 or row.parent_id=='0':
        row.parent_id=None
    DBSession.add(row)
    DBSession.flush()
    return row
    
def save_request(values, request, row=None):
    if 'id' in request.matchdict:
        values['id'] = request.matchdict['id']
    row = save(values, row)
    request.session.flash('wilayah %s sudah disimpan.' % row.kode)
        
def route_list(request):
    return HTTPFound(location=request.route_url('wilayah'))
    
def session_failed(request, session_name):
    r = dict(form=request.session[session_name])
    del request.session[session_name]
    return r
    
@view_config(route_name='wilayah-add', renderer='templates/wilayah/add.pt',
             permission='add')
def view_add(request):
    form = get_form(request, AddSchema)
    if request.POST:
        if 'simpan' in request.POST:
            controls = request.POST.items()
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
                #request.session[SESS_ADD_FAILED] = e.render()               
                return HTTPFound(location=request.route_url('wilayah-add'))
            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, SESS_ADD_FAILED)
    return dict(form=form)#.render())

########
# Edit #
########
def query_id(request):
    return DBSession.query(Wilayah).filter_by(id=request.matchdict['id'])
    
def id_not_found(request):    
    msg = 'wilayah ID %s not found.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='wilayah-edit', renderer='templates/wilayah/edit.pt',
             permission='edit')
def view_edit(request):
    row = query_id(request).first()
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
                #request.session[SESS_EDIT_FAILED] = e.render()               
                return HTTPFound(location=request.route_url('wilayah-edit',
                                  id=row.id))
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    values['parent_id'] = row and row.parent_id or 0 
    form.set_appstruct(values)
    return dict(form=form)

##########
# Delete #
##########    
@view_config(route_name='wilayah-delete', renderer='templates/wilayah/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    if not row:
        return id_not_found(request)
    form = Form(colander.Schema(), buttons=('delete','cancel'))
    if request.POST:
        if 'delete' in request.POST:
            msg = 'wilayah ID %d %s has been deleted.' % (row.id, row.kode)
            q.delete()
            DBSession.flush()
            request.session.flash(msg)
        return route_list(request)
    return dict(row=row,
                 form=form.render())

##########
# Action #
##########    
@view_config(route_name='wilayah-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict

    if url_dict['act']=='grid':
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('kode'))
        columns.append(ColumnDT('nama'))
        columns.append(ColumnDT('level_id'))
        columns.append(ColumnDT('parent_id'))
        query = DBSession.query(Wilayah)
        rowTable = DataTables(req.GET, Wilayah, query, columns)
        return rowTable.output_result()

    elif url_dict['act']=='hon':
        term = 'term' in params and params['term'] or '' 
        rows = DBSession.query(Wilayah.id, Wilayah.nama
                  ).filter(Wilayah.nama.ilike('%%%s%%' % term) ).all()
        r = []
        for k in rows:
            d={}
            d['id']          = k[0]
            d['value']       = k[1]
            r.append(d)
        return r    

    elif url_dict['act']=='hon_fast':
        term = 'term' in params and params['term'] or '' 
        rows = DBSession.query(Wilayah.id, Wilayah.nama, Wilayah.kode
                  ).filter(Wilayah.nama.ilike('%%%s%%' % term) ).all()
        r = []
        for k in rows:
            d={}
            d['id']          = k[0]
            d['value']       = k[1]
            d['kode']        = k[2]
            r.append(d)
        return r    		
        
from ..reports.rml_report import open_rml_row, open_rml_pdf, pdf_response
def query_reg():
    return DBSession.query(Wilayah.kode, Wilayah.nama).order_by(Wilayah.kode)
    
########      
########                    
# CSV #
########          
@view_config(route_name='wilayah-csv', renderer='csv')
def view_csv(request):
    ses = request.session
    params = request.params
    url_dict = request.matchdict 
    if url_dict['csv']=='reg' :
        query = query_reg()
        row = query.first()
        header = row.keys()
        rows = []
        for item in query.all():
            rows.append(list(item))

        # override attributes of response
        filename = 'wilayah.csv'
        request.response.content_disposition = 'attachment;filename=' + filename

    return {
      'header': header,
      'rows'  : rows,
    } 
        
##########
# PDF    #
##########    
@view_config(route_name='wilayah-pdf', permission='read')
def view_pdf(request):
    params   = request.params
    url_dict = request.matchdict
    if url_dict['pdf']=='reg' :
        query = query_reg()
        rml_row = open_rml_row('wilayah.row.rml')
        rows=[]
        for r in query.all():
            s = rml_row.format(kode=r.kode, nama=r.nama)
            rows.append(s)
            
        pdf, filename = open_rml_pdf('wilayah.rml', rows=rows)
        return pdf_response(request, pdf, filename)
        