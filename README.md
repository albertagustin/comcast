# docker-comcast-data-usage

Docker container to pull data usage from Comcast every 30 mins and sends results to a Prometheus push gateway.  The data can then be scrapped from the push gateway by Prometheus and shown via Grafana.

The container pulls data from comcast using https://github.com/lachesis/comcast with scheduling handled by  https://github.com/aptible/supercronic.


## Usage

1. Clone and build the image
```bash
git clone git@github.com:albertagustin/docker-comcast-data-usage.git
cd docker-comcast-data-usage
docker build -t docker-comcast-data-usage
```

2. Run the container
```bash
docker run -d \
    -e COMCAST_USERNAME=username \
    -e COMCAST_PASSWORD=password \
    -e PUSH_GATEWAY_HOST=hostname_ip \
    -e PUSH_GATEWAY_PORT=9092 \
    docker-comcast-data-usage

>>
container_id
```

3. See it run
```bash
docker logs -f container_id

>>
...
time="2017-11-12T06:10:02Z" level=info msg="DEBUG:__main__:Successfully sent value: 391.0GB to push-gateway" channel=stderr iteration=19 job.command="python3 /scripts/comcast.py" job.position=0job.schedule="* * * * *"
time="2017-11-12T06:10:02Z" level=info msg="job succeeded" iteration=1 job.command="python3 /scripts/comcast.py" job.position=0 job.schedule="0,30 * * * *"
```