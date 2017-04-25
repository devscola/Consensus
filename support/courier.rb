require 'open-uri'

module Support
  class Courier
    class << self
      def act
        collect_polymer_files
      end

      private

      def collect_polymer_files
        puts 'Support::Courier: starting to collect polymer files'

        polymer_main = open('https://polygit.org/components/polymer/polymer.html')
        polymer_mini = open('https://polygit.org/components/polymer/polymer-mini.html')
        polymer_micro = open('https://polygit.org/components/polymer/polymer-micro.html')
        webcomponents_js = open('https://cdnjs.cloudflare.com/ajax/libs/webcomponentsjs/0.7.24/webcomponents-lite.min.js')

        @engine_main = File.open('public/vendor/polymer/polymer.html', 'w')
        @engine_mini = File.open('public/vendor/polymer/polymer-mini.html', 'w')
        @engine_micro = File.open('public/vendor/polymer/polymer-micro.html', 'w')
        @engine_webcomponents = File.open('public/vendor/polymer/webcomponents-lite.min.js', 'w')

        @engine_main.puts(polymer_main.readlines)
        @engine_mini.puts(polymer_mini.readlines)
        @engine_micro.puts(polymer_micro.readlines)
        @engine_webcomponents.puts(webcomponents_js.readlines)

        @engine_main.close
        @engine_mini.close
        @engine_micro.close
        @engine_webcomponents.close

        puts 'Support::Courier: Polymer files collected'
      end
    end
  end
end
