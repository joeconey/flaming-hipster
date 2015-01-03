class QuestionPermissionsController < ApplicationController
	before_action :correct_user,   only: [:edit, :update]
  	before_action :admin_user,     only: :destroy

	def new
		@possible_content = request.GET
		@possible_content.each do |key, value|
	      	if key=="question"
	        	@question_id = value
	        	@user = current_user
	        	@question_owner = Question.find_by(@question_id)
	        	if @question_owner.user_id == @user.id
	        		@question = @question_owner
	        	else
	        		redirect_to root_url
	        	end
			else
				redirect_to root_url
			end
	    

	    @question_permission = QuestionPermission.new
	    #@question_permission["users"] = Array.new
    	@question_permission.question_id = @question_id
    	@users = User.all
    	end
	end

 def create
 	@users = params[:question_permission][:user_id]
 	@question = Question.find(params[:question_permission][:question_id])
 	@users.each do |user| 
 		@question_permit = @question.question_permit(user)
 	end
    if @question_permit.save
      flash[:success] = "Permissions set!"
          redirect_to "/questions/#{@question.id}"
      else
      @feed_items = []
      redirect_to "/questions/#{@question.id}"
    end
end


private
  def question_perm_params
      params.require(:question_permission).permit(:user_id, :question_id)
    end

  def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end

end

