class CreateSearchView < ActiveRecord::Migration[5.1]
  def up
    execute <<-EOS
    create materialized view search_terms (id, table_name, search_text, display_text, electoral_district_type) AS (

(select contests.id, 'candidates', to_tsvector(coalesce(primary_name, '') || ' ' || coalesce(primary_party, '') || ' ' || coalesce(secondary_name, '')), coalesce(primary_name, '') || ' - ' || coalesce(electoral_district_name, ''), electoral_district_type from candidates join contests on contests.id = contest_id)
UNION
(select id, 'contests', to_tsvector(coalesce(primary_office_name, '') || ' ' || coalesce(secondary_office_name, '') || ' ' || coalesce(electoral_district_name, '')), coalesce(name, '') || ' - ' || coalesce(electoral_district_name, ''), electoral_district_type from contests)
)
    EOS
  end

  def down
    execute "drop materialized view search_terms"
  end
end
