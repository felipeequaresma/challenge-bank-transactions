class HomeController < ApplicationController
  def index
    @current_system_user = current_system_user
  end
end
