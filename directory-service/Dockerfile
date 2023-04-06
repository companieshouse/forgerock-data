FROM amazonlinux:2 AS builder

ARG AWS_ACCESS_KEY_ID 
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION 
ARG DS_VERSION

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

RUN yum -y install aws-cli unzip

RUN mkdir /opt/app
WORKDIR /opt/app

RUN aws s3 cp s3://development-eu-west-2.resources.ch.gov.uk/packages/forgerock/DS-${DS_VERSION}.zip .

RUN unzip DS-${DS_VERSION}.zip
RUN rm DS-${DS_VERSION}.zip
RUN mv opendj/* .
RUN rm -rf opendj

FROM adoptopenjdk/openjdk11

RUN mkdir /opt/app
WORKDIR /opt/app

COPY --from=builder /opt/app .
COPY . .

EXPOSE 4444
EXPOSE 389
EXPOSE 8989

CMD [ "/opt/app/run-directory-service.sh" ]