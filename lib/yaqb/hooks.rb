# frozen_string_literal: true

begin; require 'kaminari'; rescue LoadError; end

unless defined?(Kaminari)
  Kernel.warn <<~HEREDOC
    Warning: Yaqb relies on Kaminari. Please
    install dependency by adding the following to your Gemfile:
    gem 'kaminari'
  HEREDOC
end
