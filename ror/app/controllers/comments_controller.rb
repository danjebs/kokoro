class CommentsController < DashboardController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new(**comment_params)
    authorize @comment
  end

  def create
    @comment = Comment.new(**comment_params)
    @comment.user = current_user
    authorize @comment

    if @comment.save
      redirect_to @comment.commentable, notice: "Comment was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: "Comment was successfully deleted."
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])

    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end
