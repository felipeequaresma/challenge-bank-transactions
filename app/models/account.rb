class Account < ApplicationRecord
  include Discard::Model
  
  has_one :user
end
