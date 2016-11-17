# frozen_string_literal: true
require "dotenv"
require "faraday"
require "faraday_middleware"

require "lastfm/adapter"
require "lastfm/artist"
require "lastfm/chart"
require "lastfm/connection"
require "lastfm/entry"
require "lastfm/query"
require "lastfm/recent_tracks"
require "lastfm/track"
require "lastfm/tracks"
require "lastfm/version"

Dotenv.load
