class Api::UsersController < ApplicationController

  before_action :authenticate_user

  def index
    @users = User.all
    render 'index'
    
  end

  def show
    @user = User.find(params[:id])
    render 'show'
  end

  def create
    @user = User.new(
      char_name: params[:char_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if params[:admin]
      @user.admin = true
    else
      @user.admin = false
    end

    if @user.save
      render 'show'
    else
      render json:{errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
    
  end

  def update
    
    @user = User.find(params[:id])

    @user.char_name = params[:char_name] || @user.char_name
    @user.email = params[:email] || @user.email
    @user.admin = params[:admin] || @user.admin

    if @user.save
      render 'show'
    else
      render json:{errors: @user.errors.full_messages}, status: :unprocessable_entity
    end

  end

end
