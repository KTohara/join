class LikesController < ApplicationController

  def create
    @like = @likeable.likes.build(user: current_user)
    @like.save
    respond_to do |format|
      flash.now[:notice] = 'You liked the thing!'
      format.turbo_stream { turbo_update_like_button }
      format.html { redirect_back fallback_location: posts_path, notice: 'You liked the thing!' }
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    respond_to do |format|
      flash.now[:alert] = 'You unliked the thing!'
      format.turbo_stream { turbo_update_like_button }
      format.html { redirect_back fallback_location: posts_path, alert: 'You unliked the thing!' }
    end
  end

  private

  def turbo_update_like_button
    render turbo_stream: [
      turbo_stream.replace(
        helpers.dom_id(@likeable, :like_button),
        partial: 'likes/like_button',
        locals: { likeable: @likeable, current_user: current_user }
      ),
      turbo_stream.prepend('alert', partial: 'shared/alert')
    ]
  end
end
