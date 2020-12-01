# frozen_string_literal: true

require 'test_helper'

class InformationDecoratorTest < ActiveSupport::TestCase
  def setup
    @information = Information.new.extend InformationDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
