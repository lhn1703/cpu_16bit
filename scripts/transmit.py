
import serial as s
from time import sleep

portTX = s.Serial(port='COM3', baudrate=38400, timeout=0, parity=s.PARITY_NONE, stopbits=1)

while 1:
	file = input('Enter a file name (or \'q\' to exit):\n')
	if file == 'q':
		break
	with open(file) as f:
		for line in f:
			portTX.write(bytes([int(line[0:8],2)]))
			portTX.write(bytes([int(line[8:16],2)]))
		# Nop for pushing the previous instruction along the buffer
		portTX.write(bytes([36304 >> 8]))
		portTX.write(bytes([36304 & 255]))
	while True:
		received = portTX.read()
		print('TX:\t' + hex(0xca ^ int.from_bytes(received, "big")))
		input()
