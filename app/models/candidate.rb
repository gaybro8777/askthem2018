class Candidate < ApplicationRecord
  belongs_to :contest

  def name
    primary_name
  end
end
