module Accounts
  class TransferController < ApplicationController
    before_action :authenticate_user!

    def new
      @account = Account.new
    end
    
    def update
      begin
        Accounts::Transfer.call(_params)

        redirect_to root_path, notice: "deu tudo certo!" if sign_out(current_user)
      rescue => exception
        redirect_to accounts_new_transfer_path, notice: exception.message
      end
    end

    private

    def _params
      params.required(:account).permit(:balance, :cpf).merge(user: current_user)
    end
  end
end
