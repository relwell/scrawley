# Scrawley

## Purpose

* Easily, anonymously associate short text with geospatial data
* Make it easy to get notifications about text you're interested when you
  get within the vicinity of a tag or phrase you have opted into

## PostGis

We're using PostGis for easy spatial integration with PostGres.
PostGis is enabled when building the database.

## Leaflet

We use [Leaflet](leafletjs.com) for handling mapping. It's not bad, check it out.

## Heroku

Deployed with Heroku, yo.

## Todo

* Implement Presence to make it easier to broadcast messages to the right users

## Getting Started

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
