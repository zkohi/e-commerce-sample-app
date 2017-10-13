class Backoffice::UsersController < Backoffice::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user_points = @user.user_points.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to backoffice_user_path(@user), notice: 'ユーザーが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to backoffice_users_url, notice: 'ユーザーが削除されました'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :zipcode, :address, :nickname, :img_filename)
    end
end
