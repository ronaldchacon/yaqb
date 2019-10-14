# frozen_string_literal: true

module Yaqb
  module QueryBuilders
    module Paginators
      module KaminariHelper
        private

        def paginate!(scope)
          scope.page(@page).per(@per)
        end
      end
    end
  end
end
