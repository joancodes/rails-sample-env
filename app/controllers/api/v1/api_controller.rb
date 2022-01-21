class Api::V1::ApiController < ApplicationController
  include Api::V1::LoginAuth

  before_action :login_auth_token

  def login_auth_token
    begin
      token = extract_token
      raise Unauthorized.new('login required') unless token
      @user_id = decode_jwt(token)[0]['data']['user']['id']
    rescue JWT::ExpiredSignature => e
      logger.error e.message
      render json: { status: 401, message: e.message }, status: :unauthorized
    end
  end

  private

  def current_user
    @current_user ||= User.find(@user_id) if @user_id.present?
  end

  def current_company
    @current_company ||= Company.find(current_user&.company_id) if current_user.present?
  end
end
