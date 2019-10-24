# frozen_string_literal: true

require 'yaqb/query_builders/paginate'
require 'yaqb/query_builders/sort'
require 'yaqb/query_builders/filter'

module Yaqb
  module QueryBuilders
    class QueryOrchestrator
      attr_reader :scope, :links

      def initialize(scope, params, request, response, presenter)
        @scope = scope
        @params = params
        @request = request
        @response = response
        @presenter = presenter
      end

      def call
        @scope = filter
        @scope = sort
        @scope = paginate

        self
      end

      private

      def paginate
        current_url = @request.base_url + @request.path
        paginator = Paginate.new(@scope, @params, current_url)
        @response.headers['Link'] = @links = paginator.links
        paginator.paginate
      end

      def sort
        Sort.new(@scope, @params, @presenter).sort
      end

      def filter
        Filter.new(@scope, @params, @presenter).filter
      end
    end
  end
end
