class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.timestamps :date
      t.integer :winner
      t.integer :loser
      t.timestamps null: false
    end
  end
end
