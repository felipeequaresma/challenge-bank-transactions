module Accounts
  class TransfersController < ApplicationController
    def update
      Accounts::TransfersService.call(_params)
    end

    private

    def _params
      params.permit(:id, :balance, :account_recive_id, :password)
    end
  end
end
