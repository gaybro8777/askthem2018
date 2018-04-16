class Question < ApplicationRecord
  belongs_to :contest
  has_many :votes
  has_many :answers

  def vote_total
    votes.count
  end


  ###
  # Current plan, use hacker news algorithm: https://medium.com/hacking-and-gonzo/how-hacker-news-ranking-algorithm-works-1d9b0cf2c08d
  # Score = (P-1) / (T+2)^G
  #
  # where,
  # P = points of an item (and -1 is to negate submitters vote)
  # T = time since submission (in hours)
  # G = Gravity, defaults to 1.8 in news.arc


  def self.sorted_by_votes
    joins("left join (select count(*) total, question_id from votes group by question_id) as vote_totals ON vote_totals.question_id = questions.id").order("vote_totals.total")
  end
end
