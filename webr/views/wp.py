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
from ..tools import (email_validator,BULANS, captcha_submit, get_settings)
from ..models import DBSession, User, UserGroup, Group
from ..models.isipkd import(
      WajibPajak,
      ARInvoice,
      Unit,
      UserUnit
      )

from datatables import (
    ColumnDT, DataTables)

from daftar import (STATUS, deferred_status,
                    daftar_user, deferred_user)

from ..tools import _DTactive
SESS_ADD_FAILED = 'Gagal tambah wp'
SESS_EDIT_FAILED = 'Gagal edit wp'

########                    
# List #
########    
@view_config(route_name='wp', renderer='templates/wp/list.pt',
             permission='read')
def view_list(request):
    return dict(rows={})

#######    
# Add #
#######
def form_validator(form, value):
    def err_kode():
        raise colander.Invalid(form,
            'Kode wp %s sudah digunakan oleh ID %d' % (
                value['kode'], found.id))

    def err_name():
        raise colander.Invalid(form,
            'Nama  %s sudah digunakan oleh ID %d' % (
                value['nama'], found.id))
                
    def err_user():
        raise colander.Invalid(form,
            'User ID  %s sudah digunakan oleh ID %d' % (
                value['user_id'], found.id))
                
    if 'id' in form.request.matchdict:
        uid = form.request.matchdict['id']
        q = DBSession.query(WajibPajak).filter_by(id=uid)
        r = q.first()
    else:
        r = None
    q = DBSession.query(WajibPajak).filter_by(kode=value['kode'])
    found = q.first()
    if r:
        if found and found.id != r.id:
            err_kode()
    elif found:
        err_kode()
    if 'nama' in value: # optional
        found = WajibPajak.get_by_nama(value['nama'])
        if r:
            if found and found.id != r.id:
                err_name()
        elif found:
            err_name()
    if 'user_id' in value and int(value['user_id'])>0:
        found = WajibPajak.get_by_user_wp(value['user_id'])
        if r:
            if found and found.id != r.id:
                err_user()
        elif found:
            err_user()
    if 'login' in value: # and int(value['user_id'])==0:
        found = User.get_by_name(value['kode'])
        if r:
            if found and found.id != r.id:
                err_user()
        elif found:
            err_user()

class MasterSchema(colander.Schema):
    '''
    user_id  = colander.SchemaNode(
                    colander.Integer(),
                    widget = deferred_user,
                    #oid="user_id",
                    title="User")
    '''
    kode     = colander.SchemaNode(
                    colander.String(),
                    title ="Kode Penyetor"
               )
    nama     = colander.SchemaNode(
                    colander.String()
               )
    alamat_1 = colander.SchemaNode(
                    colander.String(),
                    title ="Alamat1"
               )
    alamat_2 = colander.SchemaNode(
                    colander.String(),
                    title ="Alamat2"
               )
    kelurahan = colander.SchemaNode(
                    colander.String(),
                    missing=colander.drop
               )
    kecamatan = colander.SchemaNode(
                    colander.String(),
                    missing=colander.drop
               )
    kota     = colander.SchemaNode(
                    colander.String(),
                    missing=colander.drop
               )
    provinsi = colander.SchemaNode(
                    colander.String(),
                    missing=colander.drop
               )
               
    status   = colander.SchemaNode(
                    colander.Integer(),
                    widget=deferred_status,
                    title="Status")
    login    = colander.SchemaNode(
                    colander.Boolean(),
                    missing = colander.drop,
                    title='Buat Login'
               )
    email    = colander.SchemaNode(
                  colander.String(),
                  validator=email_validator,
                  title = 'E-Mail',
                  missing=colander.drop,
                  oid = 'email'
                  )
    unit_id = colander.SchemaNode(
                  colander.Integer(),
                  widget=widget.HiddenWidget(),
                  oid="unit_id",
                  title="OPD",
                  )
                  
class AdminAddSchema(MasterSchema):
    unit_nm = colander.SchemaNode(
                  colander.String(),
                  title="OPD",
                  oid="unit_nm",
                  )
                  
class UserAddSchema(MasterSchema):
    unit_nm = colander.SchemaNode(
                  colander.String(),
                  title="OPD",
                  oid="unit_nm",
                  widget=widget.TextInputWidget(readonly=True),
                  missing="",
                  )
                    
class AdminEditSchema(AdminAddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True),
            title="")
                    
class UserEditSchema(UserAddSchema):
    id = colander.SchemaNode(colander.Integer(),
            missing=colander.drop,
            widget=widget.HiddenWidget(readonly=True),
            title="")

