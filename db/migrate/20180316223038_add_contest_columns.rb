class AddContestColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :contests, :primary_office_name, :text
    add_column :contests, :primary_office_description, :text
    add_column :contests, :secondary_office_name, :text
    add_column :contests, :secondary_office_description, :text
    add_column :contests, :candidate_contest_id, :text
    add_column :contests, :electoral_district_name, :text
    add_column :contests, :electoral_district_type, :text
  end
end
