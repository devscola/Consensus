task :default => :start

task :start do
  sh 'rerun app.rb'
end

task :test do
  sh 'rspec --color --format documentation'
end

task :unit_tests do
  sh 'bundle exec rspec spec/authorization_service_spec.rb --color --format documentation'
  sh 'bundle exec rspec spec/repository_spec.rb --color --format documentation'
end

