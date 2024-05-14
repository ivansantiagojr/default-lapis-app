FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    libreadline-dev \
    libncurses5-dev \
    libpcre3-dev \
    libssl-dev \
    make \
    build-essential \
    unzip \
    git \
    lsb-release

RUN apt-get install wget gpgv ca-certificates -y

RUN wget -O - https://openresty.org/package/pubkey.gpg | apt-key add -

RUN wget -O - https://openresty.org/package/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/openresty.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/openresty.list > /dev/null

RUN apt-get update && apt-get install openresty -y

RUN apt-get install lua5.4 && apt-get install luarocks -y

RUN luarocks install lapis

WORKDIR /app

COPY . .

EXPOSE 8080

CMD ["lapis", "server"]