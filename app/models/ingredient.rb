class Ingredient < ApplicationRecord
  enum :location, {
    freezer: 0,
    fridge: 1,
    pantry: 2
  }

  def discrete?
    quantity.match?(/\A\d+\z/)
  end
end
