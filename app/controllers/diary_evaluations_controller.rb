class DiaryEvaluationsController < ApplicationController
  before_action :set_diary_evaluation, only: [:show, :edit, :update, :destroy]

  def index
    @diary_evaluations = DiaryEvaluation.all
  end

  def show
  end

  def new
    @diary_evaluation = DiaryEvaluation.new
  end

  def edit
  end

  def create
    @diary_evaluation = DiaryEvaluation.new(diary_evaluation_params)

    if @diary_evaluation.save
      redirect_to @diary_evaluation, notice: 'Diary evaluation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @diary_evaluation.update(diary_evaluation_params)
      redirect_to @diary_evaluation, notice: 'Diary evaluation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @diary_evaluation.destroy
    redirect_to diary_evaluations_url, notice: 'Diary evaluation was successfully destroyed.'
  end

  private
    def set_diary_evaluation
      @diary_evaluation = DiaryEvaluation.find(params[:id])
    end

    def diary_evaluation_params
      params.require(:diary_evaluation).permit(:user_id, :diary_id)
    end
end
