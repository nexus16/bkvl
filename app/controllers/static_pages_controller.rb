class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page],per_page: 5).order('created_at DESC')
    end
  end
end
