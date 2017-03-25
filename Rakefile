def retrieve_port
  begin
    capybara_default_port =  eval File.open('.env').read
  rescue
    capybara_default_port = '4567'
  end
  return capybara_default_port
end

SINATRA_PORT = retrieve_port

task :default => :start

task :start do
  sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0"
end

task :tdd do
  sh 'rspec spec/tdd'
end

task :bdd do
  sh 'rspec spec/bdd'
end

task :test => [:tdd, :bdd] do
end
