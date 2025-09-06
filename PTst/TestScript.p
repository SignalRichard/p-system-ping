test tcSinglePing [main=TestSinglePing]:
    assert EveryPingEchoes in
    (union Client, Host, { TestSinglePing });

test tcRandomPing [main=TestRandomPing]:
    assert EveryPingEchoes in
    (union Client, Host, { TestRandomPing });

test tcMultiClientPing [main=TestMultiClientsPing]:
    assert EveryPingEchoes in
    (union Client, Host, { TestMultiClientsPing });
