class ApplicationController < ActionController::Base
  include Concerns::NotificationPublisher

  protected

  def current_system_user
    return unless cookies[:cpf].present?

    User.find_by(cpf: cookies[:cpf])
  end
end
