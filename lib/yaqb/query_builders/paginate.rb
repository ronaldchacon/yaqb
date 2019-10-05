# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    class Paginate
      def initialize(scope, query_params, url)
        @scope = scope
        @query_params = query_params
        @url = url
      end

      def paginate
      end

      def links
      end

      private

      def page
        @query_params.fetch(:page, 1)
      end

      def per_page
        @query_params.fetch(:per, Kaminari.config.default_per_page)
      end
    end
  end
end
