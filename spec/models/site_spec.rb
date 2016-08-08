require 'rails_helper'

RSpec.describe Site, type: :model do
  it { should validate_presence_of(:url) }

  context 'url' do
    context 'valid' do
      before { subject.url = 'http://www.google.com' }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      before { subject.url = 'www.google.com' }

      it { is_expected.to_not be_valid }

      it 'has errors' do
        subject.valid?
        expect(subject.errors[:url]).to eq ["is not a valid URL"]
      end
    end
  end
end
