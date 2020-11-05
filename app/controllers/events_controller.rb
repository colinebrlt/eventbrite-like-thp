class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit]
  before_action :is_event_admin?, only: [:edit]

  def index
    @event = Event.all
  end

  def new
    @event = Event.new()
  end 

  def create
    @event = Event.new(event_params)
    @event.event_admin = current_user
    # @event.picture.attach(params[:event][:picture])

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

  def edit
  end

  def update
    @event = Event.find(params[:id])
    @event.picture.attach(params[:event][:picture])
    if @event.update(event_params)
      redirect_to event_path(@event.id), success: "Event successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to root_path
  end

  private 

  def event_params
    event_params = params.require(:event).permit(:start_date, :title, :duration, :description, :price, :location, :picture)
  end 

  def is_event_admin?
    @event = Event.find(params[:id])
    if @event.event_admin == current_user
      return true
    else
      redirect_to event_path(@event), danger: "You didn't create this event"
    end
  end

end
