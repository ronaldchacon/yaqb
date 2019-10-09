# frozen_string_literal: true

require 'yaqb/query_builders/query_orchestrator'

module Yaqb
  module QueryBuilder
    private

    def orchestrate(scope, options = {})
      QueryBuilders::QueryOrchestrator.new(scope, params, request, response, options).call
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
