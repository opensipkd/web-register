import pytz    
import transaction
import colander
from datetime import datetime
from email.utils import parseaddr
from pyramid.view import view_config
from pyramid.httpexceptions import (HTTPFound, HTTPForbidden, HTTPNotFound)
from pyramid.security import (remember, forget, authenticated_userid,)
from deform import (Form, ValidationFailure, widget,)

from ..models import (DBSession, User,)
from pyramid.view import notfound_view_config



###############################################################################
# Not Found
###############################################################################

# @view_config(context=HTTPNotFound, renderer='templates/login.pt')
# def not_found(self, request):
    # request.response.status = 404
    # print request
    # return dict(request=request)


###############################################################################
# Not Found
###############################################################################

@view_config(route_name='forbidden', renderer='templates/forbidden.pt')
def not_found2(self, request):
    #request.response.status = 404
    return dict(request=request)
    
########
# Home #
########
@view_config(route_name='home', renderer='templates/home.pt')
def view_home(request):
    return dict(project='webr')


#########
# Login #
#########
class Login(colander.Schema):
    username = colander.SchemaNode(colander.String(),
                                   title="Nama Pengguna")
    password = colander.SchemaNode(colander.String(),
                                   title="Kata Sandi",
                                   widget=widget.PasswordWidget())


# http://deformdemo.repoze.org/interfield/
def login_validator(form, value):
    user = form.user
    if not user:
        raise colander.Invalid(form, 'Login gagal')
    if not user.user_password:
        raise colander.Invalid(form, 'Login gagal')        
    if not user.check_password(value['password']):
        raise colander.Invalid(form, 'Login gagal')

def get_login_headers(request, user):
    headers = remember(request, user.email)
    #headers = remember(request, user.id)
    #user.last_login_date = datetime.now()
    DBSession.add(user)
    DBSession.flush()
    transaction.commit()
    return headers

@view_config(context=HTTPForbidden, renderer='templates/login.pt')
@view_config(route_name='login', renderer='templates/login.pt')
def view_login(request):
    if authenticated_userid(request):
        return HTTPFound(location=request.route_url('forbidden'))
    
    login_url = request.resource_url(request.context,'login')
    referrer = request.url
    if referrer == login_url:
        referrer = '/'
            
    came_from = request.params.get('came_from', referrer)
    schema = Login(validator=login_validator)
    form = Form(schema, buttons=('login',))
    if 'login' in request.POST: 
        controls = request.POST.items()
        identity = request.POST.get('username')
        user = schema.user = User.get_by_identity(identity)
        try:
            c = form.validate(controls)
        except ValidationFailure, e:
            request.session['login failed'] = e.render()
            return HTTPFound(location=came_from) #location.request.route_url('login')
                    
            
        headers = get_login_headers(request, user)
        return HTTPFound(location=came_from, # request.route_url(came_from),
                          headers=headers)
    elif 'login failed' in request.session:
        r = dict(form=request.session['login failed'])
        del request.session['login failed']
        return r
        
    return dict(form=form.render())

@view_config(route_name='logout')
def view_logout(request):
    headers = forget(request)
    return HTTPFound(location = request.route_url('home'),
                      headers = headers)    


###################
# Change password #
###################
class Password(colander.Schema):
    old_password = colander.SchemaNode(colander.String(),
                                       title="Kata Sandi Lama",
                                       widget=widget.PasswordWidget())
    new_password = colander.SchemaNode(colander.String(),
                                       title="Kata Sandi Baru",
                                       widget=widget.PasswordWidget())
    retype_password = colander.SchemaNode(colander.String(),
                                       title="Ketik Ulang Kata Sandi",
                                       widget=widget.PasswordWidget())

                                          
def password_validator(form, value):
    if not form.request.user.check_password(value['old_password']):
        raise colander.Invalid(form, 'Invalid old password.')
    if value['new_password'] != value['retype_password']:
        raise colander.Invalid(form, 'Retype mismatch.')
                                          

@view_config(route_name='password', renderer='templates/password.pt',
             permission='edit')
def view_password(request):
    schema = Password(validator=password_validator)
    form = Form(schema, buttons=('simpan','cancel'))
    if request.POST:
        if 'simpan' in request.POST:
            schema.request = request
            controls = request.POST.items()
            try:
                c = form.validate(controls)
            except ValidationFailure, e:
                request.session['invalid password'] = e.render()
                return HTTPFound(location=request.route_url('password'))
            user = request.user
            user.password = c['new_password']
            DBSession.add(user)
            DBSession.flush()
            transaction.commit()
            request.session.flash('Your password has been changed.')
        return HTTPFound(location=request.route_url('home'))
    elif 'invalid password' in request.session:
        r = dict(form=request.session['invalid password'])
        del request.session['invalid password']
        return r
    return dict(form=form.render())
