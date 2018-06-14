class Contest < ApplicationRecord
  has_many :questions
  has_many :candidates

  def display_name
    "#{name} - #{electoral_district_name}"
  end
end
