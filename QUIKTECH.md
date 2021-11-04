## Quik Tech Ltd. : Backend Developer

MALTA: NOV 2018 - JUL 2019

Very interesting project working on an online lottery platform with a live
video streaming element attached to it.
Cameras are placed on real lotto machines which are capable of sending digital
data out on things like the ball number drawn, etc. to a backend platform written
in Go.

The frontend will show this video stream and take the digital stream of data coming
from it as handled by the backend and build wagering functionality around it.

### Stack

| Go                 | Computer Vision        | Amazon Web Services             |
|--------------------|------------------------|---------------------------------|
| Microservices      | OpenCV                 | MySQL                           |
| Logging Library    | Object Recognition     | RabbitMQ                        |
| RabbitMQ Observers | Video over Web Sockets | Pusher (Web Sockets)            |

### Remarks

This was my first microservices project, and true to form there were some
hickups along the way as we were all figuring out how to fit the lottery
game flow into a distributed model, using RabbitMQ based fanout
messaging as the main communication method.

An unexpected benefit of this position was to have quite some time working
on reasearch and development with regards to video stream transport,
applying "logging" to video events, and even some experimentation with using
vision based machine learning to aid in recognizing draws when the hardware
based method (RFID chips in the lotto balls) failed over.

Partly research and development, and partly because there was no better solution
until we found one, I also developed a completely new video streaming protocol
here, which makes use of web sockets.
I still work on this from time to time, as it is not production ready, but I would
like to take it further some time.

This was a huge challenge in orchestration and working on what eventually became
14 microservices in a small team was doable, but not ideal.
We had great communication and that already solved a lot.