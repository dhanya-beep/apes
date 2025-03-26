import socket

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect(("127.0.0.1",8080))

client_socket.send("hello from client".encode())

response = client_socket.recv(1024).decode()
print("Server reponse:")
print(response)

client_socket.close()
