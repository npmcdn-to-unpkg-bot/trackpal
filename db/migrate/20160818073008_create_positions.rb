class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :latitude
      t.string :longitude
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
