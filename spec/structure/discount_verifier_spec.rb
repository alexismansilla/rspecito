require 'rails_helper'

describe DiscountVerifier do
  describe '#call' do
    subject { described_class.call(age: age) }

    context 'when the age is greater than 40' do
      let(:age) { 40 }

      it { is_expected.to eq 'Verified' }
    end

    context 'when the age is less than 40' do
      let(:age) { 35 }

      it { is_expected.to eq 'Not verified' }
    end
  end
end
