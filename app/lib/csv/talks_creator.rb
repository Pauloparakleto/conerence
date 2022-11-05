require 'active_support/core_ext/numeric/bytes.rb'
require 'csv'

module Csv
  class TalksCreator
    attr_accessor :csv_file
    BASE_INITIAL_TIME = '09:00'
    LUNCHING_TIME = 12

    def initialize(csv_file)
      @csv_file = csv_file
    end

    def call
      talks = []
      time_duration = 0

      CSV.read(csv_file).each do |csv|

        #TODO: check cases when there is commas in name, must be created with commas
        name = csv.join.split(/\w+\z/).first.strip!

        initial_time = talks.length.zero? ? BASE_INITIAL_TIME : talks.last.initial_time + time_duration.minutes
        # FIXME: is there another way to avoid calling joint twice?
        time_duration = csv.join.scan(/\w+$/).join.split(/min/).first.to_i

        # Avoiding lunching time and set it one hour later may be up to Talk model level. Opened discussion.

        initial_time += 1.hour if talks.length > 0 && initial_time.hour.eql?(LUNCHING_TIME)

        # TODO: must warant uniqueness of name since it will find the first

        track = Track.find_or_create_by(name: 'Track A')

        talks << Talk.create(name: name, initial_time: initial_time, track_id: track.id)
      end

      talks
    end
  end
end