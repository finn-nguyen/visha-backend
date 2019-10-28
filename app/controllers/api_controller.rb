class ApiController < ApplicationController
  def render_record(record)
    render(
      json: record,
      root: 'record'
    )
  end

  def render_bad_request(message)
    render json: { error: message }, status: 400
  end

  def render_resource_not_found
    render json: { error: 'Not found'}, status: 404
  end

  def render_unauthorized
    render json: { error: 'Unauthorized'}, status: 401
  end

  def render_forbidden
    render json: {error: 'Forbidden'}, status: 403
  end
end
