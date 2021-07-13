class UserStocksController < ApplicationController

  def create
    #byebug
    #calling method from stock model
    stock = Stock.check_db(params[:ticker])
    #checking if stock object is blank or not
    if stock.blank?
      #if blank then it will do a new lookup by calling our api method and then saving it to the stock model
      Rails.logger.debug "params #{params[:ticker]}"
      stock = Stock.new_lookup(params[:ticker])
      Rails.logger.debug "STOCK! #{params[:ticker]}"
      #stock.valid?
      #Rails.logger.debug "valid? #{stock.errors.full_messages}"
      stock = Stock.new(ticker: params[:ticker], name: stock.name, last_price: stock.last_price )
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} Was successfully added to your Portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully removed from Portfolio"
    redirect_to my_portfolio_path
  end

end
