class Contest < ApplicationRecord
  has_many :questions

  def display_name
    "#{name} - #{electoral_district_name}"
  end
end
