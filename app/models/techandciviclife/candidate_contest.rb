class Techandciviclife::CandidateContest < ApplicationRecord
  belongs_to :electoral_district, :primary_key => :internal_id

  #TODO split office in techandciviclife
  def primary_office
    Techandciviclife::Office.where(internal_id: office_id.split.first).first
  end

  def secondary_office
    Techandciviclife::Office.where(internal_id: office_id.split[1]).first
  end
end
