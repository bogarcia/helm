FROM alpine:3


ENV HELM_VERSION "3.1.2"
ENV AWSCLI_VERSION "1.18.43"

# ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

RUN apk add --update --no-cache curl ca-certificates \
    python \
    python-dev \
    py-pip \
    mysql-client \
    build-base && \
    pip install awscli==$AWSCLI_VERSION boto3 pyyaml && \   
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    apk del py-pip && \
    rm -f /var/cache/apk/*

WORKDIR /apps

ENTRYPOINT ["helm"]
CMD ["--help"]
