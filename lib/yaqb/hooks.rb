# frozen_string_literal: true

begin; require 'kaminari'; rescue LoadError; end
begin; require 'will_paginate'; rescue LoadError; end

unless defined?(Kaminari) || defined?(WillPaginate::CollectionMethods)
  Kernel.warn <<~HEREDOC
    Warning: Yaqb relies on Kaminari or WillPaginate. Please
    install dependency by adding one of the following to your Gemfile:
    gem 'kaminari'
    gem 'will_paginate'\n
  HEREDOC
end

begin
  if defined?(Kaminari)
    require 'yaqb/query_builders/paginators/kaminari_helper'
    Yaqb::QueryBuilders::Paginate.send(:include, Yaqb::QueryBuilders::Paginators::KaminariHelper)
  elsif defined?(WillPaginate::CollectionMethods)
    require 'yaqb/query_builders/paginators/will_paginate_helper'
    Yaqb::QueryBuilders::Paginate.send(:include, Yaqb::QueryBuilders::Paginators::WillPaginateHelper)
  else
    raise LoadError
  end
rescue LoadError
  exit
end
