# Heb

This is a sample REST API with the following endpoints:

#### GET /images

• Returns HTTP 200 OK with a JSON response containing image details for all images including their metadata if available

#### GET /images/{id}

• Returns HTTP 200 OK with a JSON response containing image details for the specified image

#### GET /images?objects="dog,cat"

• Returns a HTTP 200 OK with a JSON response body containing image details for images that have been tagged with any of the objects listed

#### POST /images

• Posts a JSON request object which must include an base64 encoded image (no Data URI Scheme) or URL. The request may also include an optional label for the image, and an optional field to enable object detection.
• Returns a HTTP 200 OK with a JSON response body including image details for the created image. To start your Phoenix server:

#### Getting Started

This project requires Elixir 1.14 or later and a PostgreSQL database.

You can reference Elixir's [official installation guide](https://elixir-lang.org/install.html) for detailed instructions.

For quick setup simply run `brew install elixir`.

For help with PostgreSQL, see [PostgreSQL's download guide](https://www.postgresql.org/download/).

Once you have Elixir and PostgreSQL installed:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Although most requests should be made via Postman or in the terminal via `curl`, I have built in some view functionality if you visit [`localhost:4000`](http://localhost:4000) from your browser.

#### Imagga

This application uses Imagga to tag images. An api key is required to authenticate POST requests. For details on creating an API key please consult: [https://docs.imagga.com/?shell#getting-started](https://docs.imagga.com/?shell#getting-started). (Or email me, a key can be provided).

Once you have an api key, add it to `/config/secret.exs` as: `config :heb, api_key: "<your api key>"`

#### Tests

The entire test suite can be run via `mix test` and will run with mocked API results.

#### Sending Requests

See `resources/curl.text` for example `curl` commands.

## Caveats

The request to upload a local image (and subsequently search for objects) is still a WIP as I was out of town 6/7 days this week. I started initial implementation but didn't finish :/
