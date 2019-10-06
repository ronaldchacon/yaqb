# frozen_string_literal: true

module Yaqb
  class Configuration
    def paginator
      @paginator || set_paginator
    end

    def paginator=(paginator)
      case paginator.to_sym
      when :kaminari
        @paginator = :kaminari
      else
        raise StandardError, paginator_error_message(paginator)
      end
    end

    private

    def set_paginator
      @paginator = :kaminari if defined?(Kaminari)
    end

    def paginator_error_message(paginator)
      <<~HEREDOC.chomp
        Invalid Paginator: (#{paginator}). Currently supported paginators are: [Kaminari].
      HEREDOC
    end
  end
end
