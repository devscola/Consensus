def retrieve_mode
  begin
    consensus_environment = ENV.fetch('CONSENSUS_MODE')
  rescue
    consensus_environment = nil
  end
  return consensus_environment
end

def retrieve_port
  begin
    capybara_default_port =  eval File.open('.env').read
  rescue
    capybara_default_port = '4567'
  end
  return capybara_default_port
end
