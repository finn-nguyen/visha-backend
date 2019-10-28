class ApiController < ApplicationController
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
end
