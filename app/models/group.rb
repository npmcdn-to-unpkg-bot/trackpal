class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :positions

  geocoded_by :location
  after_validation :geocode
end