def get_form(request, class_form):
    schema = class_form(validator=form_validator)
    schema = schema.bind(daftar_status=STATUS,
                         daftar_user=daftar_user(),
                         )
    schema.request = request
    return Form(schema, buttons=('simpan','batal'))
    
def save(request,values, row=None):
    login = None

    if not row:
        row = WajibPajak()
    row.from_dict(values)
    
    #Sementara untuk user yg masuk ke Subjek adalah user yg login dan yg menginputkan data subjek (Bukan subjek yg dibuatkan user login)
    if login:
        row.user_id=request.user.id #login.id
    else:
        row.user_id=request.user.id
        
    if not row.user_id:
        row.user_id=None
        
    DBSession.add(row)
    DBSession.flush()
    
    if 'login' in values and values['login']:
        login = User()
        login.status        = values['status'] 
        login.user_name     = values['email']
        login.email         = values['email']
        login.password      = values['kode']
        DBSession.add(login)
        DBSession.flush()
        
        if login.id:
            q = DBSession.query(UserGroup).join(Group).filter(UserGroup.user_id==login.id,
                                                Group.group_name=='wp').first()
            if not q:
                usergroup = UserGroup()
                usergroup.user_id  = login.id
                usergroup.group_id = DBSession.query(Group.id).filter_by(group_name='wp').scalar()
                DBSession.add(usergroup)
                DBSession.flush()
                
                userunit = UserUnit()
                userunit.user_id  = login.id
                userunit.unit_id = DBSession.query(Unit.id).filter_by(id=row.unit_id).scalar()
                DBSession.add(userunit)
                DBSession.flush()
                
    return row
    
def save_request(values, request, row=None):
    if 'id' in request.matchdict:
        values['id'] = request.matchdict['id']
    row = save(request, values, row)
    print '----------------ROW-------------------',row
    if row:
        request.session.flash('Penyetor sudah disimpan.')
        
def route_list(request):
    return HTTPFound(location=request.route_url('wp'))
    
def session_failed(request, session_name):
    r = dict(form=request.session[session_name])
    del request.session[session_name]
    return r
    
@view_config(route_name='wp-add', renderer='templates/wp/add.pt',
             permission='add')
def view_add(request):
    req = request
    values = {}
    if req.user.id!=1:
        row = DBSession.query(Unit.id, Unit.nama).join(UserUnit).\
                  filter(UserUnit.user_id==req.user.id).first()
        if not row:
            request.session.flash('Default SKPD Tidak Ditemukan')
            return route_list(request)
        values['unit_id'] = row.id
        values['unit_nm'] = row.nama
        form = get_form(request, UserAddSchema)
    else:
        form = get_form(request, AdminAddSchema)

    if request.POST:
        if 'simpan' in request.POST:
            if 'unit_nm' not in request.POST:
                request.POST['unit_nm']=values['unit_nm']

            controls = request.POST.items()
            controls_dicted = dict(controls)

            #Cek Email sama ato tidak
            # a = form.validate(controls)
            # b = controls_dicted['email']
            # d = a['login']
            # e = "%s" % d
            # if e == 'True':
                # if b != '':
                    # c = "%s" % b
                    # cek = DBSession.query(User).filter(User.email==c).first()
                    # if cek :
                        # request.session.flash('Email sudah digunakan.', 'error')
                        # return HTTPFound(location=request.route_url('wp-add'))
                # else:
                    # request.session.flash('Email harus diisi.','error')
                    # return HTTPFound(location=request.route_url('wp-add'))
            # else:
                # if b != '':
                    # c = "%s" % b
                    # cek = DBSession.query(User).filter(User.email==c).first()
                    # if cek :
                        # request.session.flash('Email sudah digunakan.', 'error')
                        # return HTTPFound(location=request.route_url('wp-add'))

            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)

            save_request(dict(controls), request)
        return route_list(request)
    elif SESS_ADD_FAILED in request.session:
        return session_failed(request, SESS_ADD_FAILED)
    form.set_appstruct(values)
    return dict(form=form)

########
# Edit #
########
def query_id(request):
    query = DBSession.query(WajibPajak).filter_by(id=request.matchdict['id'])
    if request.user.id!=1:
        query = query.join(Unit).join(UserUnit).filter(UserUnit.user_id==request.user.id)
    return query
    
def id_not_found(request):    
    msg = 'Penyetor ID %s not found.' % request.matchdict['id']
    request.session.flash(msg, 'error')
    return route_list(request)

