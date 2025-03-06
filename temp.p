// Event definitions
event Ping;
event Pong;
event Timeout;
event Ack;

// Machine: Receiver
machine Receiver {
    start state WaitingForPing {
        on Ping do HandlePing;
    }

    action HandlePing {
        send(sender, Pong); // Respond with Pong
    }
}

// Machine: Sender
machine Sender {
    start state SendingPing {
        entry {
            send(receiver, Ping); // Send Ping to Receiver
            startTimer(500, Timeout); // Start timeout for response
        }
        on Pong goto ReceivedPong;
        on Timeout goto Retry;
    }

    state ReceivedPong {
        entry {
            send(environment, Ack); // Acknowledge success
        }
    }

    state Retry {
        entry {
            raise Timeout; // Retry logic can be implemented here
        }
    }
}

// Environment to model the network
machine Environment {
    start state ForwardMessages {
        on Ping do ForwardToReceiver;
        on Pong do ForwardToSender;
    }

    action ForwardToReceiver {
        send(receiver, Ping); // Forward Ping to Receiver
    }

    action ForwardToSender {
        send(sender, Pong); // Forward Pong to Sender
    }
}
