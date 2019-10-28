class ApiController < ApplicationController
  before_action :authenticate 
  attr_reader :current_user

  def record_created(record)
    render(
      json: record,
      root: 'record',
      status: 201
    )
  end

  def bad_request(message)
    render json: { error: message }, status: 400
  end

  def not_found
    render json: { error: 'Not found'}, status: 404
  end

  def unauthorized
    render json: { error: 'Unauthorized'}, status: 401
  end

  def forbidden
    render json: {error: 'Forbidden'}, status: 403
  end

  def internal_error(message)
    render json: {error: message}, status: 500
  end

  protected
  def authenticate
    data = JsonWebToken.decode(token)
    @current_user = User.find(data[:id])
  rescue Exception
    unauthorized
  end

  def logged_in?
    @current_user.present?
  end

  private
  def token
    header = request.headers['Authorization']
    info = header.split(' ')
    info.last if info.first == 'Bearer'
  end
end
