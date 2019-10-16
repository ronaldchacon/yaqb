# frozen_string_literal: true

begin; require 'kaminari'; rescue LoadError; end
begin; require 'will_paginate'; rescue LoadError; end
begin; require 'pagy'; rescue LoadError; end

unless defined?(Kaminari) || defined?(WillPaginate::CollectionMethods) || defined?(Pagy)
  Kernel.warn <<~HEREDOC
    Warning: Yaqb relies on Kaminari or WillPaginate or Pagy. Please
    install dependency by adding one of the following to your Gemfile:
    gem 'kaminari'
    gem 'will_paginate'
    gem 'pagy'\n
  HEREDOC
end

begin
  if defined?(Kaminari)
    require 'yaqb/query_builders/paginators/kaminari_helper'
    Yaqb::QueryBuilders::Paginate.send(:include, Yaqb::QueryBuilders::Paginators::KaminariHelper)
  elsif defined?(WillPaginate::CollectionMethods)
    require 'yaqb/query_builders/paginators/will_paginate_helper'
    Yaqb::QueryBuilders::Paginate.send(:include, Yaqb::QueryBuilders::Paginators::WillPaginateHelper)
  elsif defined?(Pagy)
    require 'yaqb/query_builders/paginators/pagy_helper'
    Yaqb::QueryBuilders::Paginate.send(:include, Yaqb::QueryBuilders::Paginators::PagyHelper)
  else
    raise LoadError
  end
rescue LoadError
  exit
end
