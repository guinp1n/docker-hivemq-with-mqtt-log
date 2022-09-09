#!/bin/bash
hivemqVersion="latest"
repoAndTag="hivemq/hivemq4:$hivemqVersion-with-hivemq-mqtt-message-log-extension"

#check dependencies
if ! which docker; then echo 'To fix, refer to https://docs.docker.com/get-docker/'; exit 68; fi
if ! which java; then echo 'To fix, run  sudo apt install default-jre'; exit 66; fi
if ! which mqtt; then echo 'To fix, refer to https://hivemq.github.io/mqtt-cli/docs/installation/'; exit 67; fi
if ! which unzip; then echo 'To fix, run  sudo apt unzip'; exit 69; fi


echo "get latest releases url for hivemq-mqtt-message-log-extension"
relDownloadLink=$(curl --location --silent "https://github.com/hivemq/hivemq-mqtt-message-log-extension/releases/latest" \
  | grep "href=\".*hivemq-mqtt-message-log-extension[^/]*\\.zip" \
  | cut -d '"' -f 2)
echo "relDownloadLink=$relDownloadLink"

echo "get latest release hivemq-mqtt-message-log-extension.zip"
rm "hivemq-mqtt-message-log-extension.zip" 2>/dev/null
curl --location --silent "https://github.com/${relDownloadLink}" --output "hivemq-mqtt-message-log-extension.zip"

if [ -f "hivemq-mqtt-message-log-extension.zip" ]; then

echo "unzip to ./hivemq-mqtt-message-log-extension"
rm -r "hivemq-mqtt-message-log-extension" 2>/dev/null
unzip "hivemq-mqtt-message-log-extension.zip" -d hivemq-mqtt-message-log-extension
rm "hivemq-mqtt-message-log-extension.zip"

echo "build docker image {$hivemqVersion + hivemq-mqtt-message-log-extension} => $repoAndTag"
docker build --build-arg TAG=$hivemqVersion --build-arg EXTENSION_NAME=hivemq-mqtt-message-log-extension --tag $repoAndTag .

echo "start ${repoAndTag}"
docker run --detach --name 'hivemq' \
  --publish 8080:8080 \
  --publish 1883:1883 \
  --volume $(pwd)/hivemq-data:/opt/hivemq/data \
  --volume $(pwd)/hivemq-log:/opt/hivemq/log \
  ${repoAndTag}

if which mqtt; then
  echo "publish a retained message"
  mqtt publish --topic 'Test' --message "Hello $(whoami)! Press Ctrl+C to exit..." --qos 1 --retain \
    --willTopic 'Will' --willMessage "Bye, $(whoami)!" --willDelayInterval 10 \
    --userProperty "owner=$(whoami)" \
    --identifier "publisher_$(whoami)"
  echo "subscribe to all topics"
  mqtt subscribe --topic '#' --debug --jsonOutput --identifier "subscriber_$(whoami)"
else
  echo "MQTT CLI command line tool is not installed. Fix with: https://hivemq.github.io/mqtt-cli/docs/installation/"
fi

else
  echo "File doesn't exist: hivemq-mqtt-message-log-extension.zip"
fi