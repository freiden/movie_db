defmodule MdbCrawler do
  @moduledoc """
  Documentation for MdbCrawler.
  """
  alias MdbCrawler.Crawler.SuperCineBattleCrawler, as: SuperCineBattleCrawler

  @doc """
  Hello world.

  ## Examples

      iex> MdbCrawler.hello
      :world

  """
  def hello do
    :world
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
    SuperCineBattleCrawler.fetch # Retrieve HTML
    |> SuperCineBattleCrawler.get_links
    |> SuperCineBattleCrawler.get_bodies
    |> SuperCineBattleCrawler.parse # Transform content into data
    |> store # Store retrieve datas
  end

  def store(_) do
    :ok
  end
end
