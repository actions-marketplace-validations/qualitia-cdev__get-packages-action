# Container image that runs your code
FROM cdevqualitia/awscli:latest

RUN apk add --no-cache git\
    && pip3 --no-cache-dir install yq

COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
