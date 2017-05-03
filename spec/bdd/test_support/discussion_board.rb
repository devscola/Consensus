module Page
  class DiscussionBoard
    include Capybara::DSL

    def initialize
      validate!
    end

    def proposal_title
      find('#title.proposal-panel').text
    end

    def users_listed?
      has_css?('.user-involved.proposal-panel')
    end

    def circle
      users = fill_circle
      users.sort
    end

    def user_in_circle?(username)
      fill_circle.include?(username)
    end

    def question_button?
      has_css?('#question.question-button')
    end

    def create_question
      find('#question.question-button').click
    end

    def question_content?
      has_css?('#questionContent.question-form')
    end

    def question_form?
      has_css?('#questionText.question-form')
    end

    def question_button_active?
      button = find('#question.question-button')
      result = button[:disabled]
      result.nil?
    end

    def fill_question(text)
      fill_in('questionText', with: text)
    end

    def submit_question_active?
      button = find('#question-submit.question-form', visible: false)
      result = button[:disabled]
      result.nil?
    end

    def question_button_visible?
      has_css?('#question.question-button')
    end

    def submit_question_form
      find('#question-submit.question-form').click
    end

    private

    def fill_circle
      users = []
      all('.user-involved.proposal-panel').each do |user|
        users << user.text
      end
      users
    end

    def validate!
      page.assert_selector('#title.proposal-panel', visible: false)
      page.assert_selector('#content.proposal-panel', visible: false)
      page.assert_selector('#circle.proposal-panel', visible: false)
    end
  end
end
