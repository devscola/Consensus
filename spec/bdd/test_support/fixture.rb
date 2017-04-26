require_relative 'login'
require_relative 'proposals'
require_relative 'discussion_board'
class Fixture
  
  extend Capybara::DSL

  PROPOSAL_NAME='some title'
  NOT_PROPOSER='Cersei'
  MEASURED_TEXT='0123456789'
  MEASURED_TEXT_LENGTH = 10

  def self.pristine
    Fixture.empty
    self
  end

  def self.empty
    visit('/proposals/empty')
    Page::Proposals.new
  end
  
  def self.proposal_added
    current=Fixture.login
    current.new_proposal(PROPOSAL_NAME)
    current
  end

  def self.at_proposals
    Page::Proposals.new
  end

  def self.proposal_form_shown
    current=Fixture.login
    current.show_form
    current
  end

  def self.proposal_form_filled
    current=Fixture.proposal_form_shown
    current.fill_enough_content
    current
  end

  def self.a_user_involved
    current=Fixture.proposal_added
    current.click_user_button(NOT_PROPOSER)
    current
  end

  def self.login
    username = 'KingRobert'
    password = 'Stag'
    login = Page::Login.new
    login.sign_in(username, password)
    Page::Proposals.new
  end
end