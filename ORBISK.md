## Orbisk (Zero Foodwaste) : Backend Developer

UTRECHT: OCT 2019 - OCT 2020

A hardware based food monitoring system that is placed in restaurant kitchens
above the bin to monitor all the food that is thrown away.
The device sends the picture data, peppered with other sensor data such as weight,
to Google Cloud where it is processed through a pipeline we built and made ready
for presentation in a report dashboard.

### Stack

| Go              | Python 3.7        | Google Cloud                    |
|-----------------|-------------------|---------------------------------|
| Gateway Service | Backend interface | BigQuery / Postgres / Firebase  |
| Hot/Cold Store  | Refactoring       | Dataflow / Serverless Functions |
| Embedded Go     | Dockerizing       | Compute Engine                  |

### Remarks

I worked mostly on backend services and the data pipeline, using a combination
of buckets (file system), serverless functions, Dataflow, Big Query, and Postgres,
and a combination of languages such as Go, Python, and Javascript to orchestrate
ingress and egress channels, while making sure data was safe and fast to retrieve.

Speed we obtained by using a 3 month "hot" store, for which we used Postgres, while
keeping all historical events in Big Query.

The Gateway Service I wrote in Go was designed to favor the hot store, but fall back
on the cold store if needed.

I also spend a lot of time with the hardware itself in the end, working on a Go
implementation for the Raspberry Pi that powered the hardware, as well as some work
on the Arduino code that was connected to the sensors.