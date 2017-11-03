defmodule MdbCrawler.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up fetch data from the
  crawled websites.
  """
  def run(argv) do
    parse_args(argv)
  end

  @moduledoc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is the name of one of the available crawlers.

  Returns a tuple `{status, result}` or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
      aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {_, crawler, _} -> crawler
      _ -> :help
    end
  end
end
