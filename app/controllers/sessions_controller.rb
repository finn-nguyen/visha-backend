class SessionsController < ApiController
  skip_before_action :authenticate, :only => [:create]

  def create
    user = User.find_by(username: auth_params[:username])
    if user && user.authenticate(auth_params[:password])
      jwt = JsonWebToken.encode({ id: user.id})
      render json: {token: jwt}, status: 201
    else
      unauthorized
    end
  end

  private
  def auth_params
    params.require(:auth).permit(:username, :password)
  end
end
