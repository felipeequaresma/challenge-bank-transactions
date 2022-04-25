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
      Account.find(params[:id]).discard

      cookies.delete :cpf
      session.clear
      
      redirect_to accounts_account_index_path
    end
  end
end
