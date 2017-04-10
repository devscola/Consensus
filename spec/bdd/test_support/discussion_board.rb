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

    def circle
      users = fill_circle
      users.sort
    end

    def user_in_circle?(username)
      fill_circle.include?(username)
    end

    private

    def fill_circle
      users = []
      all('.user-involved').each do |user|
        users << user.text
      end
      users
    end

    def validate!
      page.assert_selector('#title', visible: false)
      page.assert_selector('#content', visible: false)
      page.assert_selector('#circle', visible: false)
    end
  end
end
