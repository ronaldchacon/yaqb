# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :recipes, force: true do |t|
    t.string :title
    t.timestamps
  end
end
