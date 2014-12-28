class VotesController < ApplicationController
	before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.vote(@micropost)
    respond_to do |format|
      format.html { redirect_to @micropost }
      format.js
    end

  end

  def destroy
   	vote = Vote.find(params[:id])
   	@micropost = Micropost.find(vote.micropost_id)
    current_user.unvote(vote)
        respond_to do |format|
      format.html
      format.js
    end

  end


end
