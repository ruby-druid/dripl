require "awesome_print"
require "druid"
require "terminal-table"

module Dripl
  module Formatter
    def format_result(result)
      return unless result

      if result.is_a?(Druid::Query::Builder)
        start_time = Time.now
        response = eval("source", binding).post(result)
        puts(format_query_response(result.query, response))
        puts("Query took #{Time.now - start_time}s")
      else
        ap(result)
      end

      return # prevent default formatting
    end

    private

    def format_query_response(query, response)
      ap(query.as_json)
      ap(response.as_json)
      return if response.empty?
      case query.queryType
      when "timeseries", "groupBy"
        format_timeseries_query_response(query, response)
      when "segmentMetadata"
        format_segment_metadata_response(query, response)
      end
    end

    def response_key(type)
      case type
      when "timeseries"
        "result"
      when "groupBy"
        "event"
      end
    end

    def format_timeseries_query_response(query, response)
      response_key = response_key(query.queryType)
      keys = response.last[response_key].keys
      grouped_response = response.group_by { |x| x["timestamp"] }

      Terminal::Table.new(headings: keys) do
        grouped_response.each do |timestamp, rows|
          add_row(:separator) unless timestamp == response.first["timestamp"]
          add_row([{ value: timestamp, colspan: keys.length }])
          add_row(:separator)
          rows.each { |row| add_row(keys.map { |key| row[response_key][key] }) }
        end
      end
    end

    def format_segment_metadata_response(query, response)
      columns = response.map { |row| row["columns"].keys }
        .to_a.flatten.uniq.sort
      Terminal::Table.new(:headings => columns) {}
    end
  end
end
