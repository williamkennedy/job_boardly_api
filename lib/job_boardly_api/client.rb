# frozen_string_literal: true

module JobBoardlyApi
  class Client < BaseClient
    DEFAULT_BASE_URL = "https://api.jobboardly.com/v1"

    def initialize(api_key:, base_url: nil, board_host: nil)
      url = base_url || (board_host ? "https://api.#{board_host}/v1" : DEFAULT_BASE_URL)
      super(base_url: url)
      @api_key = api_key
    end

    # Board & Metadata

    def me
      get("/me")
    end

    def categories
      get("/categories")
    end

    def category(id)
      get("/categories/#{id}")
    end

    def arrangements
      get("/arrangements")
    end

    # Jobs

    def jobs(params = {})
      get("/jobs", params)
    end

    def create_job(body)
      post("/jobs", {}, body)
    end

    def job(id)
      get("/jobs/#{id}")
    end

    def update_job(id, body)
      patch("/jobs/#{id}", {}, body)
    end

    def delete_job(id)
      delete("/jobs/#{id}")
    end

    def publish_job(id)
      post("/jobs/#{id}/publish")
    end

    def unpublish_job(id)
      post("/jobs/#{id}/unpublish")
    end

    def restore_job(id)
      patch("/jobs/#{id}/restore")
    end

    def job_counts
      get("/jobs/counts")
    end

    def bulk_draft_jobs(job_ids)
      post("/jobs/bulk_draft", {}, { job_ids: Array(job_ids).join(",") })
    end

    def bulk_publish_jobs(job_ids)
      post("/jobs/bulk_publish", {}, { job_ids: Array(job_ids).join(",") })
    end

    def bulk_expire_jobs(job_ids)
      post("/jobs/bulk_expire", {}, { job_ids: Array(job_ids).join(",") })
    end

    def bulk_destroy_jobs(job_ids)
      post("/jobs/bulk_destroy", {}, { job_ids: Array(job_ids).join(",") })
    end

    # Membership Subscriptions

    def membership_subscriptions(params = {})
      get("/membership_subscriptions", params)
    end

    def grant_membership_subscription(body)
      post("/membership_subscriptions", {}, body)
    end

    def membership_subscription(external_ref)
      get("/membership_subscriptions/#{external_ref}")
    end

    def revoke_membership_subscription(external_ref)
      delete("/membership_subscriptions/#{external_ref}")
    end

    # Membership Purchases

    def membership_purchases(params = {})
      get("/membership_purchases", params)
    end

    def grant_membership_purchase(body)
      post("/membership_purchases", {}, body)
    end

    def membership_purchase(external_ref)
      get("/membership_purchases/#{external_ref}")
    end

    def revoke_membership_purchase(external_ref)
      delete("/membership_purchases/#{external_ref}")
    end

    # Blog Posts

    def blog_posts(params = {})
      get("/blog_posts", params)
    end

    def create_blog_post(body)
      post("/blog_posts", {}, body)
    end

    def blog_post(id)
      get("/blog_posts/#{id}")
    end

    def update_blog_post(id, body)
      patch("/blog_posts/#{id}", {}, body)
    end

    def delete_blog_post(id)
      delete("/blog_posts/#{id}")
    end

    def publish_blog_post(id)
      post("/blog_posts/#{id}/publish")
    end

    def unpublish_blog_post(id)
      post("/blog_posts/#{id}/unpublish")
    end

    # Job Payments

    def job_payments(params = {})
      get("/job_payments", params)
    end

    def grant_job_payment(body)
      post("/job_payments", {}, body)
    end

    def job_payment(external_ref)
      get("/job_payments/#{external_ref}")
    end

    def revoke_job_payment(external_ref, unpublish: true)
      delete("/job_payments/#{external_ref}", { unpublish: unpublish })
    end

    # Prices

    def prices(params = {})
      get("/prices", params)
    end

    def price(id)
      get("/prices/#{id}")
    end

    # Employer Products

    def employer_products(params = {})
      get("/employer_products", params)
    end

    def employer_product(id)
      get("/employer_products/#{id}")
    end

    # Employer Entitlements

    def employer_entitlements(params = {})
      get("/employer_entitlements", params)
    end

    def grant_employer_entitlement(body)
      post("/employer_entitlements", {}, body)
    end

    def employer_entitlement(external_ref)
      get("/employer_entitlements/#{external_ref}")
    end

    def cancel_employer_entitlement(external_ref)
      delete("/employer_entitlements/#{external_ref}")
    end

    # Candidate Entitlements

    def candidate_entitlements(params = {})
      get("/candidate_entitlements", params)
    end

    def grant_candidate_entitlement(body)
      post("/candidate_entitlements", {}, body)
    end

    def candidate_entitlement(external_ref)
      get("/candidate_entitlements/#{external_ref}")
    end

    def cancel_candidate_entitlement(external_ref)
      delete("/candidate_entitlements/#{external_ref}")
    end

    private

    def configure_request(request)
      request["Authorization"] = "Bearer #{@api_key}"
    end
  end
end
