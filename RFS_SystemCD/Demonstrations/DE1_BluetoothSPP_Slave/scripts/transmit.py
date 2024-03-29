import serial as s
from time import sleep

port = s.Serial(port='COM3', baudrate=38400, timeout=0, parity=s.PARITY_NONE, stopbits=1)

while 1:
	file = input('Enter a file name (or \'quit\' to exit):\n')
	if file == 'quit':
		break
	with open(file) as f:
		for line in f:
			port.write(bytes([int(line[0:8],2)]))
			input()
			port.write(bytes([int(line[8:16],2)]))
			input()