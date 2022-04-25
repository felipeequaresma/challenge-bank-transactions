module Accounts
  class AccountController < ApplicationController
    def index
      @accounts = Account.all
    end

    def switch
      cookies.permanent[:cpf] = params[:cpf]

      redirect_to root_path
    end

    def destroy
      @account.discard
    end

    private 
  end
end
