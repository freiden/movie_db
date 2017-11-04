defmodule CliTest do
  use ExUnit.Case
  doctest MdbCrawler

  import ExUnit.CaptureIO
  import MdbCrawler.CLI, only: [parse_args: 1]

  describe ".parse_args/1" do
    test ":help returned by option parsing with -h and --help options" do
      assert parse_args(["-h", "anything"]) == :help
      assert parse_args(["--help", "anything"]) == :help
    end

    test ":help returned when name not in the crawlers list" do
      assert parse_args(["--crawler", "error"]) == :help
      assert parse_args(["error"]) == :help
    end

    test ":atom returned by option parsing with the parsing option and a name" do
      assert parse_args(["-c", "supercinebattle"]) == :supercinebattle
      assert parse_args(["--crawler", "supercinebattle"]) == :supercinebattle
    end

    test ":atom returned by option parsing with just a name" do
      assert parse_args(["supercinebattle"]) == :supercinebattle
    end
  end

  # describe ".process/1" do
  #   # Can't be tested for the moment because the System.halt/1 function stop the test suite
  #   test "when :help is passed it returns a string" do
  #     # assert process(:help) == System.halt(0)
  #     # assert capture_io(process(:help)) =~ "Usage:"
  #     # assert catch_exit(process(:help)) == 0
  #   end
  #
  #   # test "when :supercinebattle is passed it called the crawl related function" do
  #   #   process(:supercinebattle)
  #   #   assert_received MdbCrawler.crawl(:supercinebattle)
  #   # end
  # end
end
