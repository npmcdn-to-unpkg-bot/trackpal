class GroupsController < ApplicationController
  # before_action :authorize_user, :only => [:index]

  def show
    @current_group = Group.find( params[:id] )
    # redirect_to root_path if Time.now > @current_group.datetime
  end

  def submit_position
    # binding.pry
    @newpos = Position.create( latitude: params[:lat], longitude: params[:lng], user_id: @current_user.id, group_id: params[:group_id])
    @newpos.save
    
    render :json => {status: 'ok'}, status: :ok
  end

  def get_group_coordinates
    positions = Position.where( group_id: group_id ).group_by( &:user_id )
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

    positions = Position.where( group_id: group_id ).select(:latitude, :longitude, :user_id).group_by( &:user_id )

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

end
