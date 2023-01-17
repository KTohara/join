module Posts
  class CommentsController < CommentsController
    include Commentable
    before_action :set_commentable

    private

    def set_commentable
      @commentable = Post.find_by(id: params[:post_id])
    end
  end
end
