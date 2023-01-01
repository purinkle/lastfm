# frozen_string_literal: true

module Lastfm
  class Query
    attr_reader :username

    def initialize(username:)
      @username = username
    end
  end
end
