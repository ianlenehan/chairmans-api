class AddFieldsToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :round_date, :date
  end
end
