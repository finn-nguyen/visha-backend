class SessionsController < ApiController
  before_action :find_user
  skip_before_action :authenticate, :only => [:create]

  def create
    if @user.present? && @user.authenticate(user_params[:password])
      jwt = JsonWebToken.encode({ id: @user.id})
      render json: {token: jwt, username: @user.username, user_id: @user.id}, status: 201
    else
      unauthorized
    end
    
  end

  private
  def find_user
    @user = User.find_by(username: user_params[:username]) || User.create(user_params)
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
