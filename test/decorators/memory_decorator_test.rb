# frozen_string_literal: true

require 'test_helper'

class MemoryDecoratorTest < ActiveSupport::TestCase
  def setup
    @memory = Memory.new.extend MemoryDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
