# frozen_string_literal: true

require "test_helper"

class TestJobBoardlyApi < JobBoardlyApi::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::JobBoardlyApi::VERSION
  end
end
