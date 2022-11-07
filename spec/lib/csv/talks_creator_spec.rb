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

    context 'when flag as lightning' do
      let!(:row1) { 'Rails para usuários de Django lightning' }
      let!(:row2) { 'Erros comuns em Ruby lightning' }
      let!(:rows) { [row1, row2] }

      let(:file_path) { 'tmp/lightnings_talks.csv' }

      let!(:csv) do
        CSV.open(file_path, 'w') do |csv|
          rows.each do |row|
            csv << [row]
          end
        end
      end

      before { described_class.new(file_path).call }

      after(:each) { File.delete(file_path) }

      it 'set second initial_time to 09:05' do
        expect(Talk.first.pretty_initial_time).to eq('09:00')
      end

      it 'set second initial_time to 09:05' do
        expect(Talk.second.pretty_initial_time).to eq('09:05')
      end
    end

    context 'when count Tracks' do
      it 'counts Track by 2' do
        expect{ valid_talks_creator_initialize.call }.to change(Track, :count).by(2)
      end
    end

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

      it 'has seventh Talk pretty_initial_time equal to 13:50' do
        expect(Track.first.talks[6].pretty_initial_time).to eq('13:50')
      end
      
      it 'has eighth Talk pretty_initial_time equal to 14:50' do
        expect(Track.first.talks[7].pretty_initial_time).to eq('14:50')
      end

      it 'has nineth Talk pretty_initial_time equal to 15:35' do
        expect(Track.first.talks[8].pretty_initial_time).to eq('15:35')
      end
      
      it 'has nineth Talk pretty_initial_time equal to 16:05' do
        expect(Track.first.talks[9].pretty_initial_time).to eq('16:05')
      end 

      it 'has nineth Talk pretty_initial_time equal to 16:35' do
        expect(Track.first.talks[10].pretty_initial_time).to eq('16:35')
      end

      context 'when Track A is full' do
        it 'creates second track' do
          expect(Track.second).to be_truthy
        end

        it 'has second track name equal to Track B' do
          expect(Track.second.name).to eq('Track B')
        end

        it 'has second track first talk pretty_initial_time equal to base initial time' do
          expect(Track.second.talks.first.pretty_initial_time).to eq('09:00')
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
