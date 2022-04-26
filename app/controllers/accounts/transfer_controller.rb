module Accounts
  class TransferController < ApplicationController
    before_action :authenticate_user!

    after_action -> { send_notify('transfer', _notify_params) }, only: :update

    def new
      @account = Account.new
    end
    
    def update
      begin
        Accounts::Transfer.call(_params)

        flash[:success] = "Saque realizado com sucesso!"

        redirect_to root_path if sign_out(current_user)
      rescue => exception
        flash[:danger] = exception.message

        redirect_to accounts_new_transfer_path
      end
    end

    private

    def _params
      params.required(:account).permit(:balance, :cpf).merge(user: current_user)
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
