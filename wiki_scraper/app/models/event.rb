class Event < ActiveRecord::Base
  scope :on_date, ->(date) {where(event_date: date)}
end
