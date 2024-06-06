# IEC 61883/IIDC Applications

## IEC 61883/IIDC Listener
This example implements a very simple IEC 61883/IIDC listener application which receives AVTP packets from the network, retrieves the MPEG-TS packets, and writes them to stdout once the presentation time is reached.

For simplicity, the example supports MPEG-TS streams, and expects that each AVTP packet contains only one source packet.

TSN stream parameters such as destination mac address are passed via command-line arguments. Run 'ieciidc-listener --help' for more information.

This example relies on the system clock to schedule MPEG-TS packets for playback. So make sure the system clock is synchronized with the PTP Hardware Clock (PHC) from your NIC and that the PHC is synchronized with the PTP time from the network. For further information on how to synchronize those clocks see ptp4l(8) and phc2sys(8) man pages.

The easiest way to use this example is by combining it with a GStreamer pipeline. We provide an MPEG-TS stream that is sent to stdout, from where GStreameer reads the stream. So, to send the MPEG-TS stream received from the TSN network to GStreamer, you can do something like:

```
$ ieciidc-listener <args> | gst-launch-1.0 -e -q filesrc location=/dev/stdin
  ! tsdemux ! decodebin ! videoconvert ! autovideosink
```

## IEC 61883/IIDC Talker
This example implements a very simple IEC 61883 talker application which reads an MPEG-TS stream from stdin, creates AVTP IEC 61883/IIDC packets and transmits them via the network.

For simplicity, the example supports only MPEG-TS streams, and only one source packet is packed into each AVTP packet sent.

TSN stream parameters (e.g. destination mac address, traffic priority) are passed via command-line arguments. Run 'ieciidc-talker --help' for more information.

In order to have this example working properly, make sure you have configured FQTSS feature from your NIC according (for further information see tc-cbs(8)). Also, this example relies on system clock to set the AVTP timestamp so make sure it is synchronized with the PTP Hardware Clock (PHC) from your NIC and that the PHC is synchronized with the network clock. For further information see ptp4l(8) and phc2sys(8).

The easiest way to use this example is by combining it with a GStreamer pipeline. We use GStreamer to provide an MPEG-TS stream that is sent to stdout, from where this example reads the stream. So, to generate an MPEG-TS video to send via TSN network, you can do something like:

```
$ gst-launch-1.0 -e -q videotestsrc pattern=ball ! x264enc
  ! mpegtsmux ! filesink location=/dev/stdout
  | ieciidc-talker <args>
```