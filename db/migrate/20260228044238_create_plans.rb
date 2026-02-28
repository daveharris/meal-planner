class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.date :date
      t.string :meal
      t.boolean :shared

      t.timestamps
    end
  end
end
