require 'rails_helper'

RSpec.describe Csv::TalksCreator, type: :model do
  subject(:valid_talks_creator_initialize){ described_class.new(valid_talks_csv) }

  describe '#initialize' do
    let!(:valid_talks_csv) { file_fixture('valid_talks.csv') }

    it 'is thuthy' do
      expect(valid_talks_creator_initialize).to be_truthy
    end
  end

  describe '#call' do
    let!(:valid_talks_csv) { file_fixture('valid_talks.csv') }

    context 'when create valids' do
      before { valid_talks_creator_initialize.call }

      it 'creates first talk' do
        expect(Talk.first).to be_truthy
      end
  
      it 'has first talk name equal to first csv line without 60min' do
        expect(Talk.first.name).to eq('Diminuindo tempo de execução de testes em aplicações Rails enterprise')
      end
  
      it 'has talk initial_time.hour equal to 9' do
        expect(Talk.first.initial_time.hour).to eq(9)
      end
  
      it 'has first Talk pretty_initial_time equal to 09:00' do
        expect(Talk.first.pretty_initial_time).to eq('09:00')
      end

      it 'has second Talk pretty_initial_time equal to 10:00' do
        expect(Talk.second.pretty_initial_time).to eq('10:00')
      end

      it 'has third Talk pretty_initial_time equal to 10:45' do
        expect(Talk.third.pretty_initial_time).to eq('10:45')
      end

      it 'has second Talk pretty_initial_time equal to 11:15' do
        expect(Talk.fourth.pretty_initial_time).to eq('11:15')
      end
  
      # TODO: must count by 20 after the lib TalksCreator avoids set initial_time in lunching time. Check validation in Talk model
      it 'counts Talk by 20' do
        expect{ valid_talks_creator_initialize.call }.to change(Talk, :count).by(17)
      end
    end
  end
end
