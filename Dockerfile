FROM buluma/fedora:35

LABEL maintainer="Michael Buluma <me@buluma.co.ke>"
LABEL build_date="2022-02-12"

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

# Temporary retry loop
ADD requirements.yml /tmp/

RUN \
      for i in {5..1}; do \
        if ansible-galaxy role install -vr /tmp/requirements.yml; then \
          break; \
        elif [ $i -gt 1 ]; then \
          sleep 10; \
        else \
          exit 1; \
        fi; \
      done \
  &&  ansible-galaxy role list
# End Temp

ADD cmd.sh /cmd.sh
CMD sh /cmd.sh
