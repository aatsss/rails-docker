# syntax=docker/dockerfile:1
FROM amd64/ruby:2.6.3
RUN apt-get update -qq \
    && apt-get install -y sudo man less \
    && apt-get install -y make vim nodejs postgresql-client 

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY . /myapp
RUN bundle install \
    && sudo apt-get install -y zlib1g-dev liblzma-dev patch \
    && gem install nokogiri --platform=ruby


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
