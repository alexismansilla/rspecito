module Movies
  module Recommendations
    class Fetch 
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :movie_id, :integer

      def call
        return UNPROCESSABLE if movie_id.blank?

        results
      end

      def results
        @results ||= JSON.parse(@fetch_results ||= Faraday.get(url).body)
      rescue JSON::ParserError
        nil
      end

      private

      UNPROCESSABLE = 'The movie ID was not found'

      private_constant :UNPROCESSABLE

      def url
        "#{settings['dbdata_url']}/movie/#{movie_id}/recommendations?api_key=#{settings['dbdata_apikey']}&language=es-ES&page=1"
      end

      def settings
        Rails.configuration.settings
      end
    end
  end
end
