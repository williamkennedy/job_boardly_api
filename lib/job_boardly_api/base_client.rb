# frozen_string_literal: true

require "net/http"
require "json"
require "uri"

module JobBoardlyApi
  class BaseClient
    def initialize(base_url:)
      @base_url = URI.parse(base_url.to_s)
    end

    def get(path, params = {})
      make_request(Net::HTTP::Get, path, params)
    end

    def post(path, params = {}, body = {})
      make_request(Net::HTTP::Post, path, params, body)
    end

    def patch(path, params = {}, body = {})
      make_request(Net::HTTP::Patch, path, params, body)
    end

    def delete(path, params = {})
      make_request(Net::HTTP::Delete, path, params)
    end

    private

    def make_request(http_class, path, params = {}, body = nil)
      uri = build_uri(path, params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"

      request = http_class.new(uri)
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      configure_request(request)
      request.body = JSON.dump(body) if body

      response = http.request(request)
      Response.new(response)
    end

    def build_uri(path, params)
      uri = @base_url.dup
      uri.path = uri.path.chomp("/") + path
      uri.query = URI.encode_www_form(params) if params && !params.empty?
      uri
    end

    def configure_request(request)
      # override in subclasses
    end
  end
end
