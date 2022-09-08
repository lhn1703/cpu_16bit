import bluetooth

serverMACAddress = 'D8:F3:BC:55:52:40'
port = 3
s = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
s.connect((serverMACAddress, port))
print(bluetooth.discover_devices())
print("connected to ", serverMACAddress)
while 1:
    text = input() # Note change to the old (Python 2) raw_input
    if text == "quit":
        break
    s.send(text)
s.close()