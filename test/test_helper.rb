# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "job_boardly_api"

require "minitest/autorun"

module JobBoardlyApi
  class TestCase < Minitest::Test
    def mock_http_response(status_code:, body:, headers: {})
      response = Minitest::Mock.new
      response.expect(:code, status_code.to_s)
      response.expect(:body, body)
      response.expect(:each_header, headers)
      response
    end

    def stub_http_request(expected_method:, expected_path:, expected_body: nil, expected_query: nil, expected_auth: nil)
      response = mock_http_response(status_code: 200, body: "{}")
      http = Minitest::Mock.new
      http.expect(:use_ssl=, nil, [TrueClass])

      http.expect(:request, response) do |request|
        actual_uri = URI.parse(request.path)

        assert_equal expected_method.to_s.upcase, request.method
        assert_equal expected_path, actual_uri.path
        if expected_query.nil?
          assert_nil actual_uri.query
        else
          assert_equal expected_query, actual_uri.query
        end
        assert_equal "application/json", request["Content-Type"]
        assert_equal "application/json", request["Accept"]

        if expected_body
          assert_equal expected_body, request.body
        end

        if expected_auth
          assert_equal expected_auth, request["Authorization"]
        end

        true
      end

      Net::HTTP.stub :new, http do
        yield
      end

      http.verify
    end
  end
end
