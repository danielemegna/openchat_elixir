# Open Chat Backend Kata

Develop a rest backend for the Open Chat project following api specification in material/APIs.yaml.

## About this Kata

This Kata is used by Robert C. Martin and Sandro Mancuso in "London vs. Chicago" cleancoders serie:

* https://cleancoders.com/videos?series=comparativeDesign
* https://github.com/sandromancuso/cleancoders_openchat/tree/starting-point
* https://github.com/sandromancuso/cleancoders_openchat_webclient
* https://github.com/danielemegna/cleancoders_openchat/tree/openchat-hexagonal

## Application start

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Docker dev container

Start it with ..
```
$ docker run --rm -itp 4000:4000 -v $PWD:/app -w /app elixir:alpine sh
```

.. into the container get deps
```
$ mix deps.get
```

.. and run test with
```
$ mix test
```

Start Phoenix endpoint via exposed 4000 port with
```
$ mix phx.server
```

### Refactoring notes:

- remove duplication in e2e regex uuid assertions
- FIX single e2e execution: `OpenchatElixirWeb.E2E.UsersApiTest.register_user/2` undefined (module `OpenchatElixirWeb.E2E.UsersApiTest` not available)
