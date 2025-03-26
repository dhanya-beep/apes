import socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(("127.0.0.1",8080))
server_socket.listen()

print("server is listening")

connect,addr = server_socket.accept()
print("server connected to client")

data = connect.recv(1024).decode()
print("data received:")
print(data)

connect.send("hello from server".encode())
server_socket.close()
