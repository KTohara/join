class AddCommentCounterToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comment_count, :integer, default: 0
  end
end
