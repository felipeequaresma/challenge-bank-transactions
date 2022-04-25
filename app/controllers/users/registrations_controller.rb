class Users::RegistrationsController < Devise::RegistrationsController
  def create
    ActiveRecord::Base.transaction do
      super do |resource|
        resource.build_account
        
        _stored_cpf_in_cookie(resource) if resource.save!
      end
    end
  end

  protected

  def sign_up(resource_name, resource)
    true
  end

  private

  def _stored_cpf_in_cookie(resource)
    cookies.permanent[:cpf] = resource.cpf
  end
end
