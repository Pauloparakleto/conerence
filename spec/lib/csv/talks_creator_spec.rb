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

      it 'has fourth Talk pretty_initial_time equal to 11:15' do
        expect(Talk.fourth.pretty_initial_time).to eq('11:15')
      end

      context 'and initial_time is in lunching time' do
        it 'has fifth Talk pretty_initial_time equal to 13:00' do
          expect(Talk.fifth.pretty_initial_time).to eq('13:00')
        end
  
        it 'has sixth Talk pretty_initial_time equal to 13:45' do
          expect(Track.first.talks[5].pretty_initial_time).to eq('13:45')
        end  
      end

      it 'counts Talk by 20' do
        expect{ valid_talks_creator_initialize.call }.to change(Talk, :count).by(20)
      end

      it 'creates Track A associated with first Talk' do
        expect(Talk.first.track).to be_truthy
      end

      it 'creates Track A associated with first Talk whose name is A' do
        expect(Talk.first.track.name).to eq('Track A')
      end
    end
  end
end
