class DiariesController < ApplicationController
  before_action :set_diary, only: [:edit, :update, :destroy]

  def index
    @diaries = Diary.page(params[:page]).order("created_at DESC")
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = Diary.new
  end

  def edit
  end

  def create
    @diary = current_user.diaries.new(diary_params)

    if @diary.save
      redirect_to @diary, notice: '新しい日記が作成されました'
    else
      render :new
    end
  end

  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: '日記を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: '日記を削除しました'
  end

  private
    def set_diary
      @diary = current_user.diaries.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:title, :content, :img_filename)
    end
end
