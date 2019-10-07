# frozen_string_literal: true

begin; require 'kaminari'; rescue LoadError; end

unless defined?(Kaminari)
  Kernel.warn <<~HEREDOC.chomp
    Warning: Yaqb relies on Kaminari. Please
    install dependency by adding the following to your Gemfile:
    gem 'kaminari'
  HEREDOC
end


if defined?(ActionController::Base)
  require 'yaqb/query_builder'
  ActionController::Base.send(:include, Yaqb::QueryBuilder)
  ActionController::Base.rescue_from Yaqb::Errors::QueryBuilderError, with: :builder_error
end

if defined?(ActionController::API)
  require 'yaqb/query_builder'
  ActionController::API.send(:include, Yaqb::QueryBuilder)
  ActionController::API.rescue_from Yaqb::Errors::QueryBuilderError, with: :builder_error
end
