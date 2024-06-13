# Github Repository Quality Analyzer

[![Actions Status](https://github.com/kitXIII/rails-project-66/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kitXIII/rails-project-66/actions)
[![CI](https://github.com/kitXIII/rails-project-66/actions/workflows/ci.yml/badge.svg)](https://github.com/kitXIII/rails-project-66/actions/workflows/ci.yml)

Github repository quality analyzer project built with Ruby on Rails.
The analyzer helps to automatically monitor the quality of repositories on Github.
It tracks code changes and runs built-in analyzers. Then it generates reports and sends them to the user.

The [demo](https://kitxiii-github-quality.onrender.com/) is published on [render](https://render.com/) service.

### Implementation Features

* OAuth Github authentication
* State management with [aasm](https://github.com/aasm/aasm)
* Adaptive UI with [bootstrap](https://getbootstrap.com)
* Using asynchronous tasks to query and perform repository checks

### Development


#### Requirements

* Ruby 3.2.2 or higher

#### Local start

1) Install dependencies and prepare local database, with running:
    ```shell
    make setup
    ```

2) Run app locally:
    ```shell
    make start
    ```

3) Open your browser at http://localhost:3000


#### Tests and linter check

* Tests can be start using:
    ```shell
    make test
    ```

* Linter check can be run with:
    ```shell
    make lint
    ```
