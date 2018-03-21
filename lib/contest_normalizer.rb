class ContestNormalizer
  def self.run!
    Techandciviclife::CandidateContest.find_each do |contest|
      primary_office = contest.primary_office
      secondary_office = contest.secondary_office

      if contest.electoral_district.nil?
        raise "No electoral_district for #{contest.attributes.inspect}"
      end


      normalized_contest = Contest.new(
        name: contest.name,
        primary_office_name: primary_office.name,
        primary_office_description: primary_office.description,
        candidate_contest_id: contest.internal_id,
        electoral_district_name: contest.electoral_district.name,
        electoral_district_type: contest.electoral_district.type,
      )

      if secondary_office.present?
        normalized_contest.secondary_office_name = secondary_office.name
        normalized_contest.secondary_office_description = secondary_office.description
      end
      normalized_contest.save!
    end
  end
end
