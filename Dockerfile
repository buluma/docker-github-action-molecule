FROM alpine:latest

LABEL maintainer="Shadow Walker <bulumaknight@gmail.com>"
LABEL build_date="2025-12-01"

WORKDIR /github/workspace

ADD requirements.txt /requirements.txt

RUN apk add --no-cache docker \
      gcc \
      git \
      python3-dev \
      py3-jmespath \
      py3-pip \
      rsync && \
    rm -rf /var/cache/apk/* && \
    python3 -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install --no-cache-dir -r /requirements.txt && \
    /opt/venv/bin/python -m pip cache purge

ENV PATH="/opt/venv/bin:${PATH}"

ADD cmd.sh /cmd.sh
CMD ["sh", "/cmd.sh"]
