class AddNestingToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :nesting, :integer, default: 1
  end
end
