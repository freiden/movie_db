defmodule MdbCrawler do
  @moduledoc """
  Documentation for MdbCrawler.
  """
  alias MdbCrawler.Crawler.SuperCineBattleCrawler, as: SuperCineBattleCrawler

  @hearders []
  @options [follow_redirect: true]
  @urls %{supercinebattle: "https://www.supercinebattle.fr/"}

  @doc """
  Hello world.

  ## Examples

      iex> MdbCrawler.hello
      :world

  """
  def hello do
    :world
  end

  @doc """
  Function goal is to retrieve the data from the website.
  Parameter => url
  Result => List of HTML content
  """
  def fetch(url) do
    url
    |> HTTPoison.get(@hearders, @options)
    |> handle_response
  end

  @doc """
  Function goal is to return the HTML of the source
  """
  def handle_response({:ok, %{body: body}}) do
    body
  end

  def handle_response(_response) do
    []
  end

  # def crawl(:senscritique) do
  #   # TBD
  #   # Usage of SenscritiqueCrawler
  # end
  #
  # def crawl(:allocine) do
  #   # TBD
  #   # Usage of AllocineCrawler
  # end

  def crawl(:supercinebattle) do
    # TBD
    # Usage of SuperCineBattleCrawler
    # Load module => Directory of modules and call of it in library
    fetch(@urls[:supercinebattle]) # Retrieve HTML
    |> SuperCineBattleCrawler.get_links
    # |> Enum.map(&SuperCineBattleCrawler.fetch/1)
    |> SuperCineBattleCrawler.get_bodies
    |> SuperCineBattleCrawler.parse # Transform content into data
    |> store # Store retrieve datas
  end

  def store(_) do
    :ok
  end
end