@view_config(route_name='wp-edit', renderer='templates/wp/edit.pt',
             permission='edit')
def view_edit(request):
    req = request
    row = query_id(request).first()
    if not row:
        return id_not_found(request)
    #uid = row.id
    #email = row.email
    #found = 0
    
    #x = DBSession.query(ARInvoice).filter(ARInvoice.wajibpajak_id==uid).first()
    #if x:
    #    request.session.flash('Tidak bisa diedit, karena penyetor sudah digunakan di daftar bayar.','error')
    #    return route_list(request)
    
    if req.user.id!=1:
        form = get_form(request, UserEditSchema)
    else:
        form = get_form(request, AdminEditSchema)

    if request.POST:
        if 'simpan' in request.POST:
            if 'unit_nm' not in request.POST:
                request.POST['unit_nm']=row.units.nama
            controls = request.POST.items()
            controls_dicted = dict(controls)
            
            #Cek Email sama ato tidak
            #a = form.validate(controls)
            #b = controls_dicted['email']
            #d = a['login']
            #e = "%s" % d
            #if e == 'True':
            #    if b != '':
            #        c = "%s" % b
            #        cek = DBSession.query(User).filter(User.email==c).first()
            #        if cek :
            #            request.session.flash('Email sudah digunakan.', 'error')
            #            return HTTPFound(location=request.route_url('wp-edit',id=row.id))
            #    else:
            #        request.session.flash('Email harus diisi.','error')
            #        return HTTPFound(location=request.route_url('wp-edit',id=row.id))
                        
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                return dict(form=form)
                
            save_request(dict(controls), request, row)
        return route_list(request)
    elif SESS_EDIT_FAILED in request.session:
        return session_failed(request, SESS_EDIT_FAILED)
    values = row.to_dict()
    
    if row.alamat_2 == None:
        values['alamat_2']  = ''
    else:
        values['alamat_2']  = row.alamat_2
    
    if row.kelurahan == None:
        values['kelurahan'] = ''
    else:    
        values['kelurahan'] = row.kelurahan
        
    if row.kecamatan == None:
        values['kecamatan'] = ''
    else:
        values['kecamatan'] = row.kecamatan
    
    if row.kota == None:
        values['kota']  = ''
    else:
        values['kota']  = row.kota
    
    if row.provinsi == None: 
        values['provinsi']  = ''
    else:
        values['provinsi']  = row.provinsi
    
    if row.email == None:
        values['email']  = ''
    else:
        values['email']  = row.email
    
    cek = DBSession.query(User).filter(User.email==row.email).first()
    if cek:
        values['login']  = 1
    
    values['unit_nm'] = row and row.units.nama or None
    
    form.set_appstruct(values)
    return dict(form=form)

##########
# Delete #
##########    
@view_config(route_name='wp-delete', renderer='templates/wp/delete.pt',
             permission='delete')
def view_delete(request):
    q = query_id(request)
    row = q.first()
    if not row:
        return id_not_found(request)
    id = row.id
    
    x = DBSession.query(ARInvoice).filter(ARInvoice.wajibpajak_id==id).first()
    if x:
        request.session.flash('Tidak bisa dihapus, karena penyetor sudah digunakan di daftar bayar.','error')
        return route_list(request)
        
    form = Form(colander.Schema(), buttons=('delete','cancel'))
    if request.POST:
        if 'delete' in request.POST:
            msg = 'Penyetor %s sudah dihapus.' % (row.kode)
            q.delete()
            DBSession.flush()
            request.session.flash(msg)
        return route_list(request)
    return dict(row=row, form=form.render())

##########
# Action #
##########    
@view_config(route_name='wp-act', renderer='json',
             permission='read')
