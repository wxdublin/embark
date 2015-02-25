c :: Classifier(
    12/86dd,
    12/0806,
    12/0800,
    -);

//FromDevice(DEVNAME en0) -> c;
FromDump(FILENAME /project/cs/netsys/data/pcaps/m57/m57.pcap, STOP true) -> c;

// Ignore IPv6 for now
c[0] 
    -> Discard;

// ARP
c[1] 
    -> Discard;

// IPv4
c[2]
//    -> Print
    -> Strip(14)
    -> chk_ip :: CheckIPHeader
    -> ProtocolTranslator46
    -> SetTimestamp
    -> chk_ip6 :: CheckIP6Header
    -> MBArkGateway(FILENAME conf/test_fw.rules)
    -> accum :: TimestampAccum
    -> Discard;

// Other
c[3] 
    -> Discard;
