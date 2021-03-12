FROM amazonlinux:latest AS builder

ARG AWS_ACCESS_KEY_ID 
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION 
ARG RCS_VERSION
ARG MONGODB_VERSION

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

RUN yum -y install aws-cli unzip

RUN mkdir /opt/app
WORKDIR /opt/app

RUN aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/openicf-zip-${RCS_VERSION}}.zip .
RUN aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/mongodb-connector-${MONGODB_VERSION}.jar .

RUN unzip openicf-zip-${RCS_VERSION}}.zip
RUN rm openicf-zip-${RCS_VERSION}}.zip
RUN mv openicf/* .
RUN rm -rf openicf
RUN mv mongodb-connector-${MONGODB_VERSION}.jar connectors


FROM adoptopenjdk/openjdk11

RUN mkdir /opt/app
WORKDIR /opt/app

COPY --from=builder /opt/app .
COPY . .

CMD [ "/opt/app/run-connector-server.sh" ]