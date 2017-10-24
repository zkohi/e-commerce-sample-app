module UsersApplicationHelper
  def user_point_total
    point = @user_point_total.present? ? number_with_delimiter(@user_point_total.point) : 0
    "#{point}ポイント"
  end
end
