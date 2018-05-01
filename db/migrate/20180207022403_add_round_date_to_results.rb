class AddRoundDateToResults < ActiveRecord::Migration
  def change
    add_column :results, :round_date, :date
  end
end
