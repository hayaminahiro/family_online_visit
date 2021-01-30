# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalendarSettingDecorator do
  let(:calendar_setting) { CalendarSetting.new.extend CalendarSettingDecorator }
  subject { calendar_setting }
  it { should be_a CalendarSetting }
end
