// testdevice.click

// Tests whether Click can read packets from the network.
// You may need to modify the device name in FromDevice.
// You'll probably need to be root to run this.

// Run with
//    click testdevice.click
// (runs as a user-level program; uses Linux packet sockets or a similar
// mechanism), or
//    click-install testdevice.click
// (runs inside a Linux kernel).

// If you run this inside the kernel, your kernel's ordinary IP stack
// will stop getting packets from eth0. This might not be convenient.
// The Print messages are printed to the system log, which is accessible
// with 'dmesg' and /var/log/messages. The most recent 2-4K of messages are
// stored in /click/messages.

//PollDevice(eth4) -> Print(ok) -> Discard;
//PollDevice(eth4) -> c0:: AverageCounter() -> Discard;

//PollDevice(eth4) -> Queue(100) -> c0:: AverageCounter() -> SendDevice(eth4, BURST 32);
//pd1::PollDevice(eth4, PORTID 0, QUEUE 0, BURST 32) -> q1::Queue(100) -> sd1::SendDevice(eth4, BURST 32, PORTID 3, QUEUE 0);

//pd2::PollDevice(eth3, PORTID 0, QUEUE 1, BURST 32) -> q2::Queue(100) -> sd2::SendDevice(eth3, BURST 32, PORTID 3, QUEUE 1);

//DFromToDevice(0);
//StaticThreadSched(sd3 1);

rt :: StaticIPLookup(
   192.168.210.0/24 0,
   192.168.111.0/24 1,
   18.26.4.0/24 0,
   172.26.4.0/24 0,
   118.148.4.0/24 1,
   1.0.0.1/24 0,
   1.255.255.255/24 1,
   1.110.20.1/24 0,);

pd1::PollDevice(eth4, PORTID 0, QUEUE 0, BURST 32) -> Strip(14) -> CheckIPHeader2() -> rt; 

rt[0] -> q1::Queue(1000) -> DecIPTTL -> EtherEncap(0x0800, 1:1:1:1:1:1, 2:2:2:2:2:2)
      -> sd1::SendDevice(eth4, BURST 32, PORTID 1, QUEUE 0);

rt[1] -> q2::Queue(1000) -> DecIPTTL -> EtherEncap(0x0800, 1:11:11:11:11:11, 2:22:22:22:22:22)
      -> sd3::SendDevice(eth5, BURST 32, PORTID 2, QUEUE 0);

