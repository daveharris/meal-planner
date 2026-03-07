class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:update, :destroy]

  def index
    @ingredients_by_location = Ingredient
      .order(:location)
      .order(Arel.sql("COALESCE(expires_on, '9999-12-31') ASC"))
      .group_by(&:location)
      .tap { it.default = [] } # Handle missing groups
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      render :create # .turbo_stream.erb
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient, status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @ingredient.destroy!
    redirect_to ingredients_path, status: :see_other
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params.expect(:id))
  end

  def ingredient_params
    params.expect(ingredient: [:name, :quantity, :location, :expires_on])
  end
end
