require 'spec_helper'
require_relative 'test_support/button'
require_relative '../app'

class TestButton < Page::Button
  def check_checkbox
    check('condition')
  end
  def uncheck_checkbox
    uncheck('condition')
  end
end

feature 'Button' do

  let(:button) do
    TestButton.new
  end

  scenario 'is deactivated when page loads' do

    result = button.is_button_activated?

    expect(result).to eq(false)
  end

  scenario 'activates on checkbox click' do

    button.check_checkbox
    result = button.is_button_activated?

    expect(result).to eq(true)
  end

  scenario 'toggles activation with checkbox interaction' do

    button.check_checkbox
    button.uncheck_checkbox
    result = button.is_button_activated?

    expect(result).to eq(false)
  end

end
