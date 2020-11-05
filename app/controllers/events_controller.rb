class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit]
  before_action :is_admin?, only: [:edit]

  def index
    @event = Event.all
  end

  def new
    @event = Event.new()
  end 

  def create
    @event = Event.new(event_params)
    @event.event_admin = current_user

    if @event.save
      redirect_to event_path(@event.id), success: "Your event has been successfully created!" 
    else
      render '/events/new'
    end
  end 

  def show
    @event = Event.find_by_id(params[:id])
    @end_date_time = (@event.start_date + (@event.duration*60))
  end 

  private 

  def event_params
    event_params = params.require(:event).permit(:start_date, :title, :duration, :description, :price, :location)
  end 

end
