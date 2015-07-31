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

    def user_authentication_failure
      api_error(status: 401, error: 'Invalid credentials.')
    end

    def json_parse_error
      api_error(status: 400, error: 'Error parsing json.')
    end

  private
    def destroy_session
      request.session_options[:skip] = true
    end

    def authenticate_client
      if request.headers["HTTP_AUTHORIZATION"].blank?
        client_unauthenticated
      else
        @auth_header = request.headers["HTTP_AUTHORIZATION"].split(":", 3)
        begin
          @client = Client.find_by! api_key: @auth_header[0]
        rescue ActiveRecord::RecordNotFound
          client_unauthenticated
        end
      end
    end
end
