require "druid"
require "mixlib/cli"

module Dripl
  class CLI
    include Mixlib::CLI

    option :zookeeper,
      short: "-z URL",
      long: "--zookeeper URL",
      description: "Zookeeper URL"

    option :source,
      short: "-s NAME",
      long: "--source NAME",
      description: "default data source"

    option :help,
      short: "-h",
      long: "--help",
      description: "Show this message",
      on: :tail,
      boolean: true,
      show_options: true,
      exit: 0

    def run
      if zookeeper = config[:zookeeper]
        client = Druid::Client.new(zookeeper)
      end

      unless client
        # TODO:
        puts "error"
      end

      Prompt.new(client, config[:source]).start
    end
  end
end
