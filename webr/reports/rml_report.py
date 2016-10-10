import os
import sys
import ntpath
from random import (
    randrange,
    choice,
    )
from datetime import datetime
from string import ascii_lowercase
from z3c.rml import rml2pdf

rpt_path = "/home/aagusti/webr/webr/reports/" 
import pkg_resources
print pkg_resources.resource_filename('os.path', 'reports')

def waktu():
    return datetime.now().strftime('%d-%m-%Y %H:%M')

def open_rml_row(row_tpl_filename):
    f = open(rpt_path+row_tpl_filename)
    row_rml = f.read()
    f.close()
    return row_rml

def open_rml_pdf(tpl_filename, **kwargs):
    pdf_filename = tpl_filename+'.pdf'
    
    f = open(rpt_path+tpl_filename)
    rml = f.read()
    f.close()
    params = {}
    
    for key, value in kwargs.iteritems():
        params[key] = value

    rml = rml.format(waktu=waktu(), **kwargs)
    pdf = rml2pdf.parseString(rml)
    return pdf, pdf_filename
    
def pdf_response(request, pdf, filename):
    response=request.response
    response.content_type="application/pdf"
    response.content_disposition='filename='+filename 
    response.write(pdf.read())
    return response
    