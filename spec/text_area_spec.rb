require 'spec_helper'
require_relative 'test_support/text_area'
require_relative '../app'

feature 'Text area' do
  scenario 'counter shows text area length' do
    text_area = Page::TextArea.new
    text = 'some text'

    text_area.fill_text_area(text)
    result = text_area.get_counter_value

    expect(result).to eq(text.length.to_s)
  end
end
