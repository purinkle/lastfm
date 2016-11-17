# frozen_string_literal: true
module Lastfm
  class Query
    attr_reader :user

    def initialize(from:, to:, user:)
      @from = from
      @to = to
      @user = user
    end

    def from
      @from.to_i
    end

    def to
      @to.to_i
    end
  end
end
