class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  def index
    @diaries = Diary.all
  end

  def show
  end

  def new
    @diary = Diary.new
  end

  def edit
  end

  def create
    @diary = Diary.new(diary_params)

    if @diary.save
      redirect_to @diary, notice: 'Diary was successfully created.'
    else
      render :new
    end
  end

  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: 'Diary was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: 'Diary was successfully destroyed.'
  end

  private
    def set_diary
      @diary = Diary.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:user_id, :content, :img_filename)
    end
end
