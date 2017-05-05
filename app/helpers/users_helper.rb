module UsersHelper
  def posts_comments_exists?(user)
    user.posts.size > 0 || user.comments.size > 0
  end
end
