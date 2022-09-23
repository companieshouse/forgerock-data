#!/bin/sh

# Specify JVM options
echo "RCS_JVM_ARGS : ${RCS_JVM_ARGS}"

# Wrap them up into the JAVA_OPTS environment variable
export JAVA_OPTS="${JAVA_OPTS} ${RCS_JVM_ARGS}"

echo "RCS JAVA_OPTS - ${JAVA_OPTS}"

cp properties/${ENVIRONMENT}/ConnectorServer.properties conf/ConnectorServer.properties
rm -rf properties
sed -i "s|{RCS_CLIENT_SECRET}|${RCS_CLIENT_SECRET}|g" conf/ConnectorServer.properties
sed -i "s|{FIDC_URL}|$(echo "${FIDC_URL#https://}")|g" conf/ConnectorServer.properties
sed -i "s|{SERVER_KEY}|${SERVER_KEY}|g" conf/ConnectorServer.properties
sed -i "s|{CONNECTOR_NAME}|${CONNECTOR_NAME}|g" conf/ConnectorServer.properties

bin/ConnectorServer.sh /setkey ${SERVER_KEY}
bin/ConnectorServer.sh jpda /run