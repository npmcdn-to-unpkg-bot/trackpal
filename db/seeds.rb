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
g1 = Group.create(:name => 'Myfriends', :latitude => '-33.88614', :longitude => '151.21024')

u1.groups << g1
u2.groups << g1
u3.groups << g1
u4.groups << g1

u1.users << u2






  # t.string   "latitude"
  # t.string   "longitude"
  # t.integer  "user_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

Position.destroy_all
p1 = Position.create(:latitude => '-33.86975', :longitude => '151.20226')
p2 = Position.create(:latitude => '-33.87395', :longitude => '151.25994')
p3 = Position.create(:latitude => '-33.91805', :longitude => '151.25925')
p4 = Position.create(:latitude => '-33.96426', :longitude => '151.14913')
p5 = Position.create(:latitude => '-33.87737', :longitude => '151.20243')
p6 = Position.create(:latitude => '-33.88621', :longitude => '151.19951')
p7 = Position.create(:latitude => '-33.87801', :longitude => '151.25315')
p8 = Position.create(:latitude => '-33.92019', :longitude => '151.24603')
p9 = Position.create(:latitude => '-33.88272', :longitude => '151.25101')
p10 = Position.create(:latitude => '-33.89119', :longitude => '151.24183')
p11 = Position.create(:latitude => '-33.92361', :longitude => '151.23153')
p12 = Position.create(:latitude => '-33.92959', :longitude => '151.21814')
p13 = Position.create(:latitude => '-33.95992', :longitude => '151.13497')
p14 = Position.create(:latitude => '-33.95536', :longitude => '151.12389')
p15 = Position.create(:latitude => '-33.92980', :longitude => '151.12784')

u1.positions << p1
u1.positions << p5
u1.positions << p6
u2.positions << p2
u2.positions << p7
u2.positions << p9
u2.positions << p10
u3.positions << p3
u3.positions << p8
u3.positions << p11
u3.positions << p12
u4.positions << p4
u4.positions << p13
u4.positions << p14
u4.positions << p15


g1.positions << p1
g1.positions << p2
g1.positions << p3
g1.positions << p4
g1.positions << p5
g1.positions << p6
g1.positions << p7
g1.positions << p8
g1.positions << p9
g1.positions << p10
g1.positions << p11
g1.positions << p12
g1.positions << p13
g1.positions << p14
g1.positions << p15
