class MealsController < ApplicationController
  before_action :set_meal, only: [:update, :destroy]

  def index
    @meals_by_location = Meal
      .order(:location)
      .order(Arel.sql("COALESCE(expires_on, '9999-12-31') ASC"))
      .group_by(&:location)
      .tap { it.default = [] } # Handle missing groups
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      render :create # .turbo_stream.erb
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @meal.update(meal_params)
      redirect_to @meal, status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @meal.destroy!
    redirect_to meals_path status: :see_other
  end

  private

  def set_meal
    @meal = Meal.find(params.expect(:id))
  end

  def meal_params
    params.expect(meal: [:name, :quantity, :location, :expires_on])
  end
end
