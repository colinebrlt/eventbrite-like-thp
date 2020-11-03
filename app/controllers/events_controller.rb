class EventsController < ApplicationController
  def index
    @event = Event.all
  end
end
