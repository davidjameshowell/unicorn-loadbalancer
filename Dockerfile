FROM oznu/s6-node:16.13.0-amd64

ARG UnicornLoadBalancerGitHash="a2713845431002379a2c7279e276bb02622bf171"

COPY root/ /

RUN apk add -U git \ 
    && mkdir -p /opt \
    && cd /opt \
    && git clone https://github.com/UnicornTranscoder/UnicornLoadBalancer.git \
    && git checkout "${UnicornLoadBalancerGitHash}}" \
    && cd UnicornLoadBalancer \
    && npm install \
    && chmod a+x /etc/services.d/*/* \
    && apk del git              \
    && rm -rf /tmp/* /var/cache/apk/*
