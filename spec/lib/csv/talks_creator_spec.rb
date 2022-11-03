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

    it 'is creates first talk' do
      valid_talks_creator_initialize.call

      expect(Talk.first).to be_truthy
    end

    it 'has talk initial_time.hour equal to 9' do
      valid_talks_creator_initialize.call

      expect(Talk.first.initial_time.hour).to eq(9)
    end

    it 'has first Talk pretty_initial_time equal to 09:00' do
      valid_talks_creator_initialize.call

      expect(Talk.first.pretty_initial_time).to eq('09:00')
    end
  end
end
