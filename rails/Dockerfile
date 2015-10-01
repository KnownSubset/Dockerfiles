FROM radialogica/ruby:2.2.3

ENV RAILS_VERSION 4.2.4

RUN  apt-get update \
  && apt-get install -y git cron gcc build-essential sqlite3 libmysqlclient-dev --no-install-recommends \
  && rm -rf /var/lib/apt/lists \
  && gem update --system \
  && gem pristine --all \
  && gem install rails:$RAILS_VERSION rails-api json:1.8.2 bcrypt sqlite3 \
  && rm -rf /var/lib/apt/lists

CMD ["rails"]
