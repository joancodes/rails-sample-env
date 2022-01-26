class Api::V1::ApiController < ApplicationController
  class BadRequest < StandardError; end
  class Unauthorized < StandardError; end
  class Forbidden < StandardError; end
  class NotFound < StandardError; end

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, NotFound, with: :render_404
  rescue_from BadRequest, with: :render_400
  rescue_from Unauthorized, with: :render_401
  rescue_from Forbidden, with: :render_403


  include Api::V1::LoginAuth

  protect_from_forgery with: :null_session
  before_action :login_auth_token

  def login_auth_token
    begin
      token = extract_token
      raise Unauthorized.new('login required') unless token
      @user_id = decode_jwt(token)[0]['data']['user']['id']
      log_api_request
    rescue JWT::VerificationError => e
      logger.error e.message
      render json: { status: 401, message: e.message }, status: :unauthorized
    rescue JWT::ExpiredSignature => e
      logger.error e.message
      render json: { status: 401, message: e.message }, status: :unauthorized
    end
  end

  private
  def log_api_request
    ApiRequestLog.create(
      company: current_company,
      user: current_user,
      path: request.path,
      method: request.method,
      action: action_name,
      controller: controller_name,
      request_body: request.raw_post
    )
  end


  def current_user
    @current_user ||= User.find(@user_id) if @user_id.present?
  end

  def current_company
    @current_company ||= Company.find(current_user&.company_id) if current_user.present?
  end

  # Error handling
  def render_400(exception = nil)
    render json: { status: 400, message: exception.message }, status: :bad_request
  end

  def render_401(exception = nil)
    render json: { status: 401, message: exception.message }, status: :unauthorized
  end

  def render_403(exception = nil)
    render json: { status: 403, message: exception.message }, status: :forbidden
  end

  def render_404(exception = nil)
    render json: { status: 404, message: exception.message }, status: :not_found
  end

end
