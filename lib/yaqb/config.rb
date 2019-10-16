# frozen_string_literal: true

module Yaqb
  class << self
    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    def paginator
      instance_variable_defined?(:@paginator) ? @paginator : set_paginator
    end

    def paginator=(paginator)
      case paginator.to_sym
      when :kaminari
        @paginator = :kaminari
      when :will_paginate
        @paginator = :will_paginate
      else
        raise StandardError, paginator_error_message(paginator)
      end
    end

    private

    def set_paginator
      @paginator = if defined?(Kaminari)
        :kaminari
      elsif defined?(WillPaginate::CollectionMethods)
        :will_paginate
      end
    end

    def paginator_error_message(paginator)
      <<~HEREDOC.chomp
        Invalid Paginator: (#{paginator}). Currently supported paginators are: [Kaminari, WillPaginate].
      HEREDOC
    end
  end
end
