module Authenticable
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end

  def check_login
    # head :forbidden unless self.current_user
    render json: { error: 'Not authorized! Please check your login session.' }, status: :forbidden unless self.current_user&.active?
  end
end