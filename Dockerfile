FROM alpine:latest

ENV VARNISH_HOST web
ENV VARNISH_TEMPLATE magento

RUN set -ex \
	&& ( \
		apk update \
		&& apk upgrade \
		&& apk add varnish \
	)

ADD etc/*.vcl /etc/varnish/
ADD bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-environment"]
CMD ["varnishd", "-p", "default_ttl=3600", "-p", "default_grace=3600", "-p", "feature=+esi_ignore_https", "-p", "feature=+esi_disable_xml_check"]
