class DiaryCommentsController < ApplicationController
  before_action :set_diary_comment, only: [:edit, :update, :destroy]

  def new
    @diary_comment = DiaryComment.new
  end

  def edit
  end

  def create
    @diary_comment = current_user.diary_comments.new(diary_comment_params)

    if @diary_comment.save
      redirect_to diary_path(@diary_comment.diary_id), notice: 'コメントを登録しました'
    else
      render :new
    end
  end

  def update
    if @diary_comment.update(diary_comment_params)
      redirect_to @diary_comment, notice: 'コメントを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @diary_comment.destroy
    redirect_to diary_comments_url, notice: 'コメントを削除しました'
  end

  private
    def set_diary_comment
      @diary_comment = current_user.diary_comments.where(diary_id: params[:diary_id]).find(params[:id])
    end

    def diary_comment_params
      params.require(:diary_comment).permit(:content).merge(diary_id: params[:diary_id])
    end
end
