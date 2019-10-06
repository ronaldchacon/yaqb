# frozen_string_literal: true

require 'yaqb/query_builders/paginate'
require 'yaqb/query_builders/sort'
require 'yaqb/query_builders/filter'

module Yaqb
  module QueryBuilders
    class QueryOrchestrator
      def initialize(scope, params, request, response)
        @scope = scope
        @params = params
        @request = request
        @response = response
      end

      def call
        @scope = paginate
        @scope
      end

      private

      def paginate
        current_url = @request.base_url + @request.path
        paginator = Paginate.new(@scope, @request.query_parameters, current_url)
        @response.headers['Link'] = paginator.links
        paginator.paginate
      end
    end
  end
end
