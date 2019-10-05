# frozen_string_literal: true

module Yaqb
  class Railtie < Rails::Railtie
    config.after_initialize do
      require 'yaqb/hooks'
    end
  end
end
