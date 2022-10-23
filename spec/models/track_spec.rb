require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'attributes validations' do
    it do
        should allow_values('Track A', 'Track B', 'A', 'B', 'C', 'my good track').
          for(:name)
    end

    it do
      should_not allow_values('Track 1', '2', 3, '2a', '1Track', '2 Track').
        for(:name)
    end

    it { should validate_presence_of(:name) }
  end

  context 'when create' do
    let(:track) { FactoryBot.create :track }

    it 'has name' do
      expect(track.name).to eq('Track Sample')
    end
  end

  context 'when update' do
    let(:track) { FactoryBot.create :track }
    let(:track_name) { track.name }

    before do
      track.update(name: 'AnotherString')
    end

    it 'updates name' do
      expect(track.reload.name).not_to eq('MyString')
    end
  end

  context 'when destroy' do
    let!(:tracks) { FactoryBot.create_list :track, 3 }

    it 'counts by -1' do
      expect do
        tracks.last.destroy
      end.to change(Track, :count).by(-1)
    end
  end
end
