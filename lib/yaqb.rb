# frozen_string_literal: true

module Yaqb; end

begin; require 'rails'; rescue LoadError; end

require 'yaqb/config'
require 'yaqb/errors/query_builder_error'
require 'yaqb/presenter'
require 'yaqb/base'
require 'yaqb/hooks'
