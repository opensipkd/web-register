import socket,sys


s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

MAX = 65535
PORT = 6000

if sys.argv[1:]==['server']:
    s.bind(('0.0.0.0',PORT))
    print 'Listnening at ',s.getsockname()
    while True:
        data ,address = s.recvfrom(MAX)
        s.sendto('Your data was %d bytes' %len(data),address)
elif sys.argv[1:] == ['client']:
    print 'Address before sending'.s.getsockname()
    s.sendto('This is my message ',('0.0.0.0',PORT))
    print 'Address after sending ',s.getsockname()
    data,address = s.recvfrom(MAX)
    print 'The Server ',address,'   says',repr(data)

else:
    print >>sys.stderr, 'Usage: udp_local.py server|client'
