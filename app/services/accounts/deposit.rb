module Accounts
  class Deposit < ApplicationService

    def initialize(account, balance)
      @account = account
      @balance = balance.to_f
    end

    def call
      _deposit!
    end

    private

    attr_reader :account, :balance

    def _total_balance
      (account.balance + balance)
    end

    def _deposit!
      account.update!(balance: _total_balance)
    end
  end
end
