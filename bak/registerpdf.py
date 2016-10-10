import sys
import re
# from email.utils import parseaddr
from sqlalchemy import not_, func
from datetime import datetime
# from time import gmtime, strftime
from pyramid.view import (
    view_config,
    )
# from pyramid.httpexceptions import (
    # HTTPFound,
    # )
# import colander
# from deform import (
    # Form,
    # widget,
    # ValidationFailure,
    # )
# from ..tools import _DTnumberformat
from ..models import DBSession
# from ..models.isipkd import(
      # Pegawai, ObjekPajak, WajibPajak, ARInvoice,
      # Unit, Wilayah, Pajak, Rekening
      # )

# from datatables import (
    # ColumnDT, DataTables)
    
# from ..security import group_finder

from ..models.isipkd import(ARTbp, ARSspd, ARInvoice)

def get_arsspd(awal,akhir):
    query = DBSession.query(ARSspd.id,
                        ARInvoice.kode,
                        ARInvoice.tgl_tetap,
                        ARInvoice.wp_kode,
                        ARInvoice.wp_nama,
                        ARInvoice.op_kode,
                        ARInvoice.op_nama,
                        ARInvoice.rek_kode,
                        ARInvoice.rek_nama,
                        ARInvoice.pokok,
                        ARInvoice.penambah,
                        ARInvoice.pengurang,
                        ARInvoice.terutang,
                        ARInvoice.bunga.label('bunga_awal'),
                        ARInvoice.denda,
                        ARInvoice.jumlah,
                        ARInvoice.jatuh_tempo,
                        ARSspd.bunga,
                        ARSspd.bayar,
                        ARSspd.tgl_bayar
                        ).join(ARInvoice)\
                     .filter(ARSspd.tgl_bayar.between(awal,akhir))\
                     .order_by(ARSspd.tgl_bayar,ARInvoice.kode,)
    return query
    
def get_arinvoice(awal,akhir):
    query = DBSession.query(ARInvoice.id,
                        ARInvoice.kode,
                        ARInvoice.tgl_tetap,
                        ARInvoice.wp_kode,
                        ARInvoice.wp_nama,
                        ARInvoice.op_kode,
                        ARInvoice.op_nama,
                        ARInvoice.rek_kode,
                        ARInvoice.rek_nama,
                        ARInvoice.pokok,
                        ARInvoice.penambah,
                        ARInvoice.pengurang,
                        ARInvoice.terutang,
                        ARInvoice.bunga,
                        ARInvoice.denda,
                        ARInvoice.jumlah,
                        ARInvoice.jatuh_tempo,
                        )\
                     .filter(ARInvoice.tgl_tetap.between(awal,akhir))\
                     .order_by(ARInvoice.tgl_tetap,ARInvoice.kode,)
    return query

def get_artbp(awal,akhir):
    query = DBSession.query(ARTbp.id,
                        ARTbp.kode,
                        ARTbp.tgl_terima,
                        ARTbp.wp_kode,
                        ARTbp.wp_nama,
                        ARTbp.op_kode,
                        ARTbp.op_nama,
                        ARTbp.rek_kode,
                        ARTbp.rek_nama,
                        ARTbp.pokok,
                        ARTbp.penambah,
                        ARTbp.pengurang,
                        ARTbp.terutang,
                        ARTbp.bunga,
                        ARTbp.denda,
                        ARTbp.jumlah,
                        ARTbp.jatuh_tempo,
                        )\
                     .filter(ARTbp.tgl_terima.between(awal,akhir))\
                     .order_by(ARTbp.tgl_terima,ARTbp.kode,)
    return query    
########                    
# PDF #
########          
@view_config(route_name='register-pdf') #, renderer='pdf'
def view_pdf(request):
    req = request
    ses = req.session
    params = req.params
    url_dict = req.matchdict 
    awal = 'awal' in req.params and req.params['awal']\
                                or datetime.now().strftime('%Y-%m-%d')
    akhir = 'akhir' in req.params and req.params['akhir']\
                                or datetime.now().strftime('%Y-%m-%d')
    
    pdf = url_dict['pdf']
    if  pdf == 'arsspd':
        qry = get_arsspd(awal,akhir)
    elif  pdf == 'arinvoice':
        pdf = get_arinvoice(awal,akhir)
    elif  pdf == 'artbp':
        qry = get_artbp(awal,akhir)
        
    r = qry.first()
    header = r.keys()
    query = qry.all()
    rows = []
    for item in query:
        rows.append(list(item))

    # override attributes of response
    filename = '%s%s%s.pdf' %(pdf,awal, akhir)
    req.response.content_disposition = 'attachment;filename=' + filename

    return {
      'header': header,
      'rows'  : rows,
    } 