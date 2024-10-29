class CommentableCommentsController < NoolController
  before_action :set_commentable

  def index
    page = commentable_params[:page]
    limit = commentable_params[:limit]

    @pagy, @comments = pagy(@commentable.comments.order(created_at: :desc), page: page, limit: limit)

    authorize @comments
  end

  private

  def set_commentable
    commentable_type, commentable_id = commentable_params.values_at(:commentable_type, :commentable_id)
    @commentable = commentable_type.constantize.find(commentable_id)

    authorize @commentable
  end

  def commentable_params
    params.permit(:commentable_type, :commentable_id, :page, :limit)
  end
end
