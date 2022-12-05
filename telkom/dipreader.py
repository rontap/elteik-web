import struct 


packer = struct.Struct('20s i') 
with open('dipread.bin', 'wb') as f: 
  for i in range(5): 
      values = ( b'inf.elte.hu', 21) 
      packed_data = packer.pack(*values) 
      f.write(packed_data)
    
with open('dipread.bin', 'rb') as f: 
  f.seek(packer.size) 
  data = f.read(packer.size)       
  print(packer.unpack(data))
