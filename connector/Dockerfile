FROM adoptopenjdk/openjdk11

RUN mkdir /opt/app
COPY . /opt/app

WORKDIR /opt/app

CMD [ "/opt/app/run-connector-server.sh" ]