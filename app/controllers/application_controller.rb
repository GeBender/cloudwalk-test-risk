class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    case request.format
    when Mime[:xml], Mime[:atom]
      if user = authenticate_with_http_token { |t, o| @account.users.authenticate(t, o) }
        @current_user = user
      else
        request_http_token_authentication
      end
    else
      if session_authenticated?
        @current_user = @account.users.find(session[:authenticated][:user_id])
      else
        redirect_to(login_url) and return false
      end
    end
  end
end
