import sys
from struct import pack
if len(sys.argv) < 4:
	print('Usage: {} sc_x86 sc_x64 sc_out'.format(sys.argv[0]))
	sys.exit()
sc_x86 = open(sys.argv[1], 'rb').read()
sc_x64 = open(sys.argv[2], 'rb').read()
fp = open(sys.argv[3], 'wb')
fp.write('\x31\xc0\x40\x0f\x84'+pack('<I', len(sc_x86)))
fp.write(sc_x86)
fp.write(sc_x64)
fp.close()