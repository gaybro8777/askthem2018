class Contest < ApplicationRecord

  def display_name
    "#{name} - #{electoral_district_name}"
  end
end
