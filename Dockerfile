ARG TAG=latest
ARG EXTENSION_NAME=hivemq-mqtt-message-log-extension

FROM hivemq/hivemq4:${TAG}
#ENV HIVEMQ_CLUSTER_PORT 8000

#   my hivemq config
COPY --chown=hivemq:hivemq hivemq-config.xml /opt/hivemq/conf/config.xml
#   log config with debug level
COPY --chown=hivemq:hivemq ${EXTENSION_NAME} /opt/hivemq/extensions/${EXTENSION_NAME}

#HiveMQ Mqtt Message Log Extension | Configuration file
COPY --chown=hivemq:hivemq mqttMessageLog.properties /opt/hivemq/extensions/${EXTENSION_NAME}/mqttMessageLog.properties
