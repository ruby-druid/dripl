require "druid"
require "ripl"

module Dripl
  class Prompt
    attr_accessor :client, :source

    def initialize(client, source = nil)
      @client = client
      @source = nil
      use(source) if source
    end

    def start
      Ripl.start(argv: [], binding: binding)
    end

    def method_missing(*args)
      query.public_send(*args)
    end

    def query
      query = Druid::Query::Builder.new
      query.data_source(@source.name)
      query
    end

    def sources
      @client.data_sources.keys
    end

    def dimensions
      @source.dimensions.sort
    end

    def metrics
      @source.metrics.sort
    end

    def use(source)
      # TODO: source not found
      source = @client.data_sources.keys[source] if source.is_a?(Numeric)
      @source = @client.data_source(source)
      puts("Using #{@source.name} data source")
    end
  end
end

Ripl::Shell.include(Dripl::Formatter)
