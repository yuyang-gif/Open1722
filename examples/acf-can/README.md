# ACF-CAN Applications

The two applications available in this folder are acf-can-listener and acf-can-talker. These applications can be used along with Linux CAN utilities. On Ubuntu/Debian Linux distributions, these utilities can be installed using the package manager `apt install can-utils`

## acf-can-talker
_acf-can-talker_ receives frames on a (virtual) CAN interface and send out the corresponding IEEE 1722 ACF messages. This application also supports a UDP encapsulation for the IEEE 1722 messages. The parameters for its usage are as follows:

```
Usage: acf-can-talker [OPTION...]
            [ifname] dst-mac-address/dst-nw-address:port [can ifname]

acf-can-talker -- a program designed to send CAN messages to
 a remote CAN bus over Ethernet using Open1722                     

  -t, --tscf                 Use TSCF
  -u, --udp                  Use UDP
  can ifname                 CAN interface (set to STDIN by default)
  dst-mac-address            Stream destination MAC address (If Ethernet)
  dst-nw-address:port        Stream destination network address and port (If
                             UDP)
  ifname                     Network interface (If Ethernet)
```

Output of _candump_ can be piped into this application for an easy and quick use. E.g.,  
```
$  candump can1 | acf-can-talker -u 127.0.0.1:17220
```

## acf-can-talker
_acf-can-listener_ receives IEEE 1722 ACF messages and puts out the corresponding CAN frames on a (virtual) CAN interface. Analogous to the _acf_can_talker_, UDP encapsulation is also available for this application.  The parameters for its usage are as follows:

```
Usage: acf-can-listener [OPTION...] [ifname] dst-mac-address [can ifname]

acf-can-listener -- a program designed to receive CAN messages from
        a remote CAN bus over Ethernet using Open1722                     

  -p, --port=UDP_PORT        UDP Port to listen on if UDP enabled
  -u, --udp                  Use UDP
  can ifname                 CAN interface (set to STDOUT by default)
  dst-mac-address            Stream destination MAC address (If Ethernet)
  ifname                     Network interface (If Ethernet)
  -?, --help                 Give this help list
      --usage                Give a short usage message

```

Output of this application can also be piped to _canplayer_ if so desired. E.g.,
```
acf-can-listener -up 17220 | canplayer can1=elmcan can1
```

## Quickstart Tutorial: Tunneling CAN over IEEE 1722 using Linux CAN utilities
Here is an example of how CAN frames can be tunneled over an Ethernet link using _acf-can-talker_ and _acf-can-listener_.
We use two virtual CAN interfaces, vcan0 and vcan1, here which can be setup using following commands:
```
$ ip link add dev vcan0 type vcan   # Execute these commands also for vcan1 
$ ip link set dev vcan0 up
```

On Terminal 1, generate CAN traffic for vcan0:
```
$ cangen vcan0
```

On Terminal 2, pipe generated CAN traffic to _acf-can-talker_. Here, we use UDP encapsulation:
```
$ candump vcan0 | acf-can-talker -u 127.0.0.1:17220
```

On Terminal 3, receive the IEEE 1722 traffic using _acf-can-listener_ and pipe the output to _canplayer_ for putting the CAN frame out on vcan1.
```
$ acf-can-listener -up 17220 | canplayer vcan1=elmcan
```

You can now compare CAN traffic seen on vcan0 and vcan1, if the tunneling has worked.
Note that the tunneling works only in one direction (vcan0 -> vcan1).


