class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.datetime :datetime

      t.timestamps null: false
    end
  end
end
