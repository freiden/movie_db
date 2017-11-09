defmodule MdbCrawler.Crawler.SuperCineBattleCrawler do
  @moduledoc """
  Module allowing to crawl SuperCineBattle website.
  Steps:
    1/ Call a website homepage
    2/ Retrieve links from the page
    3/ For each links, parse the data to retrieve the table infos
    4/ Return a list of HTMLs for every links => %{ "<name>" => [<list>], ...}
    ["https://www.supercinebattle.fr/la-liste-ultime-des-films-des-annees-2000/",
   "https://www.supercinebattle.fr/la-liste-ultime-des-films-des-annees-70/",
   "https://www.supercinebattle.fr/la-liste-ultime-des-films-des-annees-80/",
   "https://www.supercinebattle.fr/la-liste-ultime-des-films-des-annees-90/"]
  """
  @url "https://www.supercinebattle.fr/"
  @hearders []
  @options [follow_redirect: true]

  def hello do
    :world
  end

  @doc """
  Function goal is to retrieve the data from the website.
  Parameter => url
  Result => List of HTML content
  """
  def fetch(url \\ @url) do
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
    ""
  end

  def get_links([]) do
    []
  end

  def get_links(body) do
    body
    |> Floki.find(".widget_pages ul a") # Retrieve links to pages
    |> Floki.attribute("href") # Retrieve urls from links
  end

  @doc """
  Return list of bodies
  Steps:
  1/ Parse url to retrieve the year
  2/ Create map with the following infos %{<year> => <body>}
  """
  def get_bodies(urls) do
    Enum.into(urls, %{}, fn(url) -> 
      {url, fetch(url)}  
    end)
  end

  @doc """
  Function goal is to transform html into list or maps
  """
  # def parse(%{}) do
  #   %{}
  # end

  def parse(datas) do
    Enum.into(datas, %{}, fn({url, body}) -> 
      rows = body
        |> Floki.find(".tableizer-table tbody tr")
      
      Enum.each(rows, fn({_, _, [{td_position}, td_title, td_show_nb]}) -> 
        # {_,_, [position]}, {_, _, [title]}, {_, _, [show_nb]}]}
        # IO.inspect("#{position} - #{title} _ #{show_nb}")

      end)

      {url, rows}
    end)
  end
end
