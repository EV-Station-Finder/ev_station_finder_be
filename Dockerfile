FROM ruby:2.5.3 
# change Ruby version to match what your app uses. 

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app 
#this can be anything

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
#install rake version used for your project as seen in gemlock file.
RUN gem install rake -v 13.0.4
RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]]