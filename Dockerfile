#docker build -t devenv:1.0.0 -f Dockerfile . --network=host
FROM debian:11
RUN apt-get update
RUN apt-get install git -y
RUN apt-get install wget -y
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.15.0
RUN mkdir /usr/local/nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN node -v
RUN npm -v
RUN mkdir -p /home/develop
WORKDIR /home/develop
RUN npm install -g @ionic/cli native-run cordova-res
ENTRYPOINT ["tail", "-f", "/dev/null"]
