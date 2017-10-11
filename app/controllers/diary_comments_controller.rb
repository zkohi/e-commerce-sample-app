class DiaryCommentsController < ApplicationController
  before_action :set_diary_comment, only: [:show, :edit, :update, :destroy]

  def index
    @diary_comments = DiaryComment.all
  end

  def show
  end

  def new
    @diary_comment = DiaryComment.new
  end

  def edit
  end

  def create
    @diary_comment = DiaryComment.new(diary_comment_params)

    if @diary_comment.save
      redirect_to @diary_comment, notice: 'Diary comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @diary_comment.update(diary_comment_params)
      redirect_to @diary_comment, notice: 'Diary comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @diary_comment.destroy
    redirect_to diary_comments_url, notice: 'Diary comment was successfully destroyed.'
  end

  private
    def set_diary_comment
      @diary_comment = DiaryComment.find(params[:id])
    end

    def diary_comment_params
      params.require(:diary_comment).permit(:user_id, :diary_id, :content)
    end
end
