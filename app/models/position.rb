class Position < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def user_name
    user.name
  end

end
