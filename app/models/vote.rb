class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :question


  ###
  # Current plan, use hacker news algorithm: https://medium.com/hacking-and-gonzo/how-hacker-news-ranking-algorithm-works-1d9b0cf2c08d
  # Score = (P-1) / (T+2)^G
  #
  # where,
  # P = points of an item (and -1 is to negate submitters vote)
  # T = time since submission (in hours)
  # G = Gravity, defaults to 1.8 in news.arc


end
