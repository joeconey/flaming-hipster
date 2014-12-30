class AddQuestionToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :question_id, :integer, :null => true
  end
end
