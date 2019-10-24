# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    class Sort
      DIRECTIONS = %w[asc desc].freeze

      def initialize(scope, params, presenter)
        @scope = scope
        @presenter = presenter
        @column = params[:sort]
        @direction = params[:dir]
      end

      def sort
        return @scope unless @column && @direction

        validate!('sort', @column) unless @presenter.sort_attributes.include?(@column)
        validate!('dir', @direction) unless DIRECTIONS.include?(@direction)

        @scope.order(Arel.sql("#{@column} #{@direction}"))
      end

      private

      def validate!(name, value)
        columns = @presenter.sort_attributes.join(', ')
        raise Errors::QueryBuilderError.new("#{name}=#{value}"),
              "Invalid sorting params. sort: (#{columns}), 'dir': asc, desc"
      end
    end
  end
end
