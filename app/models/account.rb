class Account < ApplicationRecord
  include Discard::Model

  default_scope -> { kept }
  
  has_one :user
end
