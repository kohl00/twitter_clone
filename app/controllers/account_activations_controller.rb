class AccountActivationsController < ApplicationController
  def edit
  	user = User.find_by(email: params[:email])
  	if user && !user.activated? && user.authenticated?(:activation, params[:id])
  		user.activate
  		flash[:success] = "Account Activated. Now back to VEGAS!"
  		log_in user
  		redirect_to user 
  	else
  		flash[:danger] = "invalid activation link"
  		redirect_to root_url
  	end
  end
end
