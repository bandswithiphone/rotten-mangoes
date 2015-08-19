class Admin::UsersController < ApplicationController
  
  before_action :require_admin_user

  def index
    @users = User.all
  end

  def show
    
  end

  def new
    
  end

  def edit
    
  end

  private

  def require_admin_user
    if !current_user.admin
      flash[:error] = "You must be logged in to access this section"
      redirect_to movies_path  
    end 
  end 
end

