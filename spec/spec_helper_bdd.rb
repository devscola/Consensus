require 'sinatra'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'

if (ENV['CONSENSUS_MODE'])
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, {
      browser: :remote,
      url: "http://chrome-browser:4444/wd/hub",
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
    })
  end
  Capybara.default_driver = :chrome
  
  ip = %x(/sbin/ip route|awk '/default/ { print $3 }').strip
  Capybara.app_host = "http://#{ip}:4567"


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



  


