class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.timestamps :date
      t.integer :score
      t.integer :player
      t.timestamps null: false
    end
  end
end
