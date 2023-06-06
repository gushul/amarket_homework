# frozen_string_literal: true

class CreatePerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :performances do |t|
      t.date :start_date
      t.date :end_date
      t.string :title

      t.timestamps
    end
    add_index :performances, %i[start_date end_date], unique: true
  end
end
