module Accounts
  class ExcerptController < ApplicationController
    def index
      @excerpt = _excerpt_by_date!
    end

    def new; end

    private

    def _excerpt_by_date!
      Excerpt.search_by_range_date({start_at: params[:start_at], end_at: params[:end_at]}) 
    end
  end
end
