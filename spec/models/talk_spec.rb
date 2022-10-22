require 'rails_helper'

RSpec.describe Talk, type: :model do
  let(:current_time) { Time.now }

  describe 'create' do
    context 'when it is valid' do
      let(:talk) { FactoryBot.create :talk }

      it 'has name' do
        expect(talk.name).to eq('MyString')
      end

      it 'has initial_time true' do
        expect(talk.initial_time.hour).to eq(9)
      end
    end
  end
end
