require 'mongo'
require_relative '../../support/configuration'

module Questions
  class Repository
    class << self
      def store(question)
        collection.insert_one(question.serialize)
      end

      def retrieve(proposal_id)
        questions = collection.find({ proposal_id: proposal_id })
        questions.map do |question_data|
          Questions::Question.from_bson(question_data)
        end
      end

      private

      def connection
        @connection ||= Mongo::Client.new(
          ["#{host}:27017"],
          :database => 'consensus_db'
        )
      end

      def collection
        connection[:proposals]
      end

      def host
        Support::Configuration.host
      end
    end
  end
end
