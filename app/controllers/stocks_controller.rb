class StocksController < ApplicationController


  def search
    #this will check to make sure the params stock is present and not an empty string to deal with that error
    Rails.logger.debug "params: #{params[:stock]}"
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      Rails.logger.debug "stock model #{@stock}"
        #render json: @stock
        if @stock
          #we need to respond to the request for the AJAX call
          #this will also need a _result.js.erb file
          respond_to do |format|
            format.js { render partial: 'users/result'}
          end
        else
          respond_to do |format|
            flash.now[:alert] = "Please Enter A Valid Symbol To Search"
            format.js { render partial: 'users/result'}
          end
        end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result'}
      end
    end
  end
end
