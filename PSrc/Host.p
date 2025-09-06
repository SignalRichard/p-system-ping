machine Host {
    start state Listening {
        on ePing do (ping: tPing) {
            send ping.source, eEcho, (ping.buffer);
            goto Listening;
        }
    }
}