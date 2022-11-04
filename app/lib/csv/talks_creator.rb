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
      time_duration = 0

      CSV.read(csv_file).each do |csv|

        #TODO: check cases when there is commas in name, must be created with commas
        name = csv.join.split(/\w+\z/).first.strip!

        initial_time = talks.length.zero? ? '09:00' : talks.first.initial_time + time_duration.minutes 
        time_duration = csv.join.scan(/\w+$/).join.split(/min/).first.to_i

        talks << Talk.create(name: name, initial_time: initial_time)
      end

      talks
    end
  end
end