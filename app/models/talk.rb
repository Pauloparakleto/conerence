class Talk < ApplicationRecord
  LUNCHING_TIME_HOUR = 12

  belongs_to :track, optional: :true

  validate :initial_time_can_not_be_in_lunching_time_hour
  validates_format_of :name, with: /\A([[:punct:][a-zA-Z\u00C0-\u00FF\s]]{1,})\z/

  def is_lunching_time?
    initial_time.hour == LUNCHING_TIME_HOUR
  end


  def pretty_initial_time
    initial_time&.strftime('%H:%M')
  end

  private

  def initial_time_can_not_be_in_lunching_time_hour
    return if initial_time.blank?

    errors.add(:initial_time, 'Can not book at lunching time hour') if is_lunching_time?
  end
end
