# frozen_string_literal: true

require 'test_helper'

class FacilityUserDecoratorTest < ActiveSupport::TestCase
  def setup
    @facility_user = FacilityUser.new.extend FacilityUserDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
