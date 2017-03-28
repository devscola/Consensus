def retrieve_port
  begin
    capybara_default_port =  eval File.open('.env').read
  rescue
    capybara_default_port = '4567'
  end
  return capybara_default_port
end
