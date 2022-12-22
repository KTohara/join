class RemoveFkFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :comments, :comments
  end
end
