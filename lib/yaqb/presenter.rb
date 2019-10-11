# frozen_string_literal: true

module Yaqb
  class Presenter
    @sort_attributes = []
    @filter_attributes = []

    class << self
      attr_accessor :sort_attributes, :filter_attributes

      def sort_by(*args)
        @sort_attributes = args.map(&:to_s)
      end

      def filter_by(*args)
        @filter_attributes = args.map(&:to_s)
      end
    end
  end
end
