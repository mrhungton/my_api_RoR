class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    
    if @user&.authenticate(user_params[:password])
      if @user.active?
        render json: { 
          token: JsonWebToken.encode(user_id: @user.id),
          email: @user.email,
          rules: Ability.new(@user).to_list
        }
      else
        render json: { error: 'Access is forbidden' }, status: :unauthorized
      end
    else
      # head :unauthorized
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
