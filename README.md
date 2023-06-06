# Theatre Schedule Management API

This is a simple API for managing a theatre's schedule. It's built with Ruby on Rails and PostgreSQL.

## Features

- CRUD operations for performances.
- Dates validation: avoid overlapping performances.
- Pagination for index endpoint.

## Requirements

- Ruby 3.2.1
- Rails 7.0.0
- PostgreSQL 13
- Docker and Docker Compose(if you want use docker)

## Setup

1. Clone the repository:
    ```sh
    git clone git@github.com:gushul/amarket_homework.git
    ```

2. Navigate to the project directory:
    ```sh
    cd amarket_homework
    ```

3. Build and set up the project using the Makefile:
    ```sh
    make setup
    ```

## Usage

- To start the server:
    ```sh
    make server
    ```

- To open a Rails console:
    ```sh
    make console
    ```

- To run the test suite:
    ```sh
    make test
    ```

- To run database migrations:
    ```sh
    make migrate
    ```

- To take down the Docker environment:
    ```sh
    make down
    ```

## API Documentation

The API documentation is available at `http:localhost:3000/api-docs`.
