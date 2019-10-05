# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    class Filter
      def initialize(scope, query_params)
        @scope = scope
        @query_params = query_params
      end

      def filter
      end
    end
  end
end
