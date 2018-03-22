class CandidateNormalizer
  def self.run!
    Techandciviclife::CandidateSelection.find_each do |candidate_selection|

      primary_candidate = candidate_selection.primary_candidate
      secondary_candidate = candidate_selection.secondary_candidate

      candidate = Candidate.new(
        primary_name: primary_candidate.name,
        candidate_selection_id: candidate_selection.internal_id,
        contest: contest_id(candidate_selection)
      )

      if primary_candidate.party.present?
        candidate.primary_party = primary_candidate.party.name
      end

      if secondary_candidate.present?
        candidate.secondary_name = secondary_candidate.name
        if secondary_candidate.party.present?
          candidate.secondary_party = secondary_candidate.party.name
        end
      end

      candidate.save!
    end
  end

  def self.contest_id(candidate_selection)
    candidate_contests = Techandciviclife::CandidateContest.where(
      "? = ANY (candidate_selections)",
      candidate_selection.internal_id
    ).all

    raise "WTF: #{candidate_selection.attributes.insepct}" if candidate_contests.length > 1
    candidate_contest = candidate_contests.first
    Contest.where(candidate_contest_id: candidate_contest.internal_id).first
  end
end

