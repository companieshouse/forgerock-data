#!/bin/sh

DEPLOYMENT_KEY=$(./bin/dskeymgr create-deployment-key --deploymentKeyPassword $DS_PASSWORD)

./setup \
 --deploymentKey $DEPLOYMENT_KEY \
 --deploymentKeyPassword $DS_PASSWORD \
 --rootUserDN uid=admin \
 --rootUserPassword $DS_PASSWORD \
 --hostname localhost \
 --adminConnectorPort 4444 \
 --ldapPort 389 \
 --profile ds-user-data \
 --set ds-user-data/baseDn:dc=companieshouse,dc=gov,dc=uk \
 --acceptLicense \
 --start

./bin/dsconfig \
 set-password-policy-prop \
 --hostname localhost \
 --port 4444 \
 --bindDN uid=admin \
 --bindPassword $DS_PASSWORD \
 --policy-name "Root Password Policy" \
 --trustAll \
 --set require-secure-authentication:false \
 --no-prompt

./bin/dsconfig \
 set-password-policy-prop \
 --hostname localhost \
 --port 4444 \
 --bindDN uid=admin \
 --bindPassword $DS_PASSWORD \
 --policy-name "Default Password Policy" \
 --trustAll \
 --advanced \
 --set allow-pre-encoded-passwords:true \
 --set require-secure-authentication:false \
 --set require-secure-password-changes:false \
 --no-prompt

./bin/ldapmodify \
 --hostname localhost \
 --port 4444 \
 --useSsl \
 --bindDN uid=admin \
 --bindPassword $DS_PASSWORD \
 --trustAll \
 ch-user.ldif

unset DS_PASSWORD

tail -f ./logs/ldap-access.audit.json