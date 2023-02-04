class Stock < ApplicationRecord
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
end
