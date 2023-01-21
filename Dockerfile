FROM ubuntu:23.04

SHELL ["/bin/bash", "-c"]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get -qq install -y unzip zip curl

RUN curl -s "https://get.sdkman.io" | bash
RUN source $HOME/.sdkman/bin/sdkman-init.sh

COPY ./config/config.properties /root/.sdkman/etc/config

# Needed for non-interactive shells instead of editing the .bashrc file
RUN echo -e '#!/bin/bash\nsource /root/.sdkman/bin/sdkman-init.sh && sdk "$@"' > /usr/bin/sdk && \
    chmod +x /usr/bin/sdk

CMD sdk version