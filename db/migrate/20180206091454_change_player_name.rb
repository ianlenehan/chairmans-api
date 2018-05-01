class ChangePlayerName < ActiveRecord::Migration
  def change
    rename_column :rounds, :player, :player_id
  end
end
