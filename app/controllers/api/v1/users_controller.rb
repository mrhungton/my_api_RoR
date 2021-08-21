class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource class: "User"
  
  before_action :check_login
  before_action :set_user, only: [:show, :update, :destroy, :block, :unblock]
  
  # GET /users
  def list
    @users = User.page(current_page).per(per_page)

    @users = @users.search(params)
    
    # check authorized (user)
    if can? :list_not_blocked, User
      @users = @users.search(params).not_blocked
    end
    
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /users/1
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: {messages: 'deleted'}, status: :ok
  end

  # PUT /users/1
  def block
    @user.block
    render json: @user, status: :ok, messages: 'blocked'
  end

  # PUT /users/1
  def unblock
    @user.unblock
    render json: @user, status: :ok, messages: 'un-blocked'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password, :role, :name)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
