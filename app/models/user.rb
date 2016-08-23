class User < ActiveRecord::Base
  has_secure_password
  validates :email, :presence => true, :uniqueness => true

  has_and_belongs_to_many :groups
  has_many :positions

  has_many :friendships
  # has_many :users, :source => :friendship, :through => :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
end
