# 19.01.20現在最新安定版のイメージを取得
FROM ruby:2.5.3

# dockerizeパッケージダウンロード用環境変数
ENV DOCKERIZE_VERSION v0.6.1

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    mariadb-client  \
    build-essential  \
    wget \
    vim \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN mkdir /app_name
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# エラー回避の為、bundlerのバージョン下げる
RUN gem install bundler:1.17.3
RUN bundle install
ADD . $APP_ROOT
