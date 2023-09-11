class Api::V1::TransactionTypesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_category, only: [:show, :update, :destroy]

  # GET api/v1/categories
  def index
    @categories = TransactionType.all

    render json: TransactionTypeSerializer.new(@categories).serialized_json
  end

  # GET api/v1/categories/1
  def show
      render json: TransactionTypeSerializer.new(@category).serialized_json if stale?(@category)
  end

  # POST api/v1/categories
  def create
    @category = TransactionType.new(category_params)

    if @category.save && current_user_admin?
      render json: TransactionTypeSerializer.new(@category).serialized_json, status: :created
    else
      render json: ErrorSerializer.serialize(@category.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/categories/1
  def update
    if current_user_admin?
      if @category.update(category_params)
        render json: TransactionTypeSerializer.new(@category).serialized_json
      else
        render json: ErrorSerializer.serialize(@category.errors), status: :unprocessable_entity
      end
    else
      @category.errors.add(:base, "O Usuário atual não possui permissão para isso!")
      render json: ErrorSerializer.serialize(@category.errors), status: :unauthroized
    end
  end

  # DELETE api/v1/categories/1
  def destroy
    if current_user_admin?
      @user.destroy
    else
      render json: { error: "Usuário não possui permição!" }, status: :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def category_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: [:category])
  end

  def set_category
    @category = TransactionType.find(params[:id])
  end

end