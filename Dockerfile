# DEVELOPMENT DOCKERFILE

FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

ENV RAILS_SERVE_STATIC_FILES "true"
ENV SECRET_KEY_BASE "f49f8a51d7e5dc5c3db3065bf3a03f0380ebbd2cae9896a9cc278bd19aab5010e5bf8f7a284d7a27d489eebe958b8d3c8ab8bd111818c56d1a286974fbc8719c"
RUN rails assets:clobber && rails assets:precompile

EXPOSE 3333
CMD ["rails", "server"]