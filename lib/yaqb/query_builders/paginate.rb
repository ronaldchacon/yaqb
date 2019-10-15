# frozen_string_literal: true

require "yaqb/query_builders/paginators/#{Yaqb.config.paginator}_helper"

module Yaqb
  module QueryBuilders
    class Paginate
      include "Yaqb::QueryBuilders::Paginators::#{Yaqb.config.paginator.to_s.classify}Helper".constantize

      def initialize(scope, query_params, url)
        @query_params = query_params
        @page = validate_param!(:page, 1)
        @per = validate_param!(:per, default_per_page)
        @scope = paginate!(scope)
        @url = url
      end

      def paginate
        @scope
      end

      def links
        @links ||= pages.each_with_object({}) do |(k, v), hash|
          query_params = @query_params.merge('page' => v, 'per' => @per).to_param
          hash[k] = "#{@url}?#{query_params}"
        end
      end

      private

      def validate_param!(name, default)
        return default unless @query_params[name]

        unless @query_params[name] =~ /\A\d+\z/
          raise Errors::QueryBuilderError.new("#{name}=#{@query_params[name]}"),
          'Invalid pagination params. Only numbers are supported for "page" and "per"'
        end

        @query_params[name]
      end
    end
  end
end
