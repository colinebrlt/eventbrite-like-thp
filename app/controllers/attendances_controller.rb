class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :amounts
  
  def new    
    can_subscribe?
    event_admin_restrictions
  end
  
  def create
    can_subscribe?
    event_admin_restrictions
  
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })

      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount,
        description: 'Rails Stripe customer',
        currency: 'eur',
      })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event)
    end

    Attendance.create(user: current_user, event: @event, stripe_customer_id: customer.id)

  end 

  def index
    is_event_admin?
  end 

  private

  def amounts
    @event = Event.find(params[:event_id])
    @amount = @event.price 
    @stripe_amount = @amount * 100
  end 

  def can_subscribe?
    if @event.users.select{ |user| user == current_user }.count == 0
      return true
    else
      redirect_to event_path(@event), warning: "You already registered to this event"
    end
  end

  def is_event_admin?
    if @event.event_admin == current_user
      return true
    else
      redirect_to event_path(@event), danger: "You didn't create this event"
    end
  end

  def event_admin_restrictions
    if @event.event_admin == current_user
      redirect_to event_path(@event), danger: "You didn't create this event"
    end
  end

end
