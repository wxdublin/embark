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


pd1::PollDevice(eth4, QUEUE 0, BURST 32) -> sd1::SendDevice(eth7, BURST 32, QUEUE 0);
StaticThreadSched(pd1 0);


pd2::PollDevice(eth5, QUEUE 0, BURST 32) -> sd2::SendDevice(eth6, BURST 32, QUEUE 0);
StaticThreadSched(pd2 1);


//pd3::PollDevice(eth7, QUEUE 0, BURST 32) -> sd3::SendDevice(eth4, BURST 32, QUEUE 0);

//pd4::PollDevice(eth6, QUEUE 0, BURST 32) -> sd4::SendDevice(eth5, BURST 32, QUEUE 0);

//StaticThreadSched(pd3 2);
//StaticThreadSched(pd4 3);

