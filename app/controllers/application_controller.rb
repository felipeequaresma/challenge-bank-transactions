class ApplicationController < ActionController::Base

  protected

  def current_system_user
    return unless cookies[:cpf].present?

    User.find_by(cpf: cookies[:cpf])
  end
end
