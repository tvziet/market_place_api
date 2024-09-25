module Authenticable
  def current_user
    @current_user ||= authenticate_user
  end

  protected

  def check_login
    head :forbidden unless current_user
  end

  private

  def authenticate_user
    token = extract_token_from_header

    return nil unless token

    user_id = decode_token(token)
    User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def extract_token_from_header
    header = request.headers['Authorization']
    header&.split&.last
  end

  def decode_token(token)
    decoded = JsonWebToken.decode(token)
    decoded[:user_id]
  rescue JWT::DecodeError
    nil
  end
end
