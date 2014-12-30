class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user,   only: :destroy

def new
    @micropost = Micropost.new
    @possible_content = request.GET
    @possible_content.each do |key, value|
      if key=="content"
        @final_content = value
        @micropost.content = value
      end
      if key=="title"
        @final_title = value
        @micropost.title = value
      end
    end

end

  def create

    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Idea created!"
        if @micropost.question_id != nil
          question_redirect = @micropost.question_id 
          redirect_to "/questions/#{question_redirect}"
        else
          redirect_to root_url
        end
    else
      @feed_items = []
      render 'static_pages/home'
    end


  end

  def show
    @micropost = Micropost.find(params[:id])
    @user = User.find(@micropost.user_id)
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Idea deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
      params.require(:micropost).permit(:title, :content, :question_id)
    end

  def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
