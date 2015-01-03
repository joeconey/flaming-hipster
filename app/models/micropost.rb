class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 1000 }
  has_many :votes, dependent:   :destroy

  def top_feed
    Micropost.find_by_sql("SELECT microposts.*, COUNT(votes.id)
 AS c FROM microposts left join votes ON microposts.id = votes.micropost_id
 GROUP BY microposts.id ORDER BY c,created_at DESC")
  end

  def question_top_feed(question_id)
    Micropost.find_by_sql("SELECT microposts.*, COUNT(votes.id)
 AS c FROM microposts left join votes ON microposts.id = votes.micropost_id WHERE microposts.question_id = #{question_id}
 GROUP BY microposts.id ORDER BY c,created_at DESC")
  end



end



