class ApplicationController < ActionController::Base
  before_action :basic if Rails.env == "production"

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['TASK_MANAGEMENT_NAME'] && password == ENV['TASK_MANAGEMENT_PASSWORD']
    end
  end
end
