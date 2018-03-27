class ContestSearch
  def self.search(query)

    columns = %w(primary_office_name secondary_office_name electoral_district_name)
    tsvector = to_tsvector(columns)
    results = Contest.where("to_tsvector(#{tsvector}) @@ to_tsquery('english', ?)", query + ":*")

    if results.empty?
      columns = %w(primary_name primary_party secondary_name)
      tsvector = to_tsvector(columns)
      results = Candidate.where("to_tsvector(#{tsvector}) @@ to_tsquery('english', ?)", query + ":*")
    end

    results
  end

  def self.to_tsvector(columns)
    columns.map {|c| "coalesce(#{c}, '')" }.join(" || ' ' || ")
  end
end
