machine TestSinglePing {
    start state Init {
        entry {
            SetupMultiClientHostSystem(1, 1);
        }
    }
}

machine TestRandomPing {
    start state Init {
        entry {
            SetupMultiClientHostSystem(choose(10) + 1, 1);
        }
    }
}

machine TestMultiClientsPing {
    start state Init {
        entry {
            SetupMultiClientHostSystem(4, 3);
        }
    }
}

fun SetupMultiClientHostSystem(pingCount: int, clientCount: int)
{
    var i: int;
    var host: Host;
    var clients: set[Client];

    i = 0;
    host = new Host();

    while(i < clientCount)
    {
        clients += (new Client((host = host, pingCount = pingCount, bufferOffset = (i + 1) * 100)));
        i = i + 1;
    }
}