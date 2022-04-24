module Accounts
  class TaxCalculator < ApplicationService
    def initialize(balance)
      @balance = balance
    end

    def call
      _tax_calculate!
    end

    private

    attr_reader :balance
    
    def _tax_calculate!
      [_tax_above_thousand, _tax_weekend_or_out_of_hours].compact.sum
    end

    def _tax_above_thousand
      return 10.to_f if (balance > 1000.to_f)
    end

    def _tax_weekend_or_out_of_hours
      return 5.to_f if Date.current.on_weekday? && 
        (Time.now.strftime("%H:%M:%S") > "09:00:00" && 
          Time.now.strftime("%H:%M:%S") < "18:00:00")

      7.to_f
    end
  end
end
