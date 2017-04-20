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

    def question_button?
      has_css?('#question')
    end

    def create_question
      find('#question').click
    end

    def question_content?
      has_css?('#questionContent')
    end

    def question_form?
      has_css?('#questionText')
    end

    def question_button_active?
      button = find('#question')
      result = button[:disabled]
      result.nil?
    end

    def fill_question(text)
      fill_in('question-text', with: text)
    end

    def submit_question_active?
      button = find('#question-submit', visible: false)
      result = button[:disabled]
      result.nil?
    end

    def question_button_visible?
      has_css?('#question')
    end

    def submit_question_form
      find('#question-submit').click
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
