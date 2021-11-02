# frozen_string_literal: true

require 'rails_helper'

describe Movies::Recommendations::Fetch do
  describe '#call' do
    subject { described_class.new(movie_id: movie_id).call }

    before do
      stub_request(:get, %r{api.themoviedb}).to_return(body: response, status: 404)
    end

    let!(:response) do 
      File.read(Rails.root.join('spec', 'support', 'data', 'recommendations_movies.json'))
    end

    context 'when the movie_id is not present' do
      let(:movie_id) { nil }

      it 'raises a not found' do
        expect { subject }.to eq(described_class.const_get(:UNPROCESSABLE))
      end
    end

    context 'when the response is not success' do
      let(:response) do 
        { 
          "success": false, 
          "status_code": 34, 
          "status_message": "The resource you requested could not be found." 
        }.to_json
      end

      let(:movie_id) { 98769 }

      it 'responds with sucess false' do
        expect(subject['success']).to eq false 
        expect(subject['status_message']).to eq JSON.parse(response)['status_message']
      end
    end

    context 'when the response is success' do
      let(:movie_id) { 669671 }

      it 'shows the resource size' do
        expect(subject['results'].size).to eq 4
      end

      it 'shows the resource size' do
        response_ids = subject['results'].map{ |x| x['id'] }
        expect(response_ids).to eq JSON.parse(response)['results'].map { |x| x['id'] }
      end
    end
  end
end
