module Page

  class DiscussionBoard
    include Capybara::DSL

    def initialize
      validate!
    end

    def proposal_title
      find('#title').text
    end


    def validate!
      page.assert_selector('#title', visible: false)
      page.assert_selector('#content', visible: false)
    end
  end

end
