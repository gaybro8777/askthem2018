class Techandciviclife::CandidateSelection < ApplicationRecord
  def primary_candidate
    Techandciviclife::Candidate.where(internal_id: candidate_ids.first).first
  end

  def secondary_candidate
    return nil if candidate_ids.length < 2
    Techandciviclife::Candidate.where(internal_id: candidate_ids[1]).first
  end
end
