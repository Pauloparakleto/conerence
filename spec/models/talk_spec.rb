require 'rails_helper'

RSpec.describe Talk, type: :model do
  let(:current_time) { Time.now }

  context 'when create' do
    let(:talk) { FactoryBot.create :talk }

    it 'has name' do
      expect(talk.name).to eq('MyString')
    end

    it 'has initial_time true' do
      expect(talk.initial_time.hour).to eq(9)
    end
  end

  context 'when update' do
    let(:talk) { FactoryBot.create :talk }
    let(:talk_name) { talk.name }
    let(:talk_initial_time) { talk.initial_time }

    before do
      talk.update(name: 'AnotherString')
      talk.update(initial_time: '10:00')
    end

    it 'updates name' do
      expect(talk.reload.name).not_to eq('MyString')
    end

    it 'updates initial_time.hour' do
      expect(talk.reload.initial_time.hour).not_to eq(9)
    end
  end

  context 'when destroy' do
    let!(:talks) { FactoryBot.create_list :talk, 3 }

    it 'counts by -1' do
      expect do
        talks.last.destroy
      end.to change(Talk, :count).by(-1)
    end
  end
end
