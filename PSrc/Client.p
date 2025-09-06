machine Client {
    var host: Host;
    var buffer: string;
    var count: int;
    var sendCount: int;
    var receivedCount: int;

    start state Init {
        entry (input : (host: Host, pingCount: int, bufferOffset: int)) {
            var seed: int;
            seed = 99;
            assert input.bufferOffset > seed;
            buffer = format ("{0}", choose(99) + input.bufferOffset);
            host = input.host;
            count = input.pingCount;
            receivedCount = 0;
            goto Pinging;
        }
    }

    state Pinging {
        entry {
            var i: int;
            i = 0;
            while(i < count)
            {
                Send();
                i = i + 1;
            }

            goto Complete;
        }
    }

    state Complete {
        entry {
            assert receivedCount == count, format ("Error: did not receive expected number of replies (got: {0}, expected: {1})", receivedCount, count);
        }
    }

    fun Send() {
        send host, ePing, (source = this, buffer = buffer);
        sendCount = sendCount + 1;
        receive { 
            case eEcho: (response: string) {
                receivedCount = receivedCount + 1;

                assert buffer == response, format("Response does not match original payload: (response: {0}, payload: {1})", response, buffer);
            }
        };
    }
}