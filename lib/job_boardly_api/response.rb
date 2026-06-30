# frozen_string_literal: true

require "json"
require "ostruct"

module JobBoardlyApi
  class Response
    attr_reader :raw_response, :body, :status, :headers

    def initialize(response)
      @raw_response = response
      @status = response.code.to_i
      @headers = response.each_header.to_h
      @body = parse_body(response.body)
    end

    def success?
      (200..299).cover?(@status)
    end

    def to_object
      return nil if @body.nil?

      JSON.parse(JSON.generate(@body), object_class: OpenStruct)
    end

    private

    def parse_body(body)
      return nil if body.nil? || body.empty?

      JSON.parse(body)
    rescue JSON::ParserError
      body
    end
  end
end
