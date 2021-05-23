FROM fedora:33

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build-date="2021-02-12T10:27:00Z"

WORKDIR /github/workspace

RUN dnf install -y docker \
                   gcc \
                   git-core \
                   python3-devel \
                   python3-pip \
                   python3-libselinux \
                   python3-jmespath.noarch ; \
    dnf clean all

RUN pip install tox docker "molecule[ansible,docker]>=3,<4" ansible-lint testinfra

CMD function retry { counter=0 ; until "$@" ; do exit=$? ; counter=$(($counter + 1)) ; if [ $counter -ge ${max_failures:-3} ] ; then return $exit ; fi ; done ; return 0; } ; cd ${GITHUB_REPOSITORY:-.} ; if [ -f tox.ini -a ${command:-test} = test ] ; then retry tox ${options} ; else PY_COLORS=1 ANSIBLE_FORCE_COLOR=1 retry molecule ${command:-test} --scenario-name ${scenario:-default}; fi
