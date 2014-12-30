require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def setup
    @base_title = "Ideas App"
  end

   def home
      if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      end
      micropost = Micropost.first
          @top_items = micropost.top_feed.paginate(page: params[:page])    
  end

  def help
  end

  def about
  end

  def contact
  end


end
