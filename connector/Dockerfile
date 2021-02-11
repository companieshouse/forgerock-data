FROM adoptopenjdk/openjdk11

ARG RCS_CLIENT_SECRET
ARG FIDC_URL
ARG SERVER_KEY

ENV FIDC_URL=${FIDC_URL}

RUN mkdir /opt/app
COPY . /opt/app

WORKDIR /opt/app

RUN cp conf/ConnectorServer.properties.sample conf/ConnectorServer.properties
RUN sed -i "s|{RCS_CLIENT_SECRET}|${RCS_CLIENT_SECRET}|g" conf/ConnectorServer.properties
RUN sed -i "s|{FIDC_URL}|$(echo "${FIDC_URL#https://}")|g" conf/ConnectorServer.properties
RUN sed -i "s|{SERVER_KEY}|${SERVER_KEY}|g" conf/ConnectorServer.properties

RUN bin/ConnectorServer.sh /setkey ${SERVER_KEY}

CMD [ "bin/ConnectorServer.sh", "jpda", "/run" ]