def view_act(request):
    req      = request
    params   = req.params
    url_dict = req.matchdict

    if url_dict['act']=='grid':
        u = request.user.id
        columns = []
        columns.append(ColumnDT('id'))
        columns.append(ColumnDT('kode'))
        columns.append(ColumnDT('nama'))
        columns.append(ColumnDT('alamat_1'))
        columns.append(ColumnDT('alamat_2'))
        columns.append(ColumnDT('status', filter=_DTactive))
        columns.append(ColumnDT('units.nama'))
        query = DBSession.query(WajibPajak).join(Unit)
        if req.user.id!=1:
            query = query.join(UserUnit).filter(UserUnit.user_id==req.user.id)
        #TODO : Add filter BY User SKPD                
        #                .filter(WajibPajak.user_id==u)
        
        rowTable = DataTables(req.GET, WajibPajak, query, columns)
        return rowTable.output_result()

    elif url_dict['act']=='hon':
        term = 'term' in params and params['term'] or '' 
        query = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.alamat_1, WajibPajak.alamat_2,WajibPajak.unit_id).\
                         filter(WajibPajak.nama.ilike('%%%s%%' % term) )
        if req.user.id!=1:
            query = query.filter(WajibPajak.unit_id==UserUnit.unit_id,
                                 UserUnit.user_id==req.user.id,)
            
        unit_id = 'unitid' in params and params['unitid'] or None
        if unit_id:
            query = query.filter(WajibPajak.unit_id==unit_id)
        
        rows = query.all()
        
        r = []
        for k in rows:
            d={}
            if len(rows)==1:
                req.session['a_wp_id']=k[0]
                
            d['id']          = k[0]
            d['value']       = k[1]
            d['alamat_1']    = k[2]
            d['alamat_2']    = k[3]
            d['unit_id']     = k[4]
            r.append(d)
            
        return r                  

    ## BUD ##
    elif url_dict['act']=='hon1':
        term = 'term' in params and params['term'] or '' 
        rows = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.user_id, WajibPajak.unit_id
                  ).filter(WajibPajak.nama.ilike('%%%s%%' % term) ).all()
        r = []
        for k in rows:
            d={}
            d['id']          = k[0]
            d['value']       = k[1]
            d['user']        = k[2]
            d['unit']        = k[3]
            r.append(d)
        return r                  

    ## Bendahara ##
    elif url_dict['act']=='hon2':
        term = 'term' in params and params['term'] or '' 
        u = request.user.id
        rows = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.user_id, WajibPajak.unit_id
                  ).filter(WajibPajak.nama.ilike('%%%s%%' % term),
                           WajibPajak.user_id==u).all()
        r = []
        for k in rows:
            d={}
            d['id']          = k[0]
            d['value']       = k[1]
            d['user']        = k[2]
            d['unit']        = k[3]
            r.append(d)
        return r                  

    ## WP ##
    elif url_dict['act']=='hon3':
        term = 'term' in params and params['term'] or '' 
        u = request.user.id
        a = DBSession.query(User.email).filter(User.id==u).first()
        rows = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.user_id, WajibPajak.unit_id
                  ).filter(WajibPajak.nama.ilike('%%%s%%' % term), 
                           WajibPajak.email==a).all()
        r = []
        for k in rows:
            d={}
            d['id']          = k[0]
            d['value']       = k[1]
            d['user']        = k[2]
            d['unit']        = k[3]
            r.append(d)
        return r   
        
    elif url_dict['act']=='ho_objek':
        term = 'term' in params and params['term'] or '' 
        
        u = request.user.id
        print '----------------User_Login---------------',u
        x = DBSession.query(UserGroup.group_id).filter(UserGroup.user_id==u).first()
        y = '%s' % x
        z = int(y)        
        print '----------------Group_id-----------------',z
        
        if z == 1:
            a = DBSession.query(User.email).filter(User.id==u).first()
            print '----------------Email---------------------',a
            rows = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.user_id, WajibPajak.unit_id
                           ).filter(WajibPajak.email==a,
                                    WajibPajak.nama.ilike('%%%s%%' % term) 
                           ).all()
            r = []
            for k in rows:
                d={}
                d['id']          = k[0]
                d['value']       = k[1]
                d['user']        = k[2]
                d['unit']        = k[3]
                r.append(d)
            print '----------------Penyetor------------------',r
            return r
         
        elif z == 2:
            print '----------------User_id-------------------',u
            rows = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.user_id, WajibPajak.unit_id
                           ).filter(WajibPajak.user_id==u,
                                    WajibPajak.nama.ilike('%%%s%%' % term) 
                           ).all()
            r = []
            for k in rows:
                d={}
                d['id']          = k[0]
                d['value']       = k[1]
                d['user']        = k[2]
                d['unit']        = k[3]
                r.append(d)
            print '----------------Penyetor------------------',r
            return r
        
        else:
            rows = DBSession.query(WajibPajak.id, WajibPajak.nama, WajibPajak.user_id, WajibPajak.unit_id
                           ).filter(WajibPajak.nama.ilike('%%%s%%' % term) 
                           ).all()
            r = []
            for k in rows:
                d={}
                d['id']          = k[0]
                d['value']       = k[1]
                d['user']        = k[2]
                d['unit']        = k[3]
                r.append(d)
            print '----------------Penyetor------------------',r
            return r     

            