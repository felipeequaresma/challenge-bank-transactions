module Accounts
  class WithdrawalController < ApplicationController
    before_action :authenticate_user!
    
    after_action -> { send_notify('withdrawal', _notify_params) }, only: :update

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

    def _notify_params
      {
        account: current_system_user&.account,
        balance: _params[:balance],
        type_transaction: 'deposit'
      }
    end
  end
end
