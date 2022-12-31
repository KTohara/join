module LikesHelper
  def like_text(like_status)
    like_status ? 'Unlike' : 'Like'
  end
end
