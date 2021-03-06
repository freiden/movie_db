defmodule SenscritiqueCrawlerTest do
  @moduledoc false

  alias MdbCrawler.Crawler.SenscritiqueCrawler, as: SenscritiqueCrawler

  use ExUnit.Case
  doctest SenscritiqueCrawler

  # # @tag capture_log: true # Doesn't work ?!!
  # describe ".fetch_td_value/1" do
  #   test "fetching value from tuple in the correct format" do
  #     assert SenscritiqueCrawler.fetch_td_value({1, 2, ["test"]}) == "test"
  #   end

  #   test "fetching value from tuple in the wrong format " do
  #     refute SenscritiqueCrawler.fetch_td_value({1, 2, "test"}) == "test"
  #     assert SenscritiqueCrawler.fetch_td_value({1, 2, "test"}) == ""
  #   end
  # end

  # describe ".fetch_row_infos/1" do
  #   test "fetching row will return a tuple with the value of tds composing it" do
  #     position = "1"
  #     title = "red is dead"
  #     show_nb = "1"

  #     successful_row = generate_row(position, title, show_nb)

  #     assert SenscritiqueCrawler.fetch_row_infos(successful_row) == {position, title, show_nb}
  #   end

  #   test "fetching row will return nil if fetching fails" do
  #     assert SenscritiqueCrawler.fetch_row_infos({"failure"}) == {}
  #   end
  # end

  # describe ".fetch_rows/1" do
  #   test "fetching rows will return a list" do
  #     assert SenscritiqueCrawler.fetch_rows([]) == []
  #   end
  # end

  # describe ".parse/1" do
  #   test "returns an empty list when called with an empty map" do
  #     assert SenscritiqueCrawler.parse(%{}) == []
  #   end
  # end

  # defp generate_row(position, title, show_nb) do
  #   {
  #   "tr",
  #   [],
  #   [
  #     {"td", [], [position]},
  #     {"td", [], [title]},
  #     {"td", [], [show_nb]}
  #   ]}
  # end
end
