# frozen_string_literal: true

require_relative "job_boardly_api/version"
require_relative "job_boardly_api/response"
require_relative "job_boardly_api/base_client"
require_relative "job_boardly_api/client"
require_relative "job_boardly_api/headless_client"

module JobBoardlyApi
  class Error < StandardError; end
end
