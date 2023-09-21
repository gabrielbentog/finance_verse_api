class Api::V1::AuthenticationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def authenticate
    @resource = User.find_for_database_authentication(email: params[:email])
    if @resource&.valid_password?(params[:password])
      sign_in(:user, @resource, store: false, bypass: false)

      @resource.auth_token = @resource.create_new_auth_token["Authorization"]
      render json: UserSerializer.new(@resource).serializable_hash.to_json
    else
      render json: { errors: ['Email ou senha inválidos'] }, status: :unauthorized
    end
  end
end
