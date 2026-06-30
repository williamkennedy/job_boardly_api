# frozen_string_literal: true

require "test_helper"

class TestHeadlessClient < JobBoardlyApi::TestCase
  def setup
    @client = JobBoardlyApi::HeadlessClient.new(board_host: "jobs.example.com")
  end

  def test_initialize_with_board_host
    client = JobBoardlyApi::HeadlessClient.new(board_host: "jobs.example.com")
    expected = URI.parse("https://jobs.example.com/headless/v1")
    assert_equal expected.to_s, client.instance_variable_get(:@base_url).to_s
  end

  def test_initialize_with_board_id
    client = JobBoardlyApi::HeadlessClient.new(board_id: 42)
    expected = URI.parse("https://api.jobboardly.com/headless/v1/boards/42")
    assert_equal expected.to_s, client.instance_variable_get(:@base_url).to_s
  end

  def test_initialize_without_arguments_raises
    assert_raises(ArgumentError) do
      JobBoardlyApi::HeadlessClient.new
    end
  end

  def test_bootstrap
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/bootstrap", expected_auth: nil) do
      @client.bootstrap
    end
  end

  def test_create_subscriber
    stub_http_request(expected_method: :post, expected_path: "/headless/v1/subscribers", expected_body: '{"subscriber":{"email":"a@b.com"}}', expected_auth: nil) do
      @client.create_subscriber(subscriber: { email: "a@b.com" })
    end
  end

  def test_jobs_with_params
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/jobs", expected_query: "page=1&per=10", expected_auth: nil) do
      @client.jobs(page: 1, per: 10)
    end
  end

  def test_jobs_without_params
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/jobs", expected_auth: nil) do
      @client.jobs
    end
  end

  def test_job
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/jobs/123", expected_auth: nil) do
      @client.job(123)
    end
  end

  def test_categories
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/categories", expected_auth: nil) do
      @client.categories
    end
  end

  def test_arrangements
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/arrangements", expected_auth: nil) do
      @client.arrangements
    end
  end

  def test_places_with_params
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/places", expected_query: "q=berlin", expected_auth: nil) do
      @client.places(q: "berlin")
    end
  end

  def test_places_without_params
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/places", expected_auth: nil) do
      @client.places
    end
  end

  def test_blog_posts_with_params
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/blog_posts", expected_query: "tag=ruby", expected_auth: nil) do
      @client.blog_posts(tag: "ruby")
    end
  end

  def test_blog_posts_without_params
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/blog_posts", expected_auth: nil) do
      @client.blog_posts
    end
  end

  def test_blog_post
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/blog_posts/hello-world", expected_auth: nil) do
      @client.blog_post("hello-world")
    end
  end

  def test_page
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/pages/about-us", expected_auth: nil) do
      @client.page("about-us")
    end
  end

  def test_employer_products
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/employer_products", expected_auth: nil) do
      @client.employer_products
    end
  end

  def test_candidate_products
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/candidate_products", expected_auth: nil) do
      @client.candidate_products
    end
  end

  def test_membership_plans
    stub_http_request(expected_method: :get, expected_path: "/headless/v1/membership_plans", expected_auth: nil) do
      @client.membership_plans
    end
  end
end
