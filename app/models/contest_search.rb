class ContestSearch
  def self.search(query)
    columns = %w(primary_office_name secondary_office_name electoral_district_name)
    tsvector = to_tsvector(columns)
    results = Contest.where("to_tsvector(#{tsvector}) @@ to_tsquery('english', ?)", to_tsquery(query)).order(case_statement)

    if results.empty?
      columns = %w(primary_name primary_party secondary_name)
      tsvector = to_tsvector(columns)
      results = Candidate.where("to_tsvector(#{tsvector}) @@ to_tsquery('english', ?)", to_tsquery(query))
    end

    results
  end

  def self.to_tsvector(columns)
    columns.map {|c| "coalesce(#{c}, '')" }.join(" || ' ' || ")
  end

  def self.to_tsquery(query)
    res = query.split(' ').map {|q| "#{q}:*" }.join(" & ")
  end

  def self.case_statement
    <<-EOS
CASE electoral_district_type
 WHEN 'congressional' THEN 0
 WHEN 'state' THEN 1
 WHEN 'state-senate' THEN 2
 WHEN 'state-house' THEN 3
 WHEN 'judicial' THEN 4
 WHEN 'county' THEN 5
 WHEN 'county-council' THEN 6
 WHEN 'school' THEN 7
 WHEN 'city' THEN 8
 WHEN 'city-council' THEN 9
 WHEN 'town' THEN 10
 WHEN 'township' THEN 11
 WHEN 'village' THEN 12
 WHEN 'borough' THEN 13
 WHEN 'utility' THEN 14
 WHEN 'ward' THEN 15
 WHEN 'special' THEN 16
 WHEN 'water' THEN 17
 WHEN 'other' THEN 18
 ELSE 19
END
    EOS
  end
end
