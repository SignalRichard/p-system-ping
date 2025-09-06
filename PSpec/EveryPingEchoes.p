spec EveryPingEchoes observes ePing, eEcho {
    var counter: int;

    start state NoPendingEcho {
        on ePing goto PendingEcho with (ping: tPing) {
            counter = counter + 1;
        }
    }

    hot state PendingEcho {
        on eEcho do (buffer: string) {
            assert counter > 0, "Received an echo when no ping was sent!";
            counter = counter - 1;
            
            if(counter == 0)
            {
                goto NoPendingEcho;
            }
            else
            {
                goto PendingEcho;
            }
        }

        on ePing goto PendingEcho with (ping: tPing) {
            counter = counter + 1;
        }
    }
}