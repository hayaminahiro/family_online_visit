# frozen_string_literal: true

require 'test_helper'

class RequestResidentDecoratorTest < ActiveSupport::TestCase
  def setup
    @request_resident = RequestResident.new.extend RequestResidentDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
