FROM alpine:latest

LABEL maintainer "Dean Camera <http://www.fourwalledcubicle.com>"

RUN mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
	apk update && apk add --no-cache tzdata bash aria2 darkhttpd s6

RUN	apk add --no-cache git && \
	git clone --depth 1 https://github.com/binux/yaaw.git aria2-webui && \
	apk del git

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf

RUN chmod +x /conf-copy/start.sh
# RUN rc-update add s6 default
WORKDIR /

VOLUME ["/data"]
VOLUME ["/conf"]

EXPOSE 6800
EXPOSE 80

CMD ["/conf-copy/start.sh"]
