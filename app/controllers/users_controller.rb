class UsersController < ApiController
  skip_before_action :authenticate, :only => [:create]

  def index
    render json: {message: "Hello World"}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      record_created(@user)
    else
      bad_request(@user.errors.messages)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
