class Talk < ApplicationRecord
  LUNCHING_TIME_HOUR = 12

  validate :initial_time_can_not_be_in_lunching_time_hour
  validates_format_of :name, with: /\A[a-z][a-z\-]*\z/i

  def is_lunching_time?
    initial_time.hour == LUNCHING_TIME_HOUR
  end

  private

  def initial_time_can_not_be_in_lunching_time_hour
    return if initial_time.blank?

    errors.add(:initial_time, 'Can not book at lunching time hour') if is_lunching_time?
  end
end
