# frozen_string_literal: true

require "test_helper"

class TestResponse < JobBoardlyApi::TestCase
  def test_success_for_200
    mock = mock_http_response(status_code: 200, body: '{"id":1}')
    response = JobBoardlyApi::Response.new(mock)
    assert response.success?
    assert_equal({ "id" => 1 }, response.body)
  end

  def test_success_for_201
    mock = mock_http_response(status_code: 201, body: '{"id":1}')
    response = JobBoardlyApi::Response.new(mock)
    assert response.success?
  end

  def test_failure_for_404
    mock = mock_http_response(status_code: 404, body: '{"error":"not found"}')
    response = JobBoardlyApi::Response.new(mock)
    refute response.success?
  end

  def test_body_parses_json
    mock = mock_http_response(status_code: 200, body: '{"key":"value"}')
    response = JobBoardlyApi::Response.new(mock)
    assert_equal({ "key" => "value" }, response.body)
  end

  def test_body_returns_raw_string_for_invalid_json
    mock = mock_http_response(status_code: 200, body: "not json")
    response = JobBoardlyApi::Response.new(mock)
    assert_equal "not json", response.body
  end

  def test_body_is_nil_for_empty_body
    mock = mock_http_response(status_code: 204, body: "")
    response = JobBoardlyApi::Response.new(mock)
    assert_nil response.body
  end

  def test_to_object_returns_open_struct
    mock = mock_http_response(status_code: 200, body: '{"id":1,"name":"Test"}')
    response = JobBoardlyApi::Response.new(mock)
    obj = response.to_object
    assert_equal 1, obj.id
    assert_equal "Test", obj.name
  end

  def test_to_object_returns_nil_when_body_is_nil
    mock = mock_http_response(status_code: 204, body: "")
    response = JobBoardlyApi::Response.new(mock)
    assert_nil response.to_object
  end

  def test_headers
    mock = mock_http_response(status_code: 200, body: "{}", headers: { "content-type" => "application/json" })
    response = JobBoardlyApi::Response.new(mock)
    assert_equal({ "content-type" => "application/json" }, response.headers)
  end

  def test_status
    mock = mock_http_response(status_code: 418, body: "{}")
    response = JobBoardlyApi::Response.new(mock)
    assert_equal 418, response.status
  end
end
