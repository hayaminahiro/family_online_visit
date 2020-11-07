# frozen_string_literal: true

require 'test_helper'

class RelativeDecoratorTest < ActiveSupport::TestCase
  def setup
    @relative = Relative.new.extend RelativeDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
