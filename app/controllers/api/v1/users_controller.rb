class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:index, :show, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET api/v1/users
  def index
    if current_user_admin?
      @users = User.all
    else
      @users = User.all
    end
    render json: UserSerializer.new(@users).serialized_json
  end

  # GET api/v1/users/1
  def show
    if @user.user == current_user || current_user_admin?
      render json: UserSerializer.new(@user).serialized_json if stale?(@user)
    else
      @task.errors.add(:base, "O Usuário atual não possui permissão para isso!")

    end
  end

  # POST api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serialized_json, status: :created
    else
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/users/1
  def update
    if @user == current_user || current_user_admin?
      if @user.update(user_params)
        render json: UserSerializer.new(@user).serialized_json
      else
        render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
      end
    else
      @task.errors.add(:base, "O Usuário atual não possui permissão para isso!")
      render json: ErrorSerializer.serialize(@user.errors), status: :unauthroized
    end
  end

  # DELETE api/v1/users/1
  def destroy
    if @user.user == current_user || current_user_admin?
      @user.destroy
    else
      render json: { error: "Você não pode fazer isso!" }, status: :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: [:user])
  end

  def set_user
    @user = User.find(params[:id])
  end

end