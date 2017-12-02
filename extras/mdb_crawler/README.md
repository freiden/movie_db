# MdbCrawler

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mdb_crawler` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mdb_crawler, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mdb_crawler](https://hexdocs.pm/mdb_crawler).

## Objectives

* Crawl movies websites to obtain list of movies:
  * Senscritique: Tops lists (Best movies of all times, most popular, most popular of the current year).
  * SuperCineBattle: Lists per decades.
  * Allocine: Popular movies.
  * TBD
* Call the Rails API to store the data into the DB.

### Crawlers:

#### Specs

* Crawler coded and associated to a defined parameter
* 1 Crawler per site
* Use the same pattern for crawling

##### CLI

* CLI can be called with the following ways:
  * -h, --help => Provide infos on how to use the CLI.
  * -c, --crawler => Passed with a defined name it will crawl the associated website.
  * Directly called with a defined name it will crawl the associated website.

#### SuperCineBattle:

* Basic crawling:
  * Once the main page > Go to the list
  * On each list page parse table

#### Allocine
#### Senscritique
