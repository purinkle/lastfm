# frozen_string_literal: true

module Lastfm
  class Chart
    def initialize(from:, to:, username:)
      @from = from
      @to = to
      @username = username
    end

    def get
      recent_tracks.to_chart
    end

    private

    attr_reader :from, :to, :username

    def adapted_response
      @_adapted_response ||= connection.recent_tracks(from..to)
    end

    def connection
      @connection ||= Connection.new(username)
    end

    def first_page
      adapted_response
    end

    def other_pages
      (2..total_pages).map do |page_number|
        connection.recent_tracks(from..to, page_number)
      end
    end

    def pages
      [first_page, other_pages].flatten
    end

    def recent_tracks
      RecentTracks.new(pages)
    end

    def total_pages
      first_page.total_pages
    end
  end
end
