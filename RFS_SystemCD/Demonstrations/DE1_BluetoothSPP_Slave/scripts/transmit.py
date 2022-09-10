
import serial as s

port = s.Serial(port='COM3', baudrate=38400, timeout=0, parity=s.PARITY_NONE, stopbits=1)
size = 1024

while 1:
	data = input()
	if data == 'quit':
		break
	port.write(data.encode())

