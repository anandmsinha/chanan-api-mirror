class Api::V1::ApiController < ApplicationController
  # For api we don't want session.
  protect_from_forgery with: :null_session

  before_action :destroy_session, :authenticate_client

  protected
    def api_error(status: 500, error: 'Internal server error.')
      res = {error: error, success: false}
      render json: res.to_json, status: status
    end

    def client_unauthenticated
      api_error(status: 401, error: 'Client unauthorized.')
    end

  private
    def destroy_session
      request.session_options[:skip] = true
    end

    def authenticate_client
      if !request.headers.has_key?("Authorization")
        client_unauthenticated
      else
        @auth_header = request.headers["Authorization"].split(":", 3)
        begin
          @client = Client.find_by! api_key: @auth_header[0]
        rescue ActiveRecord::RecordNotFound
          client_unauthenticated
        end
      end
    end
end
