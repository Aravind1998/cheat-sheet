######### Nodes & Links ##########

#Create Nodes
set n0 [$ns node]

#Create links between the nodes n0 and n1
$ns duplex-link $n0 $n1 10Mb 10ms DropTail

#Set Queue Size of link (n1-n2) to 10
$ns queue-limit $n1 $n2 10

#Give node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down

#Monitor the queue for link (n2-n3). (for NAM) 0 -> 0 , 0.5 -> 90, 1 -> 180
$ns duplex-link-op $n2 $n3 queuePos 0.5

# Label Nodes
$ns at 0.0 "$n0 label Router1"

#Change Shape of Nodes
$n0 shape square

# Enable / Disable Link between n0 and n1 (up/down)
$ns rtmodel-at 1.0 down $n0 $n1

# Enable Distance Vector Routing
$ns rtproto DV

########### Agent #############

# TCP -> TCPSink , UDP -> Null
# class_ {x} defines colour where x is one of the below
$ns color 1 Green
$ns color 2 Red

#Setup a TCP Agent
set tcp0 [new Agent/TCP]
$tcp0 set class_ 1					

#Setup a TCPSink for TCP connect
set sink0 [new Agent/TCPSink]

#Setup a UDP Agent
set udp0 [new Agent/UDP] 
$udp0 set class_ 1

#Setup Null Agent for UDP
set null0 [new Agent/Null] 

#Connect TCP / UDP / TCPSink / Null to any node
$ns attach-agent $n0 $tcp0

#Connect TCP -> TCPSink , UDP -> Null
$ns connect $tcp0 $sink0


########### Application ###########

#Create FTP traffic
set ftp0 [new Application/FTP]
$ftp0 set type_ FTP

#Create CBR Traffic
set cbr0 [new Application/Traffic/CBR]
$cbr0 set type_ CBR
$cbr0 set packetSize_ 50 
$cbr0 set interval_ 0.01
$cbr0 set rate_ 1mb
$cbr0 set random_ false

#Attach FTP -> TCP , CBR -> UDP
$cbr0 attach-agent $udp0

#Schedule events for the CBR , FTP agents
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp stop"

