module Page
  class DiscussionBoard
    ENOUGH_TEXT = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean m'
    NOT_ENOUGH_TEXT = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aene'

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
      button = find('#question.question-button', wait: 4)
      result = button[:disabled]
      result.nil?
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

    def fill_enough_text
      script = <<~SCRIPT
        content = document.getElementById('questionText');
        content.value = '#{ENOUGH_TEXT}';
        form = document.getElementById('question-content');
        form.updateCounter();
      SCRIPT
      execute_script(script)
    end

    def fill_not_enough_text
      script = <<~SCRIPT
        content = document.getElementById('questionText');
        content.value = '#{NOT_ENOUGH_TEXT}';
        form = document.getElementById('question-content');
        form.updateCounter();
      SCRIPT
      execute_script(script)
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
