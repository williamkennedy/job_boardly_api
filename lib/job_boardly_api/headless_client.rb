# frozen_string_literal: true

module JobBoardlyApi
  class HeadlessClient < BaseClient
    DEFAULT_BASE_URL = "https://api.jobboardly.com/headless/v1"

    def initialize(board_host: nil, board_id: nil)
      if board_host
        url = "https://#{board_host}/headless/v1"
      elsif board_id
        url = "#{DEFAULT_BASE_URL}/boards/#{board_id}"
      else
        raise ArgumentError, "Either board_host or board_id is required"
      end
      super(base_url: url)
    end

    def bootstrap
      get("/bootstrap")
    end

    def create_subscriber(body)
      post("/subscribers", {}, body)
    end

    def jobs(params = {})
      get("/jobs", params)
    end

    def job(id)
      get("/jobs/#{id}")
    end

    def categories
      get("/categories")
    end

    def arrangements
      get("/arrangements")
    end

    def places(params = {})
      get("/places", params)
    end

    def blog_posts(params = {})
      get("/blog_posts", params)
    end

    def blog_post(slug)
      get("/blog_posts/#{slug}")
    end

    def page(path)
      get("/pages/#{path}")
    end

    def employer_products
      get("/employer_products")
    end

    def candidate_products
      get("/candidate_products")
    end

    def membership_plans
      get("/membership_plans")
    end
  end
end
