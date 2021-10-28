# frozen_string_literal: true

require 'rails_helper'

describe Movies::Popular::Import, :vcr do
  describe '#call' do
    subject { described_class.call }

    context 'when the response is success' do
      it 'imports the movies into database' do
        expect { subject }.to change { Movie.count }.by(20)
      end
    end
  end
end
