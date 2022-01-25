FROM oznu/s6-node:14.18.1-amd64

ARG UnicornLoadBalancerGitHash="a2713845431002379a2c7279e276bb02622bf171"

COPY root/ /

RUN apk add -U git \ 
    && mkdir -p /opt \
    && cd /opt \
    && git clone https://github.com/UnicornTranscoder/UnicornLoadBalancer.git \
    && cd UnicornLoadBalancer \
    && git checkout "${UnicornLoadBalancerGitHash}" \
    && rm package-lock.json && sed -i 's/"sqlite3": "^4.1.0",/"sqlite3": "5.0.2",/' package.json \
    && npm install \
    && chmod a+x /etc/services.d/unicorn-loadbalancer/run \
    && apk del git              \
    && rm -rf /tmp/* /var/cache/apk/*
