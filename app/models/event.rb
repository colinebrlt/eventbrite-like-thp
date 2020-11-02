class Event < ApplicationRecord
  validates :start_date, presence: true, if: :future_date
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 1 }, if: :multiple_of_five?
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, only_integer: true }
  validates :location, presence: true

  has_many :users, through: :attendances
  has_many :attendances
  belongs_to :event_admin, class_name: "User"

  def future_date
    errors.add(:start_date, "Event can't be in the past") unless
      start_date > DateTime.now
  end

  def multiple_of_five?
      errors.add(:duration, "should be a multiple of 5.") unless duration % 5 == 0
  end 
  
end
