defmodule MdbCrawler.Crawler.SenscritiqueCrawler do
  @moduledoc """
  Module allowing to crawl Senscritique website.
  Steps:
    1/ Call a website homepage
    2/ Retrieve top menu (links) from the page
    3/ Go to films page
    4/ - Parse liste des films à l'affiche à partir des liens du top menu: https://www.senscritique.com/films/toujours-a-l-affiche
       - Parse liste des films de 2017: https://www.senscritique.com/top/resultats/Les_meilleurs_films_de_2017/1522840
    5/ Return a list of HTMLs for every links => %{ "<name>" => [<list>], ...}
   """
  require Logger

  @url "https://www.senscritique.com"
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
    |> Floki.find("header .header-navigation-main-wrapper .no-universe ul li a") # Retrieve links to pages
    |> Floki.attribute("href") # Retrieve urls from links
  end

  @doc """
  Fetch links to retrieve movie page relative path.

  """
  def fetch_movie_page_link(relative_paths) do
    relative_paths
    |> Enum.find(fn(relative_path) -> Regex.match?(~r/films/, relative_path) end)
  end

  @doc """
  Fetch useful links from movie page
  ["/films/toujours-a-l-affiche", "/films/sorties-cinema/2018/semaine/01",
   "/top/resultats/Les_meilleurs_films_de_2017/1522840", "/films/sondages",
   "/everymovie/programme-tv"]

  """
  def fetch_movie_page_links(relative_path) when is_nil(relative_path), do: []

  def fetch_movie_page_links(relative_path) do
    url = @url <> relative_path

    url
    |> fetch
    |> Floki.find("li.header-navigation-main-wrapper a")
    |> Floki.attribute("href")
  end

  def fetch_movies_list_links(links) do
    links
    |> Enum.filter(fn(relative_path) -> Regex.match?(~r/(\/films\/toujours.+affiche|\/top\/.+meilleurs_films)/, relative_path) end)
  end

  # @doc """
  # Return list of bodies
  # Steps:
  # 1/ Parse url to retrieve the year
  # 2/ Create map with the following infos %{<year> => <body>}
  # """
  # def get_bodies(urls) do
  #   Enum.into(urls, %{}, fn(url) ->
  #     {url, fetch(url)}
  #   end)
  # end

  # @doc """
  # Function goal is to transform html into list or maps
  # """
  # def parse(datas) when map_size(datas) == 0, do: []

  # @doc """
  # Function used to parse HTML table
  # """
  # def parse(datas) do
  #   Enum.into(datas, %{}, fn({url, body}) ->
  #     transformed_rows = body
  #     |> Floki.find(".tableizer-table tbody tr")
  #     |> fetch_rows

  #     {url, transformed_rows}
  #   end)
  # end

  # @doc """
  # Function used to manage table rows
  # """
  # def fetch_rows(rows) do
  #   Enum.map(rows, &fetch_row_infos(&1))
  # end

  # @doc """
  # Function used to fetch values from table row
  # """
  # def fetch_row_infos(row) do
  #   with {_, _, [position_info, title_info, show_info]} <- row do
  #     position = fetch_td_value(position_info)
  #     title = fetch_td_value(title_info)
  #     show_nb = fetch_td_value(show_info)

  #     {position, title, show_nb}
  #   else
  #     err -> Logger.error "Error parsing the row data #{inspect err}"
  #     {}
  #   end
  # end

  # @doc """
  # Function used to return row value
  # """
  # def fetch_td_value(td_info) do
  #   with {_, _, [value]} <- td_info do
  #     value
  #   else
  #     err -> Logger.error "Error parsing the td data #{inspect err}"
  #     ""
  #   end
  # end

end
