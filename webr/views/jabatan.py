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
      Jabatan,
      Pegawai
      )
      
from daftar import STATUS, deferred_status

from datatables import (
    ColumnDT, DataTables)

from webr.tools import (DefaultTimeZone, _DTstrftime, _DTnumberformat, 
                        _DTactive, SUMMARIES, STATUS)

SESS_ADD_FAILED = 'Gagal tambah jabatan'
SESS_EDIT_FAILED = 'Gagal edit jabatan'

########                    
# List #
########    
@view_config(route_name='jabatan', renderer='templates/jabatan/list.pt',
             permission='read')
def view_list(request):
    return dict(rows={})
    

#######    
# Add #
#######
def form_validator(form, value):
    def err_kode():
        raise colander.Invalid(form,
            'Kode Jabatan %s sudah digunakan oleh ID %d' % (
                value['kode'], found.id))

    def err_name():
        raise colander.Invalid(form,
            'Uraian  %s sudah digunakan oleh ID %d' % (
                value['nama'], found.id))
                
    if 'id' in form.request.matchdict:
        uid = form.request.matchdict['id']
        q = DBSession.query(Jabatan).filter_by(id=uid)
        r = q.first()
    else:
        r = None
    q = DBSession.query(Jabatan).filter_by(kode=value['kode'])
    found = q.first()
    if r:
        if found and found.id != r.id:
            err_kode()
    elif found:
        err_email()
    if 'uraian' in value: # optional
        found = Jabatan.get_by_uraian(value['uraian'])
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
                    colander.String(),
                    missing=colander.drop,
                    title="Uraian")
                    
    status = colander.SchemaNode(
                    colander.Integer(),
                    #widget=deferred_status,
                    widget=widget.SelectWidget(values=STATUS),
                    title="Status")


class EditSchema(AddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True))
                    

def get_form(request, class_form):
    schema = class_form(validator=form_validator)
    schema = schema.bind(daftar_summary=STATUS)
    schema.request = request
    return Form(schema, buttons=('simpan','batal'))
    
def save(values, row=None):
    if not row:
        row = Jabatan()
    row.from_dict(values)
    #if values['password']:
    #    row.password = values['password']
    DBSession.add(row)
    DBSession.flush()
    return row
    
def save_request(values, request, row=None):
    if 'id' in request.matchdict:
        values['id'] = request.matchdict['id']
    print "****",values, "****", request
    row = save(values, row)
    request.session.flash('Jabatan %s sudah disimpan.' % row.kode)
        
def route_list(request):
    return HTTPFound(location=request.route_url('jabatan'))
    
def session_failed(request, session_name):
    r = dict(form=request.session[session_name])
    del request.session[session_name]
    return r
    
@view_config(route_name='jabatan-add', renderer='templates/jabatan/add.pt',
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
                return HTTPFound(location=request.route_url('jabatan-add'))
            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, SESS_ADD_FAILED)
    return dict(form=form)#.render())

########
# Edit #
########
def query_id(request):
    return DBSession.query(Jabatan).filter_by(id=request.matchdict['id'])
    
def id_not_found(request):    
    msg = 'Jabatan ID %s not found.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='jabatan-edit', renderer='templates/jabatan/edit.pt',
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
                return HTTPFound(location=request.route_url('jabatan-edit',
                                  id=row.id))
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    #print values
    form.set_appstruct(values)
    return dict(form=form)#.render(appstruct=values))

##########
# Delete #
##########    
@view_config(route_name='jabatan-delete', renderer='templates/jabatan/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    id = row.id
    if not row:
        return id_not_found(request)
    form = Form(colander.Schema(), buttons=('delete','cancel'))
    if request.POST:
        if 'delete' in request.POST:
            x = DBSession.query(Pegawai).filter(Pegawai.jabatan_id==id).first()
            if x:
                request.session.flash('Tidak bisa dihapus, karena jabatan sudah terpakai.','error')
            else:
                msg = 'Jabatan ID %d %s has been deleted.' % (row.id, row.kode)
                q.delete()
                DBSession.flush()
                request.session.flash(msg)
        return route_list(request)
    return dict(row=row,
                 form=form.render())

##########
# Action #
##########    
@view_config(route_name='jabatan-act', renderer='json',
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
        columns.append(ColumnDT('status', filter=_DTactive))
        query = DBSession.query(Jabatan)
        rowTable = DataTables(req.GET, Jabatan, query, columns)
        return rowTable.output_result()

from ..reports.rml_report import open_rml_row, open_rml_pdf, pdf_response
def query_reg():
    return DBSession.query(Jabatan.kode, Jabatan.nama).order_by(Jabatan.kode)
    
########      
########                    
# CSV #
########          
@view_config(route_name='jabatan-csv', renderer='csv')
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
        filename = 'jabatan.csv'
        request.response.content_disposition = 'attachment;filename=' + filename

    return {
      'header': header,
      'rows'  : rows,
    } 
        
##########
# PDF    #
##########    
@view_config(route_name='jabatan-pdf', permission='read')
def view_pdf(request):
    params   = request.params
    url_dict = request.matchdict
    if url_dict['pdf']=='reg' :
        query = query_reg()
        rml_row = open_rml_row('jabatan.row.rml')
        rows=[]
        for r in query.all():
            s = rml_row.format(kode=r.kode, nama=r.nama)
            rows.append(s)
            
        pdf, filename = open_rml_pdf('jabatan.rml', rows=rows)
        return pdf_response(request, pdf, filename)
        