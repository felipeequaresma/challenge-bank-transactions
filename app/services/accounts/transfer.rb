module Accounts
  class Transfer < ApplicationService
    attr_reader :errors

    def initialize(params)
      @balance = params[:balance].to_f
      @user = params[:user]
      @cpf = params[:cpf]
    end

    def call
      return raise "Você não tem saldo suficiente para realizar essa transferencia" unless _withdrawal?

      _deposit!
    end

    private

    attr_reader :cpf, :user, :balance

    def _tax
      Accounts::TaxCalculator.call(balance)
    end

    def _total
      balance - _tax
    end

    def _withdrawal?
      Accounts::Withdrawal.call(_user_sender_account, balance) if _balance_available?
    end

    def _balance_available?
      Accounts::Withdrawal.new(_user_sender_account, balance).validate!
    end

    def _deposit!
      Accounts::Deposit.call(_user_receiver_account, _total)
    end

    def _user_receiver_account
      User.find_by(cpf: cpf).account
    end

    def _user_sender_account
      user.account
    end
  end
end
