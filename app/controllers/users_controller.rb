class UsersController < ApplicationController
  def my_portfolio
    #grabbing the user and seeing the stocks they are tracking
    @tracked_stocks = current_user.stocks
  end
end
