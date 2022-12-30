module Comments
  class CommentsController < ApplicationController
    include Commentable
    before_action :set_commentable

    private

    def set_commentable
      @parent = Comment.find(params[:comment_id])
      @commentable = @parent.commentable # the post of the comment
    end
  end
end