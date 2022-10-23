require 'rails_helper'

RSpec.describe Talk, type: :model do
  describe 'attributes validations' do
    it do
        should_not allow_values('2 Another conference1', '333', 'w222', 'w 23', 'My conference 123', '2a').
          for(:name)
    end

    it do
      should allow_values('My conference', 'this is my conference').
        for(:name)
    end

    it do
      should_not allow_values('12', '12:00', '12:01', '12:59').
        for(:initial_time)
    end
  end
  
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
