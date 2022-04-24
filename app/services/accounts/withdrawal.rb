module Accounts
  class Withdrawal < ApplicationService
    def initialize(account, balance)
      @account = account
      @balance = balance.to_f
    end

    def call
      _withdrawal!
    end

    def validate!
      _balance_available?
    end

    private

    attr_reader :account, :balance

    def _total
      total = account.balance - balance

      return 0.0 if total.negative?

      total
    end

    def _withdrawal!
      account.update!(balance: _total)
    end

    def _balance_available?
      account.balance >= balance &&
      !account.balance.zero?
    end
  end
end
