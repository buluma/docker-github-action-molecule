FROM fedora:38

LABEL maintainer="Shadow Walker <bulumaknight@gmail.com>"
LABEL build_date="2023-05-16"

WORKDIR /github/workspace

RUN dnf install -y docker \
                   gcc \
                   git-core \
                   python3-devel \
                   python3-libselinux \
                   python3-jmespath \
                   python3-pip \
                   rsync ; \
    dnf clean all

ADD requirements.txt /requirements.txt
RUN python3 -m pip install -r /requirements.txt && \
    python3 -m pip cache purge

ADD cmd.sh /cmd.sh
CMD sh /cmd.sh
