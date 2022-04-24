module Accounts
  class WithdrawalController < ApplicationController
    before_action :authenticate_user!

    def new
      @account = Account.new
    end
    
    def update
      begin
        Accounts::Withdrawal.call(current_user.account, _params[:balance])

        redirect_to root_path, notice: "deu tudo certo!" if sign_out(current_user) 
      rescue => exception
        redirect_to accounts_new_withdrawal_path, notice: exception.message
      end
    end

    private

    def _params
      params.required(:account).permit(:balance)
    end
  end
end
