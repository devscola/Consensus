module Page
  class DiscussionBoard
    include Capybara::DSL

    def initialize
      validate!
    end

    def proposal_title
      find('#title').text
    end

    def users_listed?
      has_css?('.user-involved')
    end

    def validate!
      page.assert_selector('#title', visible: false)
      page.assert_selector('#content', visible: false)
      page.assert_selector('#circle', visible: false)
    end
  end
end
