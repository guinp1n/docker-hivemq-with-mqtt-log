This project spawns a HiveMQ broker with MQTT Message Log extension in Docker.

## Dependencies
1. This script runs in bash.
1. You will need to install:
  - curl
  - java OpenJDK 11
  - docker
  - unzip
  - git https://github.com/git-guides/install-git
  - MQTT CLI  https://hivemq.github.io/mqtt-cli


# Quick Start

1. Clone this repo `git clone https://github.com/guinp1n/docker-hivemq-with-mqtt-log.git`
2. Go to the repo directory `cd docker-hivemq-with-mqtt-log`
3. Run `./build_and_run_docker.sh`

## How to test
1. Install MQTT CLI ``https://hivemq.github.io/mqtt-cli``

1. Open a separate terminal window and subscribe
```mqtt subscribe --topic # --debug --jsonOutput```

1. Open a separate terminal window and publish
``mqtt publish --topic 'Test' --message 'Hello' --debug``

### How to monitor the broker log
Attach to the docker container. Monitor the hivemq.log
``docker exec 'hivemq' tail -f /opt/hivemq/log/hivemq.log``

