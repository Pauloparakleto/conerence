require 'active_support/core_ext/numeric/bytes.rb'
require 'csv'

module Csv
  class TalksCreator
    attr_accessor :csv_file
    BASE_INITIAL_TIME = '09:00'
    LUNCHING_TIME = 12
    NETWORK_INITIAL_TIME = 17
    TRACK_NAMES = ('A'..'D').to_a

    def initialize(csv_file)
      @csv_file = csv_file
      @track_name_index = 0
    end

    def track_name
      "Track #{TRACK_NAMES[@track_name_index]}"
    end

    def next_track_name
      @track_name_index +=1
    end

    def call
      talks = []
      time_duration = 0

      CSV.read(csv_file).each do |csv|

        #TODO: check cases when there is commas in name, must be created with commas
        name = csv.join.split(/\w+\z/).first.strip!

        initial_time = talks.length.zero? ? BASE_INITIAL_TIME : talks.last.initial_time + time_duration.minutes
        # FIXME: is there another way to avoid calling joint twice?
        
        time_duration = set_time_duration(csv)
        
        # Avoiding lunching time and set it one hour later may be up to Talk model level. Opened discussion.

        initial_time += 1.hour if talks.length > 0 && initial_time.hour.eql?(LUNCHING_TIME)

        # TODO: must warant uniqueness of name since it will find the first

        # TODO: use base initial time as integer if possible to allow refactor

        if talks.length > 0 && initial_time.hour >= NETWORK_INITIAL_TIME
          next_track_name
          initial_time = BASE_INITIAL_TIME
        end

        track = Track.find_or_create_by(name: track_name)

        # TODO: Build Talks in the Track collection and save once

        talks << Talk.create(name: name, initial_time: initial_time, track_id: track.id)
      end

      talks
    end

    private

    def set_time_duration(csv)
      time_duration = csv.join.scan(/\w+$/).join
      
      if time_duration.eql?('lightning')
        time_duration = 5
      else
        time_duration = time_duration.split(/min/).first.to_i
      end
    end
  end
end