class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :logged_in_user, only: [ :edit, :update, :destroy,
                                        :following, :followers]
	before_action :admin_user,     only: [:destroy, :index]
  def index
  	        @users = User.paginate(page: params[:page],per_page: 5)
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
    	flash[:success] = "User deleted"
        redirect_to users_path
    end
  end

    
  end

  private
  def logged_in_user
      unless !current_user.nil?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
