class AddGifUrlToTables < ActiveRecord::Migration[7.0]
  def change
    tables = [:posts, :comments]
    
    tables.each do |table_name|
      add_column table_name, :gif_url, :string
    end
  end
end
