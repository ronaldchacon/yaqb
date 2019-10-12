# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    class Paginate
      def initialize(scope, query_params, url)
        @query_params = query_params
        @page = validate_param!(:page, 1)
        @per = validate_param!(:per, Kaminari.config.default_per_page)
        @scope = scope.page(@page).per(@per)
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

      def show_first_link?
        @scope.total_pages > 1 && !@scope.first_page?
      end

      def show_previous_link?
        !@scope.first_page?
      end

      def show_next_link?
        !@scope.last_page?
      end

      def show_last_link?
        @scope.total_pages > 1 && !@scope.last_page?
      end

      def pages
        @pages ||= {}.tap do |h|
          h[:first] = 1 if show_first_link?
          h[:prev] = @scope.current_page - 1 if show_previous_link?
          h[:next] = @scope.current_page + 1 if show_next_link?
          h[:last] = @scope.total_pages if show_last_link?
        end
      end

      def validate_param!(name, default)
        return default unless @query_params[name]

        unless @query_params[name] =~ /\A\d+\z/
          raise Errors::QueryBuilderError.new("#{name}=#{@query_params[name]}"),
          'Invalid Pagination params. Only numbers are supported for "page" and "per"'
        end

        @query_params[name]
      end
    end
  end
end
