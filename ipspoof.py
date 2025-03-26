from scapy.all import *

spoofed_ip = "127.0.0.1"
target_ip = "127.0.0.2"

ip_layer = IP(src = spoofed_ip, dst = target_ip)
icmp_layer = ICMP()
send(ip_layer/icmp_layer)

send(ip_layer/icmp_layer, verbose=True)
