class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET api/v1/transactions
  def index
    @transactions = current_user.transactions

    render json: TransactionSerializer.new(@transactions).serializable_hash.to_json
  end

  # GET api/v1/transactions/1
  def show
    if @transaction.user == current_user
      render json: TransactionSerializer.new(@transaction).serializable_hash.to_json if stale?(@transaction)
    else
      @transaction.errors.add(:base, "O Usuário atual não possui permissão para isso!")

    end
  end

  # POST api/v1/transactions
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: TransactionSerializer.new(@transaction).serializable_hash.to_json, status: :created
    else
      render json: ErrorSerializer.serialize(@transaction.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/transactions/1
  def update
    if @transaction.user == current_user
      if @transaction.update(transaction_params)
        render json: TransactionSerializer.new(@transaction).serializable_hash.to_json
      else
        render json: ErrorSerializer.serialize(@transaction.errors), status: :unprocessable_entity
      end
    else
      @transaction.errors.add(:base, "O Usuário atual não possui permissão para isso!")
      render json: ErrorSerializer.serialize(@transaction.errors), status: :unauthroized
    end
  end

  # DELETE api/v1/transactions/1
  def destroy
    if @transaction.user == current_user
      @transaction.destroy
    else
      render json: { error: "Usuário não possui permição!" }, status: :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def transaction_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: [:transaction])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

end