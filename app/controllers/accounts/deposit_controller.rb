module Accounts
  class DepositController < ApplicationController
    def new
      @account = Account.new
    end
    
    def update
      begin
        Accounts::Deposit.call(current_system_user.account, _params[:balance])
 
        redirect_to accounts_new_deposit_path, notice: "deu tudo certo!"
      rescue => exception
        redirect_to accounts_new_deposit_path, notice: exception.message
      end
    end

    private

    def _params
      params.required(:account).permit(:balance)
    end
  end
end
