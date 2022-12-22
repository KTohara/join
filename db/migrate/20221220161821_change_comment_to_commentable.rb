class ChangeCommentToCommentable < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :parent_id, :commentable_id
    add_column :comments, :commentable_type, :string
    remove_column :comments, :post_id
  end
end
