# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    module Paginators
      module KaminariHelper
        private

        def paginate!(scope)
          scope.page(@page).per(@per)
        end

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

        def default_per_page
          Kaminari.config.default_per_page
        end
      end
    end
  end
end
