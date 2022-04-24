module Accounts
  class BalanceController < ApplicationController
    def show
      @balance = current_system_user.account.balance
    end
  end
end
