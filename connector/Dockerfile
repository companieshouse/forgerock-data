FROM amazonlinux:2 AS builder

ARG AWS_ACCESS_KEY_ID 
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION 
ARG RCS_VERSION
ARG MONGODB_VERSION
ARG DB_TABLE_VERSION
ARG ORACLE_DRIVER_VERSION

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

# Download DB table connector if argument is set
RUN if [[ -n "${DB_TABLE_VERSION}" ]] ; then aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/databasetable-connector-${DB_TABLE_VERSION}.jar . ; fi
RUN if [[ -n "${DB_TABLE_VERSION}" ]] ; then rm connectors/databasetable-connector-*.jar ; fi
RUN if [[ -n "${DB_TABLE_VERSION}" ]] ; then mv databasetable-connector-${DB_TABLE_VERSION}.jar connectors ; fi

# Download Oracle JDBC driver if argument is set
RUN if [[ -n "${ORACLE_DRIVER_VERSION}" ]] ; then aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/ojdbc7-${ORACLE_DRIVER_VERSION}.jar . ; fi
RUN if [[ -n "${ORACLE_DRIVER_VERSION}" ]] ; then mv ojdbc7-${ORACLE_DRIVER_VERSION}.jar lib/framework ; fi

aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/testing .


FROM adoptopenjdk/openjdk11

ENV RCS_JVM_ARGS=${RCS_JVM_ARGS}

RUN mkdir /opt/app
WORKDIR /opt/app

COPY --from=builder /opt/app .
COPY . .
RUN mv logback.xml lib/framework

CMD [ "/opt/app/run-connector-server.sh" ]