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

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: "Comment was successfully created." }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.commentable, notice: "Comment was successfully updated." }
        format.json { render json: @comment, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.commentable, notice: "Comment was successfully deleted." }
      format.json { head :no_content }
    end
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
