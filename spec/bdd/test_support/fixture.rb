require_relative 'login'
require_relative 'proposals'
require_relative 'discussion_board'
class Fixture
  extend Capybara::DSL

  PROPOSAL_NAME = 'some title'
  NOT_PROPOSER = 'Cersei'
  MEASURED_TEXT = '0123456789'
  MEASURED_TEXT_LENGTH = 10
  BAD_USERNAME = 'BadUsername'
  BAD_PASSWORD = 'BadPassword'
  VALID_USERNAME = 'KingRobert'
  VALID_PASSWORD = 'Stag'
  PROPOSER = 'KingRobert'
  INVOLVED = 'Cersei'
  INVOLVED_PASSWORD = 'Lion'

  def self.pristine
    Fixture.empty
    self
  end

  def self.user_logged
    current = Page::Login.new
    current.sign_in(VALID_USERNAME, VALID_PASSWORD)
    Page::Proposals.new
  end

  def self.involved_logged
    current = Page::Login.new
    current.sign_in(INVOLVED, INVOLVED_PASSWORD)
    Page::Proposals.new
  end

  def self.not_involved_logged
    current = Page::Login.new
    current.sign_in('Varys', 'Bird')
    Page::Proposals.new
  end

  def self.password_shown
    current = Page::Login.new
    current.toggle_password_visibility
    current
  end

  def self.wrong_credentials_attempt
    current = Page::Login.new
    current.sign_in(BAD_USERNAME,BAD_PASSWORD)
    current
  end

  def self.empty
    visit('/proposals/empty')
    Page::Proposals.new
  end

  def self.proposal_added
    current = Fixture.login
    current.new_proposal(PROPOSAL_NAME)
    current
  end

  def self.involved_questioning
    Fixture.a_user_involved
    current = Fixture.involved_logged
    board = current.visit_proposal(Fixture::PROPOSAL_NAME)
    board.create_question
    board
  end

  def self.involved_asked
    current = Fixture.involved_questioning
    current.fill_question(Fixture.enough_text)
    current.submit_question_form
    current
  end

  def self.enough_text
    enough_length_text = ''
    101.times { enough_length_text << 'a' }
    enough_length_text
  end

  def self.at_proposals
    Page::Proposals.new
  end

  def self.proposal_form_shown
    current = Fixture.login
    current.show_form
    current
  end

  def self.proposal_form_filled
    current = Fixture.proposal_form_shown
    current.fill_enough_content
    current
  end

  def self.a_user_involved
    current = Fixture.proposal_added
    current.click_user_button(NOT_PROPOSER)
    current
  end

  def self.login
    Fixture.user_logged
    Page::Proposals.new
  end
end
