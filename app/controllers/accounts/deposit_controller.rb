module Accounts
  class DepositController < ApplicationController
    def new
      @account = Account.new
    end
    
    def update
      begin
        Accounts::Deposit.call(current_system_user.account, _params[:balance])
        
        flash[:success] = "Deposito realizado com sucesso!"
        
        redirect_to accounts_new_deposit_path
      rescue => exception
        flash[:danger] = exception.message
  
        redirect_to accounts_new_deposit_path 
      end
    end

    private

    def _params
      params.required(:account).permit(:balance)
    end
  end
end
