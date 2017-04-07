require_relative 'environment_configuration'
require 'rspec/core/rake_task'

SINATRA_PORT = retrieve_port

def retrieve_travis
  begin
    travis_environment = ENV.fetch('TRAVIS')
  rescue
    travis_environment = nil
  end
  return travis_environment
end

TRAVIS_CI = retrieve_travis

task :default => :start

task :start do
	puts "*******"
	puts SINATRA_PORT
	puts TRAVIS_CI
	puts "*******"
  if ( TRAVIS_CI == 'true' )
    sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0 &"
    sh 'rspec spec/tdd'
    sh 'rspec spec/bdd'
  else
    sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0"
  end
end

task :tdd do
  sh 'rspec spec/tdd'
end

task :bdd do
  sh 'rspec spec/bdd'
end

task :test => [:tdd, :bdd] do
end

task :tag, [:tag] do |t, arg|
  sh "rspec --tag #{arg.tag}"
end

desc 'Run labeled tests'
  RSpec::Core::RakeTask.new do |test, args|
  test.pattern = Dir['spec/**/*_spec.rb']
  test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
