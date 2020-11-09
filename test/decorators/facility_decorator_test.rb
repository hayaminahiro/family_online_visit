# frozen_string_literal: true

require 'test_helper'

class FacilityDecoratorTest < ActiveSupport::TestCase
  def setup
    @facility = Facility.new.extend FacilityDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
