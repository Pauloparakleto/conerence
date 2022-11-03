require 'csv'

module Csv
  class TalksCreator
    attr_accessor :csv_file

    def initialize(csv_file)
      @csv_file = csv_file
    end

    def call
      CSV.read(csv_file).each do |csv|
        Talk.create(name: csv.first, initial_time: '09:00')
      end
    end
  end
end