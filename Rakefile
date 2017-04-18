require_relative 'environment_configuration'
require 'rspec/core/rake_task'

SINATRA_PORT = retrieve_port

TRAVIS = retrieve_travis

task :default => :start

task :start do
  if (TRAVIS == false)
    sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0"
  end
  if (TRAVIS == true)
    File.delete('travis.ci')
    sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0 &"
    sh 'rspec spec/tdd'
    sh 'rspec spec/bdd'
  end
end

task :tdd do
  sh 'rspec spec/tdd'
end

task :bdd do
  sh 'rspec spec/bdd'
end

task :integration do
  sh 'rspec spec/integration'
end

task :test => [:tdd, :bdd, :integration] do
end

task :tag, [:tag] do |t, arg|
  sh "rspec --tag #{arg.tag}"
end

desc 'Run labeled tests'
  RSpec::Core::RakeTask.new do |test, args|
  test.pattern = Dir['spec/**/*_spec.rb']
  test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
