Task 1

  1. What is the output of “nodes” and “net”

    (1) nodes:

	available nodes are: 
	c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7
	
    (2) net
    
	h1 h1-eth0:s3-eth2
	h2 h2-eth0:s3-eth3
	h3 h3-eth0:s4-eth2
	h4 h4-eth0:s4-eth3
	h5 h5-eth0:s6-eth2
	h6 h6-eth0:s6-eth3
	h7 h7-eth0:s7-eth2
	h8 h8-eth0:s7-eth3
	s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
	s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
	s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0
	s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
	s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
	s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
	s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
	c0

  2. What is the output of “h7 ifconfig”

	h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
		inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
		inet6 fe80::4049:7bff:fe05:8965  prefixlen 64  scopeid 0x20<link>
		ether 42:49:7b:05:89:65  txqueuelen 1000  (Ethernet)
		RX packets 74  bytes 5588 (5.5 KB)
		RX errors 0  dropped 0  overruns 0  frame 0
		TX packets 13  bytes 1006 (1.0 KB)
		TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

	lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
		inet 127.0.0.1  netmask 255.0.0.0
		inet6 ::1  prefixlen 128  scopeid 0x10<host>
		loop  txqueuelen 1000  (Local Loopback)
		RX packets 0  bytes 0 (0.0 B)
		RX errors 0  dropped 0  overruns 0  frame 0
		TX packets 0  bytes 0 (0.0 B)
		TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
		

Task 2

  1. Draw the function call graph of this controller. For example, once a packet comes to the controller, which function is the first to be called, which one is the second, and so forth?
  
  order:
    - _handle_PacketIn (self, event)
    - act_like_hub (self, packet, packet_in)
    - resend_packet(packet_in, of.OFPP_ALL)
    - self.connection.send(msg)
    
  2. Have h1 ping h2, and h1 ping h8 for 100 times 
  
  a) How long does it take (on average) to ping for each case?
  
  	h1 ping h2: 3.353 ms
  	h1 ping h8: 12.885 ms
  	
  b) What is the minimum and maximum ping you have observed?
  
  	h1 ping h2: max: 9.591 ms
  		    min: 1.366 ms
  		    
  	h1 ping h8: max: 28.006 ms
  		    min: 4.578 ms
  		    
  c) What is the difference, and why?
  
  	Firstly, no matter hi ping h2 or h1 ping h8, the first ping is the maximum ping. Since the first time ping, the switch needs send message to the whole network and find the shortest path.
  	 
	Secondly,h1 ping h8 costs more time than h1 ping h2. h1 is directly connected with h2 by switch s3, but for h1 ping h8 needs go through s3,s2,s1,s5,s7, so even though the connection has been built and the shortest path has been defined h1 ping h8 still costs more time than h1 ping h2.
	
  3. Run “iperf h1 h2” and “iperf h1 h8”
  
  a) What is “iperf” used for?
  
  	iperf can measure the throughput of a network (available network bandwidth) to test the network performance.
  	
  b) What is the throughput for each case?
  
  	iperf h1 h2:
  	
	*** Iperf: testing TCP bandwidth between h1 and h2 
	*** Results: ['8.49 Mbits/sec', '9.96 Mbits/sec']
	
	iperf h1 h8:
	
	*** Iperf: testing TCP bandwidth between h1 and h8 
	*** Results: ['3.67 Mbits/sec', '4.20 Mbits/sec']
	
  c) What is the difference, and explain the reasons for the difference.
  
  	The throughput of h1 h8 is less than the throughput of h1 h2, maybe because from h1 to h8 needs more switches than h1 to h2(just 1 switch), during this period, more packets dropped.
  	
  4. Which of the switches observe traffic? Please describe your way for observing such traffic on switches 
  	
  	Using the act_like_switch() to replace act_like_hub() in the of_tutorial.py, add the print() to show how the traffic goes.
  	
 
Task 3

 1. Describe how the above code works, such as how the "MAC to Port" map is established. You could use a ‘ping’ example to describe the establishment process (e.g., h1 ping h2).

  - _handle_PacketIn (self, event)
  - act_like_hub (self, packet, packet_in)
  	- As a packet in, if the packet.src is already in the self.mac_to_port, then put the packet.src in the table.
  	- If the packet.dst is in the self.mac_to_port table, then just resend the packet to the destination port.
  	- If not, resend the packet to all ports.
  
 2. Have h1 ping h2, and h1 ping h8 for 100 times 
  
  a) How long does it take (on average) to ping for each case?
  
  	h1 ping h2: 3.125 ms
  	h1 ping h8: 11.989 ms
  	
  b) What is the minimum and maximum ping you have observed?
  
  	h1 ping h2: max: 5.560 ms
  		    min: 1.474 ms
  		    
  	h1 ping h8: max: 70.110 ms
  		    min: 5.129 ms
  		    
  c) What is the difference, and why?
  	
  	Compare to Task2, get lower average pings, because using the act_to_switch instead of act_to_hub, the mac_to_port table learned which port the source port are attached to in a packet.
  	
 3. Run “iperf h1 h2” and “iperf h1 h8”
  
  a) What is the throughput for each case?
  
  	iperf h1 h2:
  	
	*** Iperf: testing TCP bandwidth between h1 and h2 
	*** Results: ['50.2 Mbits/sec', '52.4 Mbits/sec']
	
	iperf h1 h8:
	
	*** Iperf: testing TCP bandwidth between h1 and h8 
	*** Results: ['4.09 Mbits/sec', '4.67 Mbits/sec']
	
  b) What is the difference

	Between h1 and h2, there is a large increase in the bandwidth, but between h1 and h8, there is a slight increase in the bandwidth.
	For packets that just go through more numbers of switches can get benefits from the function act_to_switch(), like h1 to h8, but for packets like from h1 to h2 will cost more bandwidth. 
