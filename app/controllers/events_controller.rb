class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @event = Event.all
  end

  def new
    @event = Event.new()
  end 

  def create
    @event = Event.new(post_params)
    @user = current_user
    # @gossip.user = User.find_by(id: session[:user_id])

    if @event.save
      flash[:notice] = 'All good. Your event has been saved!'
      redirect_to root_path 
    else
      render '/events/new'
    end
  end 

  def show
    @event = Event.find_by_id(params[:id])
  end 



  private 

  def post_params
    post_params = params.require(:event).permit(:start_date, :title, :duration, :description, :price, :location)
  end 
end
