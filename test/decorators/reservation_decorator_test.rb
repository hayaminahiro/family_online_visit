# frozen_string_literal: true

require 'test_helper'

class ReservationDecoratorTest < ActiveSupport::TestCase
  def setup
    @reservation = Reservation.new.extend ReservationDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
