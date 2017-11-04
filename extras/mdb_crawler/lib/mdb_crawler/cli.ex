defmodule MdbCrawler.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up fetch data from the
  crawled websites.
  """
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @moduledoc """
  `argv` can be -h or --help, which returns :help.
  `argv` can be -c or --crawler and an available `crawler` name, it returns the
  crawler name as an atom.

  Otherwise it is the name of one of the available crawlers.

  Returns a tuple `{status, result}` or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,
      switches: [help: :boolean, crawler: :string],
      aliases: [h: :help, c: :crawler])

    case parse do
      {[help: true], _, _} -> :help
      {[crawler: crawler], _, _} -> String.to_atom(crawler)
      {_, [crawler], _} -> String.to_atom(crawler)
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    Usage:
      -h, --help to display the following screen
      -c (or --crawler) <crawler_name> to retrieve data from a website
    """
    System.halt(0)
  end

  def process(:supercinebattle) do
    MdbCrawler.crawl(:supercinebattle)
  end
end
