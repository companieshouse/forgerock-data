#!/bin/sh

# Set the JVM options for openicf
export OPENICF_OPTS="${RCS_JVM_ARGS}"

echo "OPENICF_OPTS = ${OPENICF_OPTS}"

if [[ -n "${INACTIVE_FILE_URL}" ]]
then
  s3 cp ${INACTIVE_FILE_URL} /opt/app/data/inactive.csv
else
  echo "INACTIVE_FILE_URL env variable not found, will continue running container as this file isn't mandatory"
fi

cp properties/${ENVIRONMENT}/ConnectorServer.properties conf/ConnectorServer.properties
rm -rf properties
sed -i "s|{RCS_CLIENT_SECRET}|${RCS_CLIENT_SECRET}|g" conf/ConnectorServer.properties
sed -i "s|{FIDC_URL}|$(echo "${FIDC_URL#https://}")|g" conf/ConnectorServer.properties
sed -i "s|{SERVER_KEY}|${SERVER_KEY}|g" conf/ConnectorServer.properties
sed -i "s|{CONNECTOR_NAME}|${CONNECTOR_NAME}|g" conf/ConnectorServer.properties

bin/ConnectorServer.sh /setkey ${SERVER_KEY}
bin/ConnectorServer.sh jpda /run