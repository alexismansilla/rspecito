# frozen_string_literal: true

require 'rails_helper'

describe Movies::Recommendations::Fetch do
  describe '#call' do
    subject { described_class.new(movie_id: movie_id).call }

    before do
      stub_request(:get, %r{api.themoviedb}).to_return(body: response, status: 404)
    end

    let(:response) do 
      File.read(Rails.root.join('spec', 'support', 'data', 'recommendations_movies.json'))
    end

    let(:movie_id) { 669671 }

    context 'when the response is not success' do
      let(:response) do 
        { 
          "success": false, 
          "status_code": 34, 
          "status_message": "The resource you requested could not be found." 
        }.to_json
      end

      let(:movie_id) { 98769 }

      it 'imports the movies into database' do
        expect(subject['success']).to eq false 
        expect(subject['status_message']).to eq JSON.parse(response)['status_message']
      end
    end


    context 'when the response is success' do
      it 'imports the movies into database' do
        expect(subject['results'].size).to eq 4
        expect(subject['results'].map{ |x| x['id'] }).to eq JSON.parse(response)['results'].map { |x| x['id'] }
      end
    end
  end
end
