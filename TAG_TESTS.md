## To tag tests and run it 

We must do this to be able to add a tag in the tests and be able to run them individually:


**1º.-** In the _Rakefile_ we add this code:

~~~
require 'rspec/core/rake_task'
~~~

And after that:

~~~
desc 'Run tagged tests'
 RSpec::Core::RakeTask.new do |test, args|
 test.pattern = Dir['spec/**/*_spec.rb']
 test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
~~~

The first line is the description of the code, inside the inverted commas we write the description.
In the second one, we call to the function with _rspec_ and say to it that we are going to use the arguments that hereinafter we will work across the _tag_. 
In the third one, we specify the tests path.
In the fourth one, we make a method to use the _tag_ tag. (we can use any word to tag)

**2º.-** In the test files  _test_name_spec.rb_ we add the tag. To make it possible, we have to write after the test name the tag that we want to use, with a comma and the _:tag_name_ as follows:

~~~
it 'test_name', :example do
   Arrange
   Add
   Assert
 end
~~~
 
In this case,  _example_ is the tag that we are using.


With this, we could run the tests this way:

~~~
rspec --tag example
~~~

**3º.-** To run the tag test with _rake_, we must add this code to the _"Rakefile"_:


~~~
task :tag, [:tag] do |t, arg|
 sh "rspec --tag #{arg.tag}"
end
~~~

This code adds one _task_ inside the _Rakefile_. The task makes possible that could be thrown with _rake_ when you add a tag in a test.
You can add the same tag in different tests.

Our  _Rakefile_ will be like this:

~~~
require 'rspec/core/rake_task'

task :tag, [:tag] do |t, arg|
  sh "rspec --tag #{arg.tag}"
end

desc 'Run labeled tests'
  RSpec::Core::RakeTask.new do |test, args|
  test.pattern = Dir['spec/**/*_spec.rb']
  test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
~~~

In this moment, we could run the tests this way:

~~~
rake tag[example]
~~~
