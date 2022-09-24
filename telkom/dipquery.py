import sys
import socket
import struct 


packer = struct.Struct('20si') 
with open('dipread.bin', 'rb') as f: 
 
  print(sys.argv)
  if len(sys.argv) == 3:
    ind = int( sys.argv[2])
    f.seek(packer.size*ind)     
    raw = f.read(packer.size)   
    data = packer.unpack(raw)
    if sys.argv[1] == "port":
      hostpot = socket.getservbyport(data[1])
      print(hostpot)
      pass
    elif sys.argv[1] == "domain":
      print(data)
      hostip = socket.gethostbyname(data[0].decode().strip('\x00'))
      print(hostip)
      pass
  else:
    print(socket.gethostname())
    
