class UserPointsController < ApplicationController
  before_action :set_user_point, only: [:show, :edit, :update, :destroy]

  def index
    @user_points = UserPoint.page(params[:page])
  end

  def show
  end

  def new
    @user_point = UserPoint.new
  end

  def edit
  end

  def create
    @user_point = UserPoint.new(user_point_params)

    if @user_point.save
      redirect_to @user_point, notice: 'User point was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_point.update(user_point_params)
      redirect_to @user_point, notice: 'User point was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_point.destroy
    redirect_to user_points_url, notice: 'User point was successfully destroyed.'
  end

  private
    def set_user_point
      @user_point = UserPoint.find(params[:id])
    end

    def user_point_params
      params.require(:user_point).permit(:user_id, :user_coupon_id, :status, :point)
    end
end
