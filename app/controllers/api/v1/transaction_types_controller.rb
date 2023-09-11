class Api::V1::TransactionTypesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_transaction_type, only: [:show, :update, :destroy]

  # GET api/v1/transaction_types
  def index
    @transaction_types = TransactionType.all

    render json: TransactionTypeSerializer.new(@transaction_types).serialized_json
  end

  # GET api/v1/transaction_types/1
  def show
      render json: TransactionTypeSerializer.new(@transaction_type).serialized_json if stale?(@transaction_type)
  end

  # POST api/v1/transaction_types
  def create
    @transaction_type = TransactionType.new(transaction_type_params)

    if @transaction_type.save && current_user_admin?
      render json: TransactionTypeSerializer.new(@transaction_type).serialized_json, status: :created
    else
      render json: ErrorSerializer.serialize(@transaction_type.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/transaction_types/1
  def update
    if current_user_admin?
      if @transaction_type.update(transaction_type_params)
        render json: TransactionTypeSerializer.new(@transaction_type).serialized_json
      else
        render json: ErrorSerializer.serialize(@transaction_type.errors), status: :unprocessable_entity
      end
    else
      @transaction_type.errors.add(:base, "O Usuário atual não possui permissão para isso!")
      render json: ErrorSerializer.serialize(@transaction_type.errors), status: :unauthroized
    end
  end

  # DELETE api/v1/transaction_types/1
  def destroy
    if current_user_admin?
      @user.destroy
    else
      render json: { error: "Usuário não possui permição!" }, status: :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def transaction_type_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: [:transaction_type])
  end

  def set_transaction_type
    @transaction_type = TransactionType.find(params[:id])
  end

end