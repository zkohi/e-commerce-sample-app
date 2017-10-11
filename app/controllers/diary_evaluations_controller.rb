class DiaryEvaluationsController < ApplicationController
  def create
    @diary_evaluation = current_user.diary_evaluations.new(diary_id: params[:diary_id])

    if @diary_evaluation.save
      message = '評価を登録しました'
    else
      message = '評価を削除できませんでした'
    end
    redirect_to diary_url(@diary_evaluation.diary_id), notice: message
  end

  def destroy
    @diary_evaluation = current_user.diary_evaluations.where(diary_id: params[:diary_id]).find(params[:id])
    if @diary_evaluation.destroy
      message = '評価を削除しました'
    else
      message = '評価を削除できませんでした'
    end
    redirect_to diary_url(@diary_evaluation.diary_id), notice: message
  end
end
