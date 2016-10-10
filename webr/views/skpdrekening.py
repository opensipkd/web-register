from email.utils import parseaddr
from sqlalchemy import not_, or_, func
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
from ..models import (
    DBSession,
    User,
    )
from ..models.isipkd import(
    Rekening,
    UnitRekening,
    Unit
    )
from daftar import (daftar_unit,deferred_unit, 
                    daftar_rekening, deferred_rekening)
from datatables import (
    ColumnDT, DataTables)

from webr.tools import DefaultTimeZone, _DTstrftime, _DTnumberformat, _DTactive, STATUS

SESS_ADD_FAILED = 'userunit add failed'
SESS_EDIT_FAILED = 'userunit edit failed'

########                    
# List #
########    
@view_config(route_name='skpd-rekening', renderer='templates/skpdrekening/list.pt',
             permission='read')
def view_list(request):
    rows = DBSession.query(User).filter(User.id > 0).order_by('email')
    return dict(rows=rows)
    

#######    
# Add #
#######

def form_validator(form, value):
    def err_unit():
        raise colander.Invalid(form,
            'User Unit sudah ada dalam database')

class AddSchema(colander.Schema):
    unit_id  = colander.SchemaNode(
                    colander.Integer(),
                    widget = deferred_unit,
                    oid="unit_id",
                    title="OPD")
    """
    user_nm = colander.SchemaNode(
                    colander.String(),
                    widget = auto_user_nm,
                    oid = "user_nm",
                    title="User")
    """
    rekening_id = colander.SchemaNode(
                    colander.Integer(),
                    widget = deferred_rekening,
                    oid="rekening_id",
                    title="Kode Rekening")
    """
    unit_nm  = colander.SchemaNode(
                    colander.String(),
                    widget = auto_unit_nm,
                    oid = 'unit_nm',
                    title="OPD")
    """

def get_form(request, class_form):
    schema = class_form(validator=form_validator)
    schema = schema.bind(daftar_rekening = daftar_rekening(),
                         daftar_unit = daftar_unit())
    schema.request = request
    return Form(schema, buttons=('save','cancel'))
    
def save(values, row=None):
    if not row:
        row = UnitRekening()
    row.from_dict(values)
    DBSession.add(row)
    DBSession.flush()
    return row


def query_unit_member(values):
    row_unit = DBSession.query(Unit).filter_by(id=values['unit_id']).first()
    row_unit.member_count = DBSession.query(
                                  func.count(skpdrekening.user_id).label('c')).filter(
                                             skpdrekening.unit_id==values['unit_id']).first().c
    DBSession.add(row_unit)
    
def save_request(values, request, row=None):
    if 'id' in request.matchdict:
        values['id'] = request.matchdict['id']
    row = save(values, row)
    request.session.flash('Rekening OPD sudah disimpan.')
        
def route_list(request):
    return HTTPFound(location=request.route_url('skpd-rekening'))
    
def session_failed(request, session_name):
    r = dict(form=request.session[session_name])
    del request.session[session_name]
    return r
    
@view_config(route_name='skpd-rekening-add', renderer='templates/skpdrekening/add.pt',
             permission='add')
def view_add(request):
    form = get_form(request, AddSchema)
    if request.POST:
        if 'save' in request.POST:
            controls = request.POST.items()
            #controls['email'] = controls['email'] or controls['skpdrekening_name']+'@local'
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
                #request.session[SESS_ADD_FAILED] = e.render()               
                return HTTPFound(location=request.route_url('skpd-rekening-add'))
            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, SESS_ADD_FAILED)
    return dict(form=form)#.render())

########
# Edit #
########
def query_id(request):
    return DBSession.query(UnitRekening).filter(UnitRekening.id==request.matchdict['id'])
    
def id_not_found(request):    
    msg = 'Data Tidak Ditemukan'
    request.session.flash(msg, 'error')
    return route_list(request)

##########
# Delete #
##########    
@view_config(route_name='skpd-rekening-delete', renderer='templates/skpdrekening/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    if not row:
        return id_not_found(request)
    form = Form(colander.Schema(), buttons=('delete','cancel'))
    values= {}
    if request.POST:
        if 'delete' in request.POST:
            values['id'] = request.matchdict['id']
            msg = 'Rekening ID %s OPD %s sudah di hapus.' % (row.rekenings.kode, row.units.kode)
            row = DBSession.query(UnitRekening).filter(UnitRekening.id==values['id'])\
                      .delete()
            DBSession.flush()
            request.session.flash(msg)
        return route_list(request)
    return dict(row=row, form=form.render())
                 
##########
# Action #
##########    
@view_config(route_name='skpd-rekening-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict

    if url_dict['act']=='grid':
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('unit_id'))
        columns.append(ColumnDT('rekening_id'))
        columns.append(ColumnDT('units.kode'))
        columns.append(ColumnDT('units.nama'))
        columns.append(ColumnDT('rekenings.kode'))
        columns.append(ColumnDT('rekenings.nama'))
        
        query = DBSession.query(UnitRekening).join(Unit).join(Rekening)
        rowTable = DataTables(req.GET, UnitRekening, query, columns)
        return rowTable.output_result()

    if url_dict['act']=='grid1':
        cari = 'cari' in params and params['cari'] or ''
        columns = []
        columns.append(ColumnDT('user_id'))
        columns.append(ColumnDT('unit_id'))
        columns.append(ColumnDT('user_name'))
        columns.append(ColumnDT('nama'))
        
        query = DBSession.query(skpdrekening.user_id, skpdrekening.unit_id, User.user_name, Unit.nama).\
                          join(User).join(Unit).\
                          filter(or_(User.user_name.ilike('%%%s%%' % cari),Unit.nama.ilike('%%%s%%' % cari)))
        rowTable = DataTables(req, skpdrekening, query, columns)
        return rowTable.output_result()
