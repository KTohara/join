module Posts
  class LikesController < LikesController
    before_action :set_likeable

    private

    def set_likeable
      @likeable = Post.find_by(id: params[:post_id])
    end
  end
end