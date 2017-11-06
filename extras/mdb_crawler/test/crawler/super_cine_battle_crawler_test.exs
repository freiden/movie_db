defmodule SuperCineBattleCrawlerTest do
  alias MdbCrawler.Crawler.SuperCineBattleCrawler, as: SuperCineBattleCrawler

  use ExUnit.Case
  doctest SuperCineBattleCrawler

  test "greets the world" do
    assert SuperCineBattleCrawler.hello() == :world
  end
end
