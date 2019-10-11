# frozen_string_literal: true

require 'yaqb/version'
require 'yaqb/hooks'
require 'yaqb/configuration'
require 'yaqb/errors/query_builder_error'

module Yaqb
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
    alias config configuration
  end
end
