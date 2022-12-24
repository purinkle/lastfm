# frozen_string_literal: true

module Lastfm
  class Query
    attr_reader :user

    def initialize(user:)
      @user = user
    end
  end
end
