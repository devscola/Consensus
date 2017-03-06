require 'spec_helper'
require_relative 'test_support/list'
require_relative '../app'

feature 'List' do 

  scenario 'allows to add elements' do
    list = Page::List.new
    element = 'Some text to add'

    alpha_result = list.element_exists?(element)
    list.add_element_to_list(element)
    betta_result = list.element_exists?(element)

    expect(alpha_result).to be false
    expect(betta_result).to be true
  end

end