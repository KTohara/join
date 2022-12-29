class Posts::CommentsController < CommentsController
  include Commentable
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Post.find(params[:post_id])
  end
end
