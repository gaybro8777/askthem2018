class Techandciviclife::Candidate < ApplicationRecord
  belongs_to :person, :primary_key => :internal_id
end
