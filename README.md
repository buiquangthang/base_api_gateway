
<p align="center">
  <a href="https://rubyonrails.org/"><img width="300" src="https://zakaria.dev/assets/images/rails_base_app/Ruby_On_Rails_Logo.png" alt="Ruby On Rails"></a>
  <a href="https://www.docker.com" style="margin-left: 20px"><img width="105" src="https://zakaria.dev/assets/images/rails_base_app/docker-logo.png" alt="Docker"></a>
</p>

# An example Rails 7 app

[![](https://badgen.net/badge/Rails/7.0.4.2/red)](https://github.com/zakariaf/rails-base-app/blob/main/Gemfile.lock) [![](https://badgen.net/badge/Ruby/3.2.1/red)](https://github.com/zakariaf/rails-base-app/blob/main/.ruby-version) [![GitHub license](https://img.shields.io/github/license/zakariaf/rails-base-app)](https://github.com/zakariaf/rails-base-app/blob/main/LICENSE)

**This app is built with Rails 7, Ruby 3 and is using Docker for building production images.**
This project is my boilerplate project to learning and practice microservice architecture. Otherwise, it follows the community best practices in terms of standards, security and maintainability, integrating a variety of testing and code quality tools.

Several gems and packages are included in this example app that I've been using for a long time. It wires up a number of things you might use in a real world Rails app. However, at the same time it's not loaded up with a million personal opinions.

<!-- List of all topics -->

## Table of Contents

- [Tech stack](#tech-stack)
  - [Back-end](#back-end)
  - [Front-end](#front-end)
  - [Healthy app](#healthy-app)
  - [Auth](#auth)
  - [Apps](#apps)
- [Running app](#running-app)
  - [Clone the repo](#clone-the-repo)
  - [Install dependencies](#install-dependencies)
  - [Copy .env to .env.local](#copy-env-to-envlocal)
  - [Setup database](#setup-database)
  - [Run the app](#run-the-app)
- [Renaming the project](#renaming-the-project)
- [Docker](#docker)
- [How to contribute](#how-to-contribute)
- [License](#license)

## Tech stack

Initially, I used the `rails new base_api_gateway -d postgresql` command to initialize the project using the importmaps and default configurations.
You can see a list of gems that are in the project with a link to their commit. Therefore, you can easily find what we configured for each gem.

**Note** there is a commit/branch for each gem/package and adding/changing a code in the repo, and you can see the list of the steps we did in order at the below. e.g. step 1 in the repo was **init project** and using **PostgreSQL**. step number 2 was adding **RSpec**, etc.

### Back-end

#### Testing Gems ([Setup PR](https://github.com/buiquangthang/base_api_gateway/pull/2))

* [Factory Bot](https://github.com/thoughtbot/factory_bot_rails) for test data
* [RSpec](https://github.com/rspec/rspec) for unit testing
* [Faker](https://github.com/faker-ruby/faker) for generating fake data
* [Database cleaner for active record](https://github.com/DatabaseCleaner/database_cleaner-active_record) to ensure a clean state for testing.
* [Shoulda Matchers](http://github.com/thoughtbot/shoulda-matchers) for common RSpec matchers
* [Simplecov](https://github.com/simplecov-ruby/simplecov) for code coverage
* [Webmock](https://github.com/bblimke/webmock) or stubbing http requests
* [Parallel Testing](https://github.com/grosser/parallel_tests) to speed up testing run time.

#### Linting Gems

* [RuboCop](https://github.com/rubocop/rubocop) Code quality and format.
* [Brakeman](https://github.com/presidentbeef/brakeman) Checking Ruby on Rails applications for security vulnerabilities. you can check `config/brakeman.ignore` to see ignore errors.
* [bundler-audit](https://github.com/rubysec/bundler-audit) Patch-level verification for bundler
* [Fasterer](https://github.com/DamirSvrtan/fasterer) Make Rubies code faster by suggestion some speed improvements. check `.fasterer.yml` to enable/disable suggestions

#### Common

* [overcommit](https://github.com/sds/overcommit) to manage and configure Git hooks by managing all healthy app tools. you can check `.overcommit.yml` to enable or disable tools.
* [boring_generators](https://github.com/abhaynikam/boring_generators) make your development faster by delegating boring setups to us.
* Enabling github action to run `overcommit` after push and pull requests in github. [Setup PR](https://github.com/buiquangthang/base_api_gateway/pull/12)


## Apps

## Running app

I generally recommend to use Docker only for building production images, and not for development. hence I didn't add any docker configs for development.

To run the app locally, you need to have [Ruby](https://www.ruby-lang.org/en/) and [PostgreSQL](https://www.postgresql.org/) installed on your machine.

### 1. Clone the repo

```bash
git clone https://github.com/buiquangthang/base_api_gateway.git
cd base_api_gateway
```

### 2. Install dependencies

```bash
bundle install # install ruby gems
yarn install # install node packages
```

### 3. Copy application.yml.sample to application.yml

Usually, you only need to change the Postgres variables in `application.yml` file to match your local database.

```bash
cp config/application.yml.sample config/application.yml
```

### 4. Setup database

```bash
bundle rails db:setup
```

### 5. Run the app

- Run the server

```bash
bundle rails s
```

- Run the frontend

```bash
yarn dev
```

## Docker

**NOTE** Dockerize is not complete yet, I will update it soon.

## How to contribute

I'm happy to accept any contributions you might want to make. Please follow these steps:

1. Fork the repo
2. Create a new branch
3. Make your changes
4. Run the test suite
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## TODO

- [ ] automatic deploy process using MRSK
- [ ] Add cucumber (e2e testing)
- [ ] Dockerize app
- [ ] Setup Github Action
- [ ] UI CRUD routes and service
