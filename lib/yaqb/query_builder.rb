# frozen_string_literal: true

require 'yaqb/query_builders/query_orchestrator'

module Yaqb
  module QueryBuilder
    private

    def orchestrate(scope)
      QueryBuilders::QueryOrchestrator.new(scope, params, request, response).call
    end
  end
end
