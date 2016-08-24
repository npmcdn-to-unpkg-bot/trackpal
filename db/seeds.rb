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
# u3.groups << g1
# u4.groups << g1







  # t.string   "latitude"
  # t.string   "longitude"
  # t.integer  "user_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false

Position.destroy_all
p1 = Position.create(:latitude => '-32.87393743542484', :longitude => '149.85240113281247')
p2 = Position.create(:latitude => '-32.892389620263806', :longitude => '149.76451050781247')
p3 = Position.create(:latitude => '-32.93850326903932', :longitude => '149.63267457031247')
p4 = Position.create(:latitude => '-32.97537688519785', :longitude => '149.57774292968747')
p5 = Position.create(:latitude => '-32.993807922611516', :longitude => '149.45689332031247')
p6 = Position.create(:latitude => '-33.08590535892481', :longitude => '149.22618042968747')
p7 = Position.create(:latitude => '-33.11351580743973', :longitude => '149.12730347656247')
p8 = Position.create(:latitude => '-33.15951394124883', :longitude => '148.88560425781247')
p9 = Position.create(:latitude => '-33.196295086154585', :longitude => '148.74278199218747')
p10 = Position.create(:latitude => '-33.23306078864273', :longitude => '148.57798707031247')
p11 = Position.create(:latitude => '-32.13271219290327', :longitude => '152.37925660156247')
p12 = Position.create(:latitude => '-32.23499242736592', :longitude => '152.32432496093747')
p13 = Position.create(:latitude => '-32.30930582901175', :longitude => '152.32432496093747')
p14 = Position.create(:latitude => '-32.37428009743007', :longitude => '152.30235230468747')
p15 = Position.create(:latitude => '-32.42993517597378', :longitude => '152.26939332031247')
p16 = Position.create(:latitude => '-32.50408854467761', :longitude => '152.12657105468747')
p17 = Position.create(:latitude => '-32.5874380479525', :longitude => '152.02769410156247')
p18 = Position.create(:latitude => '-32.67071011779145', :longitude => '151.76402222656247')
p19 = Position.create(:latitude => '-32.70769504425769', :longitude => '151.51133667968747')
p20 = Position.create(:latitude => '-32.74466464565342', :longitude => '151.42344605468747')
u1.positions << p1
u1.positions << p2
u1.positions << p3
u1.positions << p4
u1.positions << p5
u1.positions << p6
u1.positions << p7
u1.positions << p8
u1.positions << p9
u1.positions << p10
u2.positions << p11
u2.positions << p12
u2.positions << p13
u2.positions << p14
u2.positions << p15
u2.positions << p16
u2.positions << p17
u2.positions << p18
u2.positions << p19
u2.positions << p20


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
g1.positions << p16
g1.positions << p17
g1.positions << p18
g1.positions << p19
g1.positions << p20
