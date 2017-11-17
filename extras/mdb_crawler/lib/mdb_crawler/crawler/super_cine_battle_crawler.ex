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
  require Logger

  @url "https://www.supercinebattle.fr/"
  @hearders []
  @options [follow_redirect: true]

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

  @doc """
  Function used to parse HTML to return a list of links
  """
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
  def parse(datas) when map_size(datas) == 0, do: []

  @doc """
  Function used to parse HTML table
  """
  def parse(datas) do
    Enum.into(datas, %{}, fn({url, body}) -> 
      transformed_rows = body
      |> Floki.find(".tableizer-table tbody tr")
      |> fetch_rows
      
      {url, transformed_rows}
    end)  
  end  
  
  @doc """
  Function used to manage table rows
  """
  def fetch_rows(rows) do
    Enum.map(rows, &fetch_row_infos(&1))
  end

  @doc """
  Function used to fetch values from table row
  """
  def fetch_row_infos(row) do
    with {_, _, [position_info, title_info, show_info]} <- row do
      position = fetch_td_value(position_info)
      title = fetch_td_value(title_info)
      show_nb = fetch_td_value(show_info)

      {position, title, show_nb}
    else
      err -> Logger.error "Error parsing the row data #{inspect err}"
      {}
    end
  end

  @doc """
  Function used to return row value
  """
  def fetch_td_value(td_info) do
    with {_, _, [value]} <- td_info do 
      value
    else
      err -> Logger.error "Error parsing the td data #{inspect err}"
      ""
    end
  end

end
