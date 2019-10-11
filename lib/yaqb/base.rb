# frozen_string_literal: true

require 'yaqb/query_builders/query_orchestrator'

module Yaqb
  module Base
    private

    def orchestrate(scope, presenter)
      QueryBuilders::QueryOrchestrator.new(scope, params, request, response, presenter).call
    end
  end
end
