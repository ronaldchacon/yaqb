# frozen_string_literal: true

require 'yaqb/query_builders/query_orchestrator'

module Yaqb
  module Base
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        rescue_from Yaqb::Errors::QueryBuilderError, with: :builder_error
      end
    end

    module ClassMethods; end

    private

    def orchestrate(scope, presenter)
      QueryBuilders::QueryOrchestrator.new(scope, params, request, response, presenter).call
    end

    def builder_error(error)
      render status: 400, json: {
        error: {
          message: error.message,
          invalid_params: error.invalid_params
        }
      }
    end
  end
end
