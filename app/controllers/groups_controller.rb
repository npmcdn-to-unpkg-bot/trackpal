class GroupsController < ApplicationController
  before_action :check_for_user

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
    @newpos = Position.create( latitude: params[:lat], longitude: params[:lng], user_id: @current_user.id, group_id: params[:group_id])
    @newpos.save

    render :json => {status: 'ok'}, status: :ok
  end

  def get_group_coordinates

    # TODO: check user is in this group first!

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

    # # above line is equivalent to:
    # coords = {}
    # positions.each do |key, pos|
    #   coords[pos.user_id] ||= []
    #   coords[pos.user_id] << [pos.latitude, pos.longitude]
    # end
    # p coords
    # render :json => positions, :include => {:user => {:only => :name}}
    render :json => {group: group, users: group_users, coordinates: positions}, status: :ok
  end
# Broadcast button should send these:
# params[:user_ids] = 14, 15, 25
# to
# POST /groups 'posts#create'

# @group = Group.create
# @group.user_ids = params[:user_id]

# Then: Create an array of all the group members phone numbers
# Finally: Message each of the users


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

private

def group_params
  params.require(:group).permit(:name, :location, :datetime)
end

end
