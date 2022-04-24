class Users::RegistrationsController < Devise::RegistrationsController
  def create
    ActiveRecord::Base.transaction do
      super do |resource|
        resource.build_account
        resource.save!
      end
    end
  end

  protected

  def sign_up(resource_name, resource)
    true
  end

  def after_sign_in_path_for(resource)
    _stored_cpf_in_cookie(resource)
  end

  private

  def _stored_cpf_in_cookie(resource)
    cookies.permanent[:cpf] = resource.cpf
  end
end
