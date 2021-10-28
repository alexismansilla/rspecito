# frozen_string_literal: true

module Movies
  module Popular
    class Import < ApplicationService
      ATTRS_TO_IMPORT = %w[original_title original_language popularity vote_average vote_count].freeze

      def call
        return if results.blank?

        save_results
      end

      private

      def save_results
        results.each do |result|
          attrs = result.slice(*ATTRS_TO_IMPORT)
          movie = Movie.find_or_initialize_by(code: result['id'])
          movie.assign_attributes(attrs)
          movie.save
        end
      end

      def results
        @results ||=
          JSON.parse(@fetch_results ||= Faraday.get(url).body)['results']
      rescue JSON::ParserError
        nil
      end

      def url
        "#{settings['dbdata_url']}/movie/popular?api_key=#{settings['dbdata_apikey']}&language=es-ES&page=1"
      end

      def settings
        Rails.configuration.settings
      end
    end
  end
end
