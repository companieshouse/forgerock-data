FROM amazonlinux:latest AS builder

ARG AWS_ACCESS_KEY_ID 
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION 
ARG RCS_VERSION
ARG MONGODB_VERSION
ARG ORACLE_DB_VERSION

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

RUN yum -y install aws-cli unzip

RUN mkdir /opt/app
WORKDIR /opt/app

# Download and extract RCS
RUN aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/openicf-zip-${RCS_VERSION}.zip .
RUN unzip openicf-zip-${RCS_VERSION}.zip
RUN rm openicf-zip-${RCS_VERSION}.zip
RUN mv openicf/* .
RUN rm -rf openicf

# Download MongoDB connector if argument is set
RUN if [[ -n "${MONGODB_VERSION}" ]] ; then aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/mongodb-connector-${MONGODB_VERSION}.jar . ; fi
RUN if [[ -n "${MONGODB_VERSION}" ]] ; then mv mongodb-connector-${MONGODB_VERSION}.jar connectors ; fi

# Download Oracle DB connector if argument is set
RUN if [[ -n "${ORACLE_DB_VERSION}" ]] ; then aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/oracle-connector-${ORACLE_DB_VERSION}.jar . ; fi
RUN if [[ -n "${ORACLE_DB_VERSION}" ]] ; then mv oracle-connector-${ORACLE_DB_VERSION}.jar connectors ; fi


FROM adoptopenjdk/openjdk11

RUN mkdir /opt/app
WORKDIR /opt/app

COPY --from=builder /opt/app .
COPY . .

CMD [ "/opt/app/run-connector-server.sh" ]