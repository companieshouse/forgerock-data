#!/bin/sh

cp ConnectorServer.properties.sample conf/ConnectorServer.properties
sed -i "s|{RCS_CLIENT_SECRET}|${RCS_CLIENT_SECRET}|g" conf/ConnectorServer.properties
sed -i "s|{FIDC_URL}|$(echo "${FIDC_URL#https://}")|g" conf/ConnectorServer.properties
sed -i "s|{SERVER_KEY}|${SERVER_KEY}|g" conf/ConnectorServer.properties
sed -i "s|{CONNECTOR_NAME}|${CONNECTOR_NAME}|g" conf/ConnectorServer.properties

bin/ConnectorServer.sh /setkey ${SERVER_KEY}
bin/ConnectorServer.sh jpda /run