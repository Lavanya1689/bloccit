class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    if params[:post_id].present?
      @model = Post.find(params[:post_id])
      logger.info "CREATING POST"
    else
      @model = Topic.find(params[:topic_id])
      logger.info "CRATING TOPIC"
    end
    logger.info "MODEL #{@model.inspect}"
    comment = @model.comments.build(comment_params)
    comment.user = current_user
    logger.info "============ THE COMMENT IS: #{comment.inspect}"
    if comment.save
      flash[:notice] = "Comment saved successfully"
    else
      flash[:alert] = 'Comment failed to save'
    end
    if @model.is_a?(Post)
      redirect_to [@model.topic, @model]
    else
      redirect_to @model
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Deleted successfully!"
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment failed to delete"
      redirect_to [@post.topic, @post]
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to [comment.post.topic, comment.post]
     end
   end
end
