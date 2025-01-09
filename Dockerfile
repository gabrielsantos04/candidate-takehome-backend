# Use official Ruby image with a specific version
FROM ruby:3.0.7

# Set environment variables to avoid interactive prompts during bundle install
ENV LANG C.UTF-8

# Install dependencies for Rails and SQLite3
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  sqlite3 \
  libsqlite3-dev \
  yarn \
  && apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Install gems using the Gemfile (Rails app dependencies)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets for production (optional, only for production)
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose the port your app runs on (default is 3000)
EXPOSE 3000

# Set the default command to start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
