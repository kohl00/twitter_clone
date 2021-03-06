class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def edit
   #@user = User.find(params[:id]) 
  end

  def create
  	@user = User.new(user_params)
  		if @user.save 
        @user.send_activation_email
        flash[:info] = "Please check your email for account activation!"
        redirect_to root_url
      else
        render 'new'
      end
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
       flash[:success] = "Your profile has been updated successfully!"
       redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    #debugger
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def make_admin
    admin_rights
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    #debugger
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title= "Followers"
    @user = User.find(params[:id]) #|| current_user
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

    def admin_rights
      user = User.find(params[:id])
      user.update(:admin => true)
      redirect_to users_url
    end

	  def user_params
	  	params.require(:user).permit(:name, :email,:password,:password_confirmation)
	  end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) 
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    
end
