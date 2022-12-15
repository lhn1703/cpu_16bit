
import serial as s
from time import sleep

portTX = s.Serial(port='COM3', baudrate=38400, timeout=0, parity=s.PARITY_NONE, stopbits=1)

while 1:
	numbers = [63, 4238740, 4238734, 111, 4256344, 54, 121]
	nextNumbers = []
	nullchar = portTX.read()
	for i in range(100):
		print('\n')
	print('Attempting Bluetooth Pairing...\n')
	sleep(5)
	print('Pair Successful\n')
	received = portTX.read()
	if received == nullchar:
		print(' TX:\t' + (hex(int.from_bytes(received, "big"))))
	while True:
		received = portTX.read()
		if received != nullchar:
			nextNumbers = numbers[0:4] + [int.from_bytes(received, "big")] + numbers[4:7]
			for n in nextNumbers:
				print(' TX:\t' + (hex(n)))
			break
	while True:
		sleep(1)
