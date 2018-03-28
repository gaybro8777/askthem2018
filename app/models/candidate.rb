class Candidate < ApplicationRecord
  belongs_to :contest

  def display_name
    primary_name
  end
end
