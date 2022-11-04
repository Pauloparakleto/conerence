require 'csv'

module Csv
  class TalksCreator
    attr_accessor :csv_file

    def initialize(csv_file)
      @csv_file = csv_file
    end

    def call
      talks = []

      CSV.read(csv_file).each do |csv|

        #TODO: check cases when there is commas in name, must be created with commas
        name = csv.join.split(/\w+\z/).first.strip!
        ititial_time = '09:00' if talks.length.zero?
        talks << Talk.create(name: name, initial_time: ititial_time)
      end

      talks
    end
  end
end