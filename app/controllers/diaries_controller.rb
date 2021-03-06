class DiariesController < Users::ApplicationController
  before_action :set_diary, only: [:edit, :update, :destroy]

  def index
    @diaries = Diary.includes(:user).order(created_at: :desc).page(params[:page])
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
      redirect_to @diary, notice: '新しい日記を作成しました'
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
    redirect_to mypage_path, notice: '日記を削除しました'
  end

  private
    def set_diary
      @diary = current_user.diaries.find(params[:id])
    end

    def diary_params
      params.require(:diary).permit(:title, :content, :img_filename)
    end
end
