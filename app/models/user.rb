class User < ActiveRecord::Base

  has_secure_password
  validates :email, :presence => true, :uniqueness => true

  has_and_belongs_to_many :groups
  has_many :positions

  has_many :friendships
  has_many :friends, :through => :friendships
end
