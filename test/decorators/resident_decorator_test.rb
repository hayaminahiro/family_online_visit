# frozen_string_literal: true

require 'test_helper'

class ResidentDecoratorTest < ActiveSupport::TestCase
  def setup
    @resident = Resident.new.extend ResidentDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
