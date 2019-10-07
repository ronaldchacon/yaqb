# frozen_string_literal: true

require 'rails/railtie'

module Yaqb
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      require 'yaqb/hooks'
    end
  end
end
