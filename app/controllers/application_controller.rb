class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_url, alert: "Not found."
  end
end
