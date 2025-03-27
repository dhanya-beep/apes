# Create a new simulator
set ns [new Simulator]

# Define trace file and NAM file
set tracefile [open out.tr w]
set namfile [open out.nam w]

$ns trace-all $tracefile
$ns namtrace-all $namfile

# Define topology (central node and 4 leaf nodes)
set n0 [$ns node]  ;# Create central node (hub)
set n1 [$ns node]  ;# Create leaf node 1
set n2 [$ns node]  ;# Create leaf node 2
set n3 [$ns node]  ;# Create leaf node 3
set n4 [$ns node]  ;# Create leaf node 4

# Create duplex links between the central node and each leaf node
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail

# Set up TCP connections (central node to each leaf node)
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1

set tcp2 [new Agent/TCP]
$ns attach-agent $n0 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2

set tcp3 [new Agent/TCP]
$ns attach-agent $n0 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
$ns connect $tcp3 $sink3

set tcp4 [new Agent/TCP]
$ns attach-agent $n0 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n4 $sink4
$ns connect $tcp4 $sink4

# Generate traffic from the central node to each leaf node
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ns at 0.5 "$ftp1 start"

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ns at 0.5 "$ftp2 start"

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP
$ns at 0.5 "$ftp3 start"

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ftp4 set type_ FTP
$ns at 0.5 "$ftp4 start"

# Check node status (optional for debugging)
proc check_node_status {node} {
    puts "Node $node is active."
}

check_node_status $n0
check_node_status $n1
check_node_status $n2
check_node_status $n3
check_node_status $n4

# Schedule the simulation end
$ns at 5.0 "finish"

# Define finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Run the simulation
$ns run
