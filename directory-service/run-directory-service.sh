#!/bin/sh

DEPLOYMENT_KEY=$(./bin/dskeymgr create-deployment-key --deploymentKeyPassword $DS_PASSWORD)

./setup \
 --deploymentKey $DEPLOYMENT_KEY \
 --deploymentKeyPassword $DS_PASSWORD \
 --rootUserDN uid=admin \
 --rootUserPassword $DS_PASSWORD \
 --hostname $HOSTNAME \
 --adminConnectorPort 4444 \
 --ldapPort 389 \
 --profile ds-user-data \
 --set ds-user-data/baseDn:dc=companieshouse,dc=gov,dc=uk \
 --acceptLicense \
 --start

./bin/dsconfig \
 set-password-policy-prop \
 --hostname $HOSTNAME \
 --port 4444 \
 --bindDN uid=admin \
 --bindPassword $DS_PASSWORD \
 --policy-name "Root Password Policy" \
 --trustAll \
 --set require-secure-authentication:false \
 --no-prompt

unset DS_PASSWORD

tail -f ./logs/ldap-access.audit.json