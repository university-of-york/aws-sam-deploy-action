FROM ubuntu:latest

LABEL version="1.1.1"

LABEL com.github.actions.name="SAM Deploy Action"
LABEL com.github.actions.description="Deploy AWS SAM Stack"
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="blue"

LABEL repository="https://github.com/r0zar/sam-deploy-action"
LABEL homepage="https://github.com/r0zar/sam-deploy-action"
LABEL maintainer="Dan Miller <dan.miller@york.ac.uk>"

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y curl unzip jq
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
