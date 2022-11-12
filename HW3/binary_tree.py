from mininet.topo import Topo

class BinaryTreeTopo( Topo ):
    "Binary Tree Topology Class."
    def __init__( self ):
        "Create the binary tree topology."
        # Initialize topology
        Topo.__init__( self )

        # Add hosts
        hosts=[]
        for i in range(1,9):
            hosts.append(self.addHost("h"+str(i)))

        # Add switches
        switches=[]
        for j in range(1,8):
            switches.append(self.addSwitch('s'+str(j)))

        # Add links
        self.addLink(switches[0],switches[1])
        self.addLink(switches[0],switches[4])
        self.addLink(switches[1],switches[2])
        self.addLink(switches[1],switches[3])
        self.addLink(switches[4],switches[5])
        self.addLink(switches[4],switches[6])
        j=0
        for i in [2,3,5,6]:
            self.addLink(switches[i],hosts[j])
            self.addLink(switches[i],hosts[j+1])
            j+=2

topos = {"binary_tree": (lambda: BinaryTreeTopo())}
