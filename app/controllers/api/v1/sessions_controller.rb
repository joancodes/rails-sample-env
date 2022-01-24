class Api::V1::SessionsController < Api::V1::ApiController

  skip_before_action :login_auth_token, only: [:create]

  def create
    user = User.find_by(api_key: params[:api_key], api_secret: params[:api_secret]) if params[:api_key] && params[:api_secret]
    authorize_error_message = authorize_user user
    if authorize_error_message
      raise Unauthorized, authorize_error_message[:message]
    end
    jwt = generate_jwt({ user: { id: user.id } })
    render json: { access_token: jwt }, status: :created
  end

  private
  def authorize_user user
    return { code: :unauthorized, message: 'Cannot authorize with this service' } unless user
    # 他のメッセージを返す場合は、以下に条件を追加していく
  end
end
