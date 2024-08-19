FROM ruby:3.2.2
COPY main.rb .
ADD lib lib
ENTRYPOINT ["ruby", "main.rb"]