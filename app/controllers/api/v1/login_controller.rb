class Api::V1::LoginController < Api::V1::ApiController

  def submit
    begin
      @json = JSON.parse(request.body.read)
    rescue Exception
      json_parse_error
    end
    if @json && !@json['username'].blank? && !@json['password'].blank?
      @user = User.find_by username: @json['username']
      if @user && @user.valid_password?(@json['password'])
        render json: @user
        return
      end
    end
    user_authentication_failure
  end
end
