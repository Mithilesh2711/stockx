class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true

    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
                    publishable_token: 'pk_4c30c301c74c4cb4a230976a99144feb',
                    secret_token: 'sk_d760613907254caf9fcf3cbf923f701d',
                    endpoint: 'https://cloud.iexapis.com/v1'
                )

        begin
            return new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.quote(ticker_symbol).latest_price)
        rescue => exception
            return nil
        end
    end

    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
end
