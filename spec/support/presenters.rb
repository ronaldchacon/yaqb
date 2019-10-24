# frozen_string_literal: true

class RecipePresenter < Yaqb::Presenter
  sort_by :id, :title, :created_at, :updated_at

  filter_by :id, :title
end
