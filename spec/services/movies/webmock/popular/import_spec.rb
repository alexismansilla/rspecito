# frozen_string_literal: true

require 'rails_helper'

describe Movies::Popular::Import do
  describe '#call' do
    subject { described_class.call }

    context 'when the response is success' do
      let(:response) do
        File.read(Rails.root.join('spec', 'support', 'data', 'popular_movies.json'))
      end

      before do
        stub_request(:get, %r{api.themoviedb}).to_return(body: response, status: 200)
      end

      it 'imports the movies into database' do
        expect { subject }.to change { Movie.count }.by(2)
      end
    end

    context 'when the response is not success' do
      before do
        stub_request(:get, %r{api.themoviedb}).to_return(body: '', status: 500)
      end

      it 'returns nil' do
        expect(subject).to eq nil
      end

      it "doesn't update the database" do
        expect { subject }.to change { Movie.count }.by(0)
      end
    end
  end
end
