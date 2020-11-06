class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  
  def index
  end

  def is_admin?
    puts '*****'*30
    puts current_user
    puts current_user.is_admin
    unless current_user.is_admin
    puts '*****'*30
      redirect_to root_path, danger: "You're not an admin of this website"
    end
  end 
end
