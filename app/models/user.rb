class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :ensure_authentication_token

  private
    def email_required?
      false
    end

    def ensure_authentication_token
      if self.api_token.blank?
        self.api_token = generate_api_token
      end
    end

    def generate_api_token
      while true
        token = Devise.friendly_token
        user = User.find_by api_token: token
        if user.blank?
          return token
        end
      end
    end
end
