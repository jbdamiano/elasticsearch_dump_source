# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
require 'rest_client'
require 'json'

# Class ESDumpSource
# attribute:
#   pattern: name of indice or indice/type
#   scroll_time: time that scrol will be keep 1m by default (accessor write)
#   size: returned size by scroll request 50 by default (accessor write)
#   host: elasticsearch host localhost by default (accessor write)
#   port: elasticsearch port 9200 by default (accessor write)
class ESDumpSource
  attr_writer :scroll_time, :size, :host, :port
  def initialize(pattern)
    @pattern = pattern
    @scroll_time = '1m'
    @size = 50
    @host = 'localhost'
    @port = 9200
    @scroll_id = nil
    @result = []
    @end = false
  end

  def retrieve_scroll_id(data)
    @scroll_id = data['_scroll_id']
  end

  def parse_result(hits)
    if hits.length == 0
      @end = true
      return
    end
    hits.each do |entry|
      @result += [entry['_source']]
    end
  rescue => e
    puts e.message
    exit 1
  end

  def retrieve_data_scroll_id
    uri = "http://#{@host}:#{@port}/_search/scroll?scroll=#{@scroll_time}"
    until @end
      response = RestClient.post(uri, @scroll_id,
                                 content_type: :json, accept: :json)
      data = JSON.parse response
      retrieve_scroll_id(JSON.parse(response))
      parse_result(data['hits']['hits'])
    end
  end

  def retrieve_data
    uri = "http://#{@host}:#{@port}/#{@pattern}/_search?search_type=scan" + \
          "&scroll=#{@scroll_time}&size=#{@size}"
    response = RestClient.get(uri, accept: :json)
    retrieve_scroll_id(JSON.parse(response))
    retrieve_data_scroll_id
    @result.to_json
  rescue  => e
    puts e.message
    exit 1
  end
end
