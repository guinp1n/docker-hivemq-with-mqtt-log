This project spawns a HiveMQ broker with MQTT Message Log extension in Docker.

Clone this repo `git clone https://github.com/guinp1n/docker-hivemq-with-mqtt-log.git`
Run in bash `./build_and_run_docker.sh`

# Quick Start

Install Java
``
sudo apt update
sudo apt install openjdk-11-jdk
``

Install curl
``
sudo apt install curl
``

Install docker
https://docs.docker.com/desktop/install/ubuntu/

Clone this repo 
``git clone https://github.com/guinp1n/docker-hivemq-with-prometheus.git``

Goto the repo directory 
``cd docker-hivemq-with-prometheus``

Run the script ``/build_and_run_docker.sh``

## How to test
Install MQTT CLI ``https://hivemq.github.io/mqtt-cli``

Open a separate terminal window and subscribe
```mqtt subscribe --topic # --debug --jsonOutput```

Open a separate terminal window and publish
``mqtt publish --topic 'Test' --message 'Hello' --debug``

### How to monitor the broker log
Attach to the docker container
``docker attach ... ``

Monitor the hivemq.log
``tail -f /opt/hivemq/log/hivemq.log``

