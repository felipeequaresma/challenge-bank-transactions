module Accounts
  class TransfersService < ApplicationService
    attr_reader :account_to_recive_id, 
                :account_to_send_id, 
                :balance, 
                :password
    
    def initialize(params)
      @account_to_recive_id = params[:account_recive_id]
      @account_to_send_id = params[:id]
      @password = params[:password]
      @balance = params[:balance].to_f
    end

    def call
     return "asdfasdf" unless _account_to_send.user.valid_password?(password)

      _add_balance_account if _remove_balance_account

      _account_balance_negative if _account_to_send.balance.negative?
    end

    private

    def _account_by_id
      Account.find(account_to_send_id, account_to_recive_id)
    end

    def _account_to_recive
      _account_by_id.second
    end

    def _account_to_send
      _account_by_id.first
    end

    def _remove_balance_account
      _account_to_send.update!(balance: (_account_to_send.balance - balance))
    end

    def _add_balance_account
      _account_to_recive.update!(balance: _balance_total)
    end

    def _tax
      [ _tax_above_thousand, _tax_weekend_or_out_of_hours].compact.sum
    end

    def _tax_above_thousand
      return 10.to_f if (balance > 1000.to_f)
    end

    def _tax_weekend_or_out_of_hours
      return 5.to_f if Date.current.on_weekday? && 
        (Time.now.strftime("%H:%M:%S") > "09:00:00" && 
          Time.now.strftime("%H:%M:%S") < "18:00:00")

      7.to_f
    end

    def _balance_total
      (_account_to_recive.balance + balance) - _tax
    end

    def _account_balance_negative
      _account_to_send.update!(balance: 0.0)
    end
  end
end