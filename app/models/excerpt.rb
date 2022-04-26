class Excerpt < ApplicationRecord
  belongs_to :account

  enum type_transaction: { deposit: 'deposit', withdrawal: 'withdrawal', transfer: 'transfer' }
  

  scope :search_by_range_date, ->(params){ where(created_at: params[:start_at].to_date.beginning_of_day..params[:end_at].to_date.end_of_day) }
end
