class Question < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 140 }
  has_many :question_permissions, dependent:   :destroy


  # permits a user.
  def question_permit(other_user)
    QuestionPermission.create(user_id: other_user, question_id: self.id)
  end

  # unpermits a user.
  def question_unpermit(question_permission)
    QuestionPermission.find_by(id:question_permission.id).destroy
  end

  # Returns true if the current user is allowed.
  def allowed?(other_user)
    question_permissions.include?(other_user)
  end


end
