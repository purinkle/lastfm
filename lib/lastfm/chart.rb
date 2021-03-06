# frozen_string_literal: true
module Lastfm
  class Chart
    def initialize(from:, to:, user:)
      @from = from
      @to = to
      @user = user
    end

    def get
      recent_tracks.to_chart
    end

    private

    attr_reader :from, :to, :user

    def adapted_response
      @_adapted_response ||= connection.get
    end

    def adapter
      Adapter
    end

    def connection(page_number = 1)
      Connection.new(adapter: adapter, page_number: page_number, query: query)
    end

    def first_page
      adapted_response
    end

    def other_pages
      (2..total_pages).map { |page_number| connection(page_number).get }
    end

    def pages
      [first_page, other_pages].flatten
    end

    def query
      @_query ||= Query.new(from: from, to: to, user: user)
    end

    def recent_tracks
      RecentTracks.new(pages)
    end

    def total_pages
      first_page.total_pages
    end
  end
end
