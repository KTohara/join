class AddIndexOnCommentable < ActiveRecord::Migration[7.0]
  def change
    remove_index :comments, :commentable_id
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
