# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    module Paginators
      module PagyHelper
        private

        def paginate!(scope)
          @pagy = Pagy.new(count: scope.count(:all), page: @page, items: @per)
          scope.offset(@pagy.offset).limit(@pagy.items)
        end

        def show_first_link?
          @pagy.pages > 1 && !!@pagy.prev
        end

        def show_previous_link?
          !!@pagy.prev
        end

        def show_next_link?
          !!@pagy.next
        end

        def show_last_link?
          @pagy.pages > 1 && !!@pagy.next
        end

        def pages
          @pages ||= {}.tap do |h|
            h[:first] = 1 if show_first_link?
            h[:prev] = @pagy.prev if show_previous_link?
            h[:next] = @pagy.next if show_next_link?
            h[:last] = @pagy.pages if show_last_link?
          end
        end

        def default_per_page
          Pagy::VARS[:items]
        end
      end
    end
  end
end
