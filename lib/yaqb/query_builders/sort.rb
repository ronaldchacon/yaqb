# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    class Sort
      DIRECTIONS = %w[asc desc].freeze

      def initialize(scope, params)
        @scope = scope
        @column = params[:sort]
        @direction = params[:dir]
      end

      def sort
        return @scope unless @column && @direction

        @scope.order(Arel.sql("#{@column} #{@direction}"))
      end
    end
  end
end
