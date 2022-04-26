module Accounts
  class ExcerptController < ApplicationController
    def index
      @excerpt = _excerpt_by_date!
    end

    def new; end

    private

    def _excerpt_by_date!
      current_system_user&.account&.excerpt&.search_by_range_date({start_at: params[:start_at], end_at: params[:end_at]}) unless params[:start_at].nil? || params[:end_at].nil?
    end
  end
end
