class PlansController < ApplicationController
  # GET /plans
  def index
    @start = Date.current.beginning_of_week(:sunday)
    week_range = @start..(@start + 6.days)

    @plans = Plan.where(date: week_range)
      .order(:date)
      .load

    if @plans.empty?
      @plans = week_range.map do |date|
        Plan.create!(date:)
      end
    end
  end

  # PATCH/PUT /plans/1
  def update
    @plan = Plan.find(params.expect(:id))

    if @plan.update(plan_params)
      respond_to do |format|
        format.turbo_stream { head :ok }
        format.html { redirect_to plans_path, notice: "Plan updated successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  private

  def plan_params
    params.expect(plan: [:day, :meal, :shared])
  end
end
