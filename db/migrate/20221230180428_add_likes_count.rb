class AddLikesCount < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :like_count, :integer, default: 0
    add_column :comments, :like_count, :integer, default: 0
  end
end
