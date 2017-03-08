module Page

  class List
    include Capybara::DSL

    def initialize
      url = '/list'
      visit(url)
      validate!
    end

    def element_exists?(element)
      has_content?(element)
    end

    def add_element_to_list(element)
      fill_in('list-input', with: element)
      click_on('list-submit')
    end

    def validate!
      page.assert_selector('#list-input')
      page.assert_selector('#list-submit')
      page.assert_selector('#list-ul', visible: false)
    end

  end

end
