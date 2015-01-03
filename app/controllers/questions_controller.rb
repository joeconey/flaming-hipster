class QuestionsController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @questions = Question.paginate(page: params[:page]).order(id: :desc)
     @question = Question.new
  end

   def show
    @user = current_user
    @question = Question.find(params[:id])
    @owner = User.find(@question.user_id)
    @microposts = Micropost.where(question_id: @question.id).paginate(page: params[:page])
    micropost = Micropost.first
    @microposts_votes_full = micropost.question_top_feed(@question.id)
    @microposts_votes = @microposts_votes_full.paginate(page: params[:page]) 

    Micropost.where(question_id: @question.id)
        if logged_in?
      		@micropost = current_user.microposts.build
  		end
  	#@feed_items = current_user.feed.paginate(page: params[:page])
  end

#   def edit
#    @question = Question.find(params[:id])
#    if @question.update_attributes(user_params)
#      flash[:success] = "Question updated"
#      redirect_to @question
#    else
#      render 'edit'
#    end
#  end

def new
    @question = Question.new
    #@question_perms = Question_perms.new
end

 def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Question created!"
          question_redirect = @question.id 
          redirect_to "/questions/#{question_redirect}"
      else
      @feed_items = []
      render 'static_pages/home'
    end
end

  	private
  def question_params
      params.require(:question).permit(:name, :private)
    end

  def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end

end
