FROM quay.io/radialogica/ruby:2.2

ENV RAILS_VERSION 4.2.1

COPY railsLogRotate.conf /etc/railsLogRotate.conf

RUN  apt-get update \
  && apt-get install -y git logrotate cron gcc build-essential sqlite3 --no-install-recommends \
  && rm -rf /var/lib/apt/lists \
  && gem update --system \
  && gem pristine --all \
  && gem install rails:$RAILS_VERSION rails-api json:1.8.2 bcrypt thin \
  && chmod 0600 /etc/railsLogRotate.conf

CMD ["rails"]
