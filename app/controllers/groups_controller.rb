class GroupsController < ApplicationController
  before_action :check_for_user, :except => [:submit_position]

  def show
    @current_group = Group.find( params[:id] )
    # redirect_to root_path if Time.now > @current_group.datetime
  end

  def create

    @newgroup = Group.create (group_params)
#
    friends = params[:friends]
    friends << @current_user
    friends.each do |friend|
      send_text_message(User.find(friend).phone)
      @newgroup.users << User.find(friend)
    end

    redirect_to @newgroup

  end

  def submit_position
    # binding.pry
    user_id = @current_user.try(:id) || params[:user_id]
    @newpos = Position.create( latitude: params[:lat], longitude: params[:lng], user_id: user_id, group_id: params[:group_id])
    @newpos.save
    group = Group.find( params[:group_id] )
    username = User.find(user_id).name

    point1 = [params[:lat],params[:lng]]
    point2 = [group.latitude, group.longitude]

    # render :json => {status: 'ok'}, status: :ok

  # nearby will return rows if this user has already reached the
  # notification distance and sent notifiications
  nearby = Position.where(user_id: user_id)
                   .where(group_id: params[:group_id])
                   .where(status: "nearby")

    dist = get_DistanceFromLatLon_InKm(point1, point2)

  sent = false

  if nearby.empty? && dist < 1
    @newpos.update( :status => "nearby")
    group.users.each do |user|
      send_text_distance(user.phone, username )
    end
    sent = true
  end

   render :json => {status: 'ok', dist: dist, near: nearby, sent: sent}, status: :ok


  end

  def get_group_coordinates

    positions = Position.where( group_id: params['group_id'] )
                        .order('created_at')
                        .group_by( &:user_id )

    # TODO ^ make more efficient by storing a last_position_update datetime
    # in user table, and only retrieving Positions which have a created_date
    # which is newer than @current_user.last_position_update
    render :json => {coordinates: positions}, status: :ok
  end

  def get_group_details
    group_id = params['group_id']
    # TODO: check that this user is in this group first!

    # return a hash of users in group, with user id as the hash key

    group = Group.find( group_id );
    group_users = group.users.select("name, id, email, image").index_by(&:id)
    # TODO: ^ check returns actual users

    positions = Position.where( group_id: group_id )
                        .order('created_at')
                        .select(:latitude, :longitude, :user_id)
                        .group_by( &:user_id )

    render :json => {group: group, users: group_users, coordinates: positions}, status: :ok
  end

def get_DistanceFromLatLon_InKm(point1,point2)
  distance = Geocoder::Calculations.distance_between(point1, point2)
 end

def send_text_message(phone)
  # number_to_send_to = params[:number_to_send_to]
  twilio_sid = "AC3a80958af3a028cfc67db78aaba8461b"
  twilio_token = "29e47689c9ebf2f63f187bbad91d99b2"
  twilio_phone_number = "61437081575"

  @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

  @twilio_client.account.sms.messages.create(
    :from => "+#{twilio_phone_number}",
    :to => phone,
    :body => "Join this group at #{ group_url(@newgroup) }."
  )
end

def send_text_distance(phone, username)
  # number_to_send_to = params[:number_to_send_to]
  twilio_sid = "AC3a80958af3a028cfc67db78aaba8461b"
  twilio_token = "29e47689c9ebf2f63f187bbad91d99b2"
  twilio_phone_number = "61437081575"

  @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

  @twilio_client.account.sms.messages.create(
    :from => "+#{twilio_phone_number}",
    :to => phone,
    :body => "#{username} is 1 mile away from destination"
  )
end

private

def group_params
  params.require(:group).permit(:name, :location, :datetime)
end

end
