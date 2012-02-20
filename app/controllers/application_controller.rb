class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :http_authenticate

  protected
  def http_authenticate
    if Rails.env.downcase == "production"
      authenticate_or_request_with_http_basic do |username, password|
        username == "john" && password == "vmartlogistics"
      end
    end
  end
end
