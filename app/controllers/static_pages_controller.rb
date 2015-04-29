class StaticPagesController < ApplicationController
  def home
    if logged_in?
  	 @micropost = current_user.microposts.build if logged_in?
  	 @feed_items = current_user.feed.paginate(page: params[:page]) 
      fresh_when(@micropost)
     #render json: @feed_items.to_json(include: :user, only: :content)
    end
  end

  def help

  end

  def about
  end

  def contact
  end
end
