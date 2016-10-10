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


PREFIX_HP = '08'

def get_hp():
    b = randrange(11, 99)
    c = randrange(1000, 9999)
    d = randrange(1000, 9999)
    return '{a}{b}{c}{d}'.format(a=PREFIX_HP, b=b, c=c, d=d)

def waktu():
    return datetime.now().strftime('%d-%m-%Y %H:%M')


HURUF_HIDUP = 'aiueo'
HURUF_MATI = '' 
for ch in ascii_lowercase:
    if ch not in HURUF_HIDUP:
        HURUF_MATI += ch

PILIHAN_TOKEN = (True, False)

def get_token():
    hidup = choice(PILIHAN_TOKEN)
    ch1 = choice(HURUF_HIDUP)
    if hidup:
        return ch1
    hidup = choice(PILIHAN_TOKEN)
    ch2 = choice(HURUF_MATI)
    if hidup:
        return ch1 + ch2
    return ch2 + ch1

def get_nama1():
    t1 = get_token()
    while True:
        t2 = get_token()
        if t1[-1] in HURUF_HIDUP and t2[0] in HURUF_MATI or \
           t1[-1] in HURUF_MATI and t2[0] in HURUF_HIDUP:
            return t1 + t2

def get_nama2():
    t1 = get_nama1()
    while True:
        t2 = get_token()
        if t1[-1] in HURUF_HIDUP and t2[0] in HURUF_MATI or \
           t1[-1] in HURUF_MATI and t2[0] in HURUF_HIDUP:
            return t1 + t2



tpl_filename = 'test-long-page.rml.tpl'
row_tpl_filename = 'row.rml.tpl'

if sys.argv[1:]:
    pdf_filename = sys.argv[1]
else:
    output_filename = ntpath.basename(sys.argv[0])
    output_filename = os.path.splitext(output_filename)[0]
    pdf_filename = output_filename + '.pdf'

f = open(row_tpl_filename)
row_rml = f.read()
f.close()
rows = []
for i in range(1,70):
    id = randrange(10000, 99999)
    hp = get_hp()
    nama = ' '.join([get_nama1(), get_nama2()])
    s = row_rml.format(no=i, id=id, nama=nama.title(), hp=hp)
    rows.append(s)
rows_rml = '\n'.join(rows)

f = open(tpl_filename)
rml = f.read()
f.close()
rml = rml.format(rows=rows_rml, waktu=waktu())

pdf = rml2pdf.parseString(rml)
f = open(pdf_filename, 'w')
f.write(pdf.read())
f.close()
