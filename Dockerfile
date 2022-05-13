FROM fedora:35

LABEL maintainer="Michael Buluma <me@buluma.co.ke>"
LABEL build_date="2022-05-13"

WORKDIR /github/workspace

RUN dnf install -y docker \
                   gcc \
                   git-core \
                   python3-devel \
                   python3-libselinux \
                   python3-jmespath \
                   python3-pip ; \
    dnf clean all

ADD requirements.txt /requirements.txt
RUN python -m pip install -r /requirements.txt

ADD cmd.sh /cmd.sh
CMD sh /cmd.sh
