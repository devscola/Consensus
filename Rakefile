task :default => :start

task :start do
  sh 'rerun --background -- rackup --port 4567 -o 0.0.0.0'
end

task :tdd do
  sh 'rspec spec/unit'
end

task :bdd do
  sh 'rspec'
end

task :test => [:tdd, :bdd] do
end
