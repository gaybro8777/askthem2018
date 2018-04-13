class AddIndexToSearch < ActiveRecord::Migration[5.1]
  def up
    execute "CREATE INDEX search_terms_search_text_idx ON search_terms USING GIN (search_text);"
  end

  def down
    execute "DROP INDEX search_terms_search_text_idx"
  end
end
