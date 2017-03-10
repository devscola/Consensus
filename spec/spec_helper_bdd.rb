require 'sinatra'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'


begin
  consensus_environment = ENV.fetch('CONSENSUS_MODE')
rescue
  consensus_environment = nil
end

if (consensus_environment == 'development')
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, {
      browser: :remote,
      url: "http://chrome-browser:4444/wd/hub",
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
    })
  end
  Capybara.default_driver = :chrome
  
  ip = %x(/sbin/ip route|awk '/default/ { print $3 }').strip
  port = '4567'
  Capybara.app_host = "http://#{ip}:#{port}"


else

  Sinatra::Application.environment = :test

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.default_driver = :chrome

  Capybara.app_host = "http://localhost:4567"
  Capybara.server_host = "localhost"
  Capybara.server_port = "4567"
end
