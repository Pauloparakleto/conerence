require 'active_support/core_ext/numeric/bytes.rb'
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
        if talks.length.zero?
         initial_time = '09:00'
        else
          initial_time = talks.first.initial_time + 60.minutes
        end
        talks << Talk.create(name: name, initial_time: initial_time)
      end

      talks
    end
  end
end