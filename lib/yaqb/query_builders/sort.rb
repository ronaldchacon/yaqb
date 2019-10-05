# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    class Sort
      def initialize(scope, query_params)
        @scope = scope
        @query_params = query_params
      end

      def sort
      end
    end
  end
end
