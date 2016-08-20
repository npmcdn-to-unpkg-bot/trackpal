# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
u1 = User.create(:name => "Satya", :password => "chicken", :password_confirmation => 'chicken', :email => "satya.anupindi@gmail.com")
u2 = User.create(:name => "Phani", :password => "chicken", :password_confirmation => 'chicken', :email => "ganti.phani@gmail.com")
u3 = User.create(:name => "Ameya", :password => "chicken", :password_confirmation => 'chicken', :email => "ameya@gmail.com")
u4 = User.create(:name => "Sam", :password => "chicken", :password_confirmation => 'chicken', :email => "sam@gmail.com")

# t.string   "name"
# t.string   "latitude"
# t.string   "longitude"
# t.datetime "datetime"

Group.destroy_all
g1 = Group.create(:name => 'Myfriends', :latitude => '-33.881400', :longitude => '151.203289')

u1.groups << g1
u2.groups << g1
u3.groups << g1
u4.groups << g1



  # t.string   "latitude"
  # t.string   "longitude"
  # t.integer  "user_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

Position.destroy_all
p1 = Position.create(:latitude => '-33.8296', :longitude => '151.1258')
p2 = Position.create(:latitude => '-33.8060', :longitude => '151.2948')
p3 = Position.create(:latitude => '-33.81444', :longitude => '150.99696')
p4 = Position.create(:latitude => '-33.86663', :longitude => '151.02443')
p5 = Position.create(:latitude => '-33.8296', :longitude => '151.1258')
p6 = Position.create(:latitude => '-33.8060', :longitude => '151.2948')
p7 = Position.create(:latitude => '-33.81444', :longitude => '150.99696')
p8 = Position.create(:latitude => '-33.86663', :longitude => '151.02443')


u1.positions << p1
u1.positions << p5
u1.positions << p6
u2.positions << p2
u2.positions << p7
u3.positions << p3
u3.positions << p8
u4.positions << p4

g1.positions << p1
g1.positions << p2
g1.positions << p3
g1.positions << p4
g1.positions << p5
g1.positions << p6
g1.positions << p7
g1.positions << p8
