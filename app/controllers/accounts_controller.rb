class AccountsController < ApplicationController
  def index; end
  def new
    @account = Account.new
  end
end
