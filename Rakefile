task :default => :start

task :start do
  sh 'rerun app.rb'
end

task :test do
  sh 'rspec spec/unit'
end

task :test_all do
  sh 'rspec'
end
