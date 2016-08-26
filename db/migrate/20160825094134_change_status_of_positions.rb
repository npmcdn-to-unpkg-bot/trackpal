class ChangeStatusOfPositions < ActiveRecord::Migration
  def change
    change_column :positions, :status, :text, :default => "transit"
  end
end
