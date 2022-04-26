module Accounts
  class CreateExcerpt < ApplicationService

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def call
      Excerpt.create!(payload)
    end
  end
end
