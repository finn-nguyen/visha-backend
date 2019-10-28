class UsersController < ApiController
  def create
    @user = User.new(user_params)
    if (@user.save)
      render_record(@user)
    else
      render_bad_request(@user.errors.messages)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
