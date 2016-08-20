class AddGroupIdToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :group_id, :integer
  end
end
