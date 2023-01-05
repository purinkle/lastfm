# frozen_string_literal: true

require "dotenv"
require "faraday"
require "faraday_middleware"

require "lastfm/artist"
require "lastfm/chart"
require "lastfm/entry"
require "lastfm/http_client"
require "lastfm/recent_track_list"
require "lastfm/recent_tracks"
require "lastfm/track"
require "lastfm/tracks"
require "lastfm/user"
require "lastfm/version"

Dotenv.load
