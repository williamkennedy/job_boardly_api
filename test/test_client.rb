# frozen_string_literal: true

require "test_helper"

class TestClient < JobBoardlyApi::TestCase
  def setup
    @client = JobBoardlyApi::Client.new(api_key: "test_key")
  end

  def test_initialize_with_api_key_only
    client = JobBoardlyApi::Client.new(api_key: "key")
    assert_equal "key", client.instance_variable_get(:@api_key)
  end

  def test_initialize_with_board_host
    client = JobBoardlyApi::Client.new(api_key: "key", board_host: "jobs.example.com")
    expected = URI.parse("https://api.jobs.example.com/v1")
    assert_equal expected.to_s, client.instance_variable_get(:@base_url).to_s
  end

  def test_initialize_with_base_url
    client = JobBoardlyApi::Client.new(api_key: "key", base_url: "https://custom.example/v1")
    expected = URI.parse("https://custom.example/v1")
    assert_equal expected.to_s, client.instance_variable_get(:@base_url).to_s
  end

  def test_me
    stub_http_request(expected_method: :get, expected_path: "/v1/me", expected_auth: "Bearer test_key") do
      @client.me
    end
  end

  def test_categories
    stub_http_request(expected_method: :get, expected_path: "/v1/categories", expected_auth: "Bearer test_key") do
      @client.categories
    end
  end

  def test_category
    stub_http_request(expected_method: :get, expected_path: "/v1/categories/1", expected_auth: "Bearer test_key") do
      @client.category(1)
    end
  end

  def test_arrangements
    stub_http_request(expected_method: :get, expected_path: "/v1/arrangements", expected_auth: "Bearer test_key") do
      @client.arrangements
    end
  end

  def test_jobs_with_params
    stub_http_request(expected_method: :get, expected_path: "/v1/jobs", expected_query: "page=1&per=10", expected_auth: "Bearer test_key") do
      @client.jobs(page: 1, per: 10)
    end
  end

  def test_jobs_without_params
    stub_http_request(expected_method: :get, expected_path: "/v1/jobs", expected_auth: "Bearer test_key") do
      @client.jobs
    end
  end

  def test_create_job
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs", expected_body: '{"title":"Engineer"}', expected_auth: "Bearer test_key") do
      @client.create_job(title: "Engineer")
    end
  end

  def test_job
    stub_http_request(expected_method: :get, expected_path: "/v1/jobs/123", expected_auth: "Bearer test_key") do
      @client.job(123)
    end
  end

  def test_update_job
    stub_http_request(expected_method: :patch, expected_path: "/v1/jobs/123", expected_body: '{"title":"Senior"}', expected_auth: "Bearer test_key") do
      @client.update_job(123, title: "Senior")
    end
  end

  def test_delete_job
    stub_http_request(expected_method: :delete, expected_path: "/v1/jobs/123", expected_auth: "Bearer test_key") do
      @client.delete_job(123)
    end
  end

  def test_publish_job
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs/123/publish", expected_auth: "Bearer test_key") do
      @client.publish_job(123)
    end
  end

  def test_unpublish_job
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs/123/unpublish", expected_auth: "Bearer test_key") do
      @client.unpublish_job(123)
    end
  end

  def test_restore_job
    stub_http_request(expected_method: :patch, expected_path: "/v1/jobs/123/restore", expected_auth: "Bearer test_key") do
      @client.restore_job(123)
    end
  end

  def test_job_counts
    stub_http_request(expected_method: :get, expected_path: "/v1/jobs/counts", expected_auth: "Bearer test_key") do
      @client.job_counts
    end
  end

  def test_bulk_draft_jobs
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs/bulk_draft", expected_body: '{"job_ids":"1,2,3"}', expected_auth: "Bearer test_key") do
      @client.bulk_draft_jobs([1, 2, 3])
    end
  end

  def test_bulk_publish_jobs
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs/bulk_publish", expected_body: '{"job_ids":"1,2"}', expected_auth: "Bearer test_key") do
      @client.bulk_publish_jobs([1, 2])
    end
  end

  def test_bulk_expire_jobs
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs/bulk_expire", expected_body: '{"job_ids":"1"}', expected_auth: "Bearer test_key") do
      @client.bulk_expire_jobs(1)
    end
  end

  def test_bulk_destroy_jobs
    stub_http_request(expected_method: :post, expected_path: "/v1/jobs/bulk_destroy", expected_body: '{"job_ids":"1,2"}', expected_auth: "Bearer test_key") do
      @client.bulk_destroy_jobs([1, 2])
    end
  end

  def test_membership_subscriptions
    stub_http_request(expected_method: :get, expected_path: "/v1/membership_subscriptions", expected_query: "page=1", expected_auth: "Bearer test_key") do
      @client.membership_subscriptions(page: 1)
    end
  end

  def test_grant_membership_subscription
    stub_http_request(expected_method: :post, expected_path: "/v1/membership_subscriptions", expected_body: '{"email":"a@b.com"}', expected_auth: "Bearer test_key") do
      @client.grant_membership_subscription(email: "a@b.com")
    end
  end

  def test_membership_subscription
    stub_http_request(expected_method: :get, expected_path: "/v1/membership_subscriptions/ref-1", expected_auth: "Bearer test_key") do
      @client.membership_subscription("ref-1")
    end
  end

  def test_revoke_membership_subscription
    stub_http_request(expected_method: :delete, expected_path: "/v1/membership_subscriptions/ref-1", expected_auth: "Bearer test_key") do
      @client.revoke_membership_subscription("ref-1")
    end
  end

  def test_membership_purchases
    stub_http_request(expected_method: :get, expected_path: "/v1/membership_purchases", expected_auth: "Bearer test_key") do
      @client.membership_purchases
    end
  end

  def test_grant_membership_purchase
    stub_http_request(expected_method: :post, expected_path: "/v1/membership_purchases", expected_body: '{"email":"a@b.com"}', expected_auth: "Bearer test_key") do
      @client.grant_membership_purchase(email: "a@b.com")
    end
  end

  def test_membership_purchase
    stub_http_request(expected_method: :get, expected_path: "/v1/membership_purchases/ref-1", expected_auth: "Bearer test_key") do
      @client.membership_purchase("ref-1")
    end
  end

  def test_revoke_membership_purchase
    stub_http_request(expected_method: :delete, expected_path: "/v1/membership_purchases/ref-1", expected_auth: "Bearer test_key") do
      @client.revoke_membership_purchase("ref-1")
    end
  end

  def test_blog_posts
    stub_http_request(expected_method: :get, expected_path: "/v1/blog_posts", expected_query: "state=published", expected_auth: "Bearer test_key") do
      @client.blog_posts(state: "published")
    end
  end

  def test_create_blog_post
    stub_http_request(expected_method: :post, expected_path: "/v1/blog_posts", expected_body: '{"title":"Hello"}', expected_auth: "Bearer test_key") do
      @client.create_blog_post(title: "Hello")
    end
  end

  def test_blog_post
    stub_http_request(expected_method: :get, expected_path: "/v1/blog_posts/1", expected_auth: "Bearer test_key") do
      @client.blog_post(1)
    end
  end

  def test_update_blog_post
    stub_http_request(expected_method: :patch, expected_path: "/v1/blog_posts/1", expected_body: '{"title":"Hello"}', expected_auth: "Bearer test_key") do
      @client.update_blog_post(1, title: "Hello")
    end
  end

  def test_delete_blog_post
    stub_http_request(expected_method: :delete, expected_path: "/v1/blog_posts/1", expected_auth: "Bearer test_key") do
      @client.delete_blog_post(1)
    end
  end

  def test_publish_blog_post
    stub_http_request(expected_method: :post, expected_path: "/v1/blog_posts/1/publish", expected_auth: "Bearer test_key") do
      @client.publish_blog_post(1)
    end
  end

  def test_unpublish_blog_post
    stub_http_request(expected_method: :post, expected_path: "/v1/blog_posts/1/unpublish", expected_auth: "Bearer test_key") do
      @client.unpublish_blog_post(1)
    end
  end

  def test_job_payments
    stub_http_request(expected_method: :get, expected_path: "/v1/job_payments", expected_auth: "Bearer test_key") do
      @client.job_payments
    end
  end

  def test_grant_job_payment
    stub_http_request(expected_method: :post, expected_path: "/v1/job_payments", expected_body: '{"job_id":1}', expected_auth: "Bearer test_key") do
      @client.grant_job_payment(job_id: 1)
    end
  end

  def test_job_payment
    stub_http_request(expected_method: :get, expected_path: "/v1/job_payments/ref-1", expected_auth: "Bearer test_key") do
      @client.job_payment("ref-1")
    end
  end

  def test_revoke_job_payment
    stub_http_request(expected_method: :delete, expected_path: "/v1/job_payments/ref-1", expected_query: "unpublish=true", expected_auth: "Bearer test_key") do
      @client.revoke_job_payment("ref-1")
    end
  end

  def test_revoke_job_payment_with_unpublish_false
    stub_http_request(expected_method: :delete, expected_path: "/v1/job_payments/ref-1", expected_query: "unpublish=false", expected_auth: "Bearer test_key") do
      @client.revoke_job_payment("ref-1", unpublish: false)
    end
  end

  def test_prices
    stub_http_request(expected_method: :get, expected_path: "/v1/prices", expected_auth: "Bearer test_key") do
      @client.prices
    end
  end

  def test_price
    stub_http_request(expected_method: :get, expected_path: "/v1/prices/1", expected_auth: "Bearer test_key") do
      @client.price(1)
    end
  end

  def test_employer_products
    stub_http_request(expected_method: :get, expected_path: "/v1/employer_products", expected_auth: "Bearer test_key") do
      @client.employer_products
    end
  end

  def test_employer_product
    stub_http_request(expected_method: :get, expected_path: "/v1/employer_products/1", expected_auth: "Bearer test_key") do
      @client.employer_product(1)
    end
  end

  def test_employer_entitlements
    stub_http_request(expected_method: :get, expected_path: "/v1/employer_entitlements", expected_auth: "Bearer test_key") do
      @client.employer_entitlements
    end
  end

  def test_grant_employer_entitlement
    stub_http_request(expected_method: :post, expected_path: "/v1/employer_entitlements", expected_body: '{"email":"a@b.com"}', expected_auth: "Bearer test_key") do
      @client.grant_employer_entitlement(email: "a@b.com")
    end
  end

  def test_employer_entitlement
    stub_http_request(expected_method: :get, expected_path: "/v1/employer_entitlements/ref-1", expected_auth: "Bearer test_key") do
      @client.employer_entitlement("ref-1")
    end
  end

  def test_cancel_employer_entitlement
    stub_http_request(expected_method: :delete, expected_path: "/v1/employer_entitlements/ref-1", expected_auth: "Bearer test_key") do
      @client.cancel_employer_entitlement("ref-1")
    end
  end

  def test_candidate_entitlements
    stub_http_request(expected_method: :get, expected_path: "/v1/candidate_entitlements", expected_auth: "Bearer test_key") do
      @client.candidate_entitlements
    end
  end

  def test_grant_candidate_entitlement
    stub_http_request(expected_method: :post, expected_path: "/v1/candidate_entitlements", expected_body: '{"email":"a@b.com"}', expected_auth: "Bearer test_key") do
      @client.grant_candidate_entitlement(email: "a@b.com")
    end
  end

  def test_candidate_entitlement
    stub_http_request(expected_method: :get, expected_path: "/v1/candidate_entitlements/ref-1", expected_auth: "Bearer test_key") do
      @client.candidate_entitlement("ref-1")
    end
  end

  def test_cancel_candidate_entitlement
    stub_http_request(expected_method: :delete, expected_path: "/v1/candidate_entitlements/ref-1", expected_auth: "Bearer test_key") do
      @client.cancel_candidate_entitlement("ref-1")
    end
  end
end
