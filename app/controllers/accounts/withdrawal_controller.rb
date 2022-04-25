module Accounts
  class WithdrawalController < ApplicationController
    before_action :authenticate_user!

    def new
      @account = Account.new
    end
    
    def update
      begin
        Accounts::Withdrawal.call(current_user.account, _params[:balance])
        
        flash[:success] = "Saque realizado com sucesso!"

        redirect_to root_path if sign_out(current_user)
      rescue => exception
        flash[:danger] = exception.message

        redirect_to accounts_new_withdrawal_path
      end
    end

    private

    def _params
      params.required(:account).permit(:balance)
    end
  end
end
