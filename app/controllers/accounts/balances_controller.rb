class BalancesController < ApplicationController
  def index 
    current_user.account.balance
  end
end
