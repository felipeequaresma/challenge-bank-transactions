class Account < ApplicationRecord
  include Discard::Model

  default_scope -> { kept }
  
  has_one :user
  has_many :excerpt
end
