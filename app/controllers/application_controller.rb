class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    auth_headers = request.headers['Authorization']
    if auth_headers.present? && auth_headers[/(?<=\A(Bearer ))\S+\z/]
      token = auth_headers[/(?<=\A(Bearer ))\S+\z/]
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: 'HS256' }
        )
        User.find_by(id: decoded_token[0]["user_id"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  def authenticate_user
    unless current_user
      render json: {errors: "You must be logged in to view this page."}, status: :unauthorized
      return false
    end
    return true
  end

  def authenticate_self
    unless @issue.users[0].id == current_user.id || @issue.users[1].id == current_user.id
      return false
    end
    return true
  end

  def authenticate_admin
    unless current_user && current_user.admin
      render json: {errors: "You are not authorized to modify this. Please ask an admin for assistance."}, status: :unauthorized
      @admin_restricted = true
      return false
    end
    return true
  end

end
