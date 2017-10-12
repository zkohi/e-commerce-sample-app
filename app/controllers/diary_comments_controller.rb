class DiaryCommentsController < ApplicationController
  before_action :set_diary_comment, only: [:destroy]

  def create
    @diary_comment = current_user.diary_comments.new(diary_comment_params)

    if @diary_comment.save
      DiaryCommentMailer.post_comment_email(@diary_comment).deliver_now
      redirect_to diary_path(@diary_comment.diary_id), notice: 'コメントを登録しました'
    else
      render :new
    end
  end

  def destroy
    @diary_comment.destroy
    redirect_to diary_path(@diary_comment.diary_id), notice: 'コメントを削除しました'
  end

  private
    def set_diary_comment
      @diary_comment = current_user.diary_comments.where(diary_id: params[:diary_id]).find(params[:id])
    end

    def diary_comment_params
      params.require(:diary_comment).permit(:content).merge(diary_id: params[:diary_id])
    end
end
