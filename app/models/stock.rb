class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(

      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1')
      #return client.price(ticker_symbol)


      begin
        #if we were doing this outside of the class we would do Stock.new but since it is inside we can just do new
        new(ticker: ticker_symbol.upcase!, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
      rescue => exception
        return nil
      end
  end

  def self.check_db(ticker_symbol)
    #we are checking the db to see if the stock already exists
    Stock.where(ticker: ticker_symbol).first
  end


end
