# frozen_string_literal: true

require 'yaqb/version'
require 'yaqb/configuration'
require 'yaqb/railtie'

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
