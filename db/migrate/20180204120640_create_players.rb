class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.text :full_name
      t.text :nick_name
      t.text :avatar_url
      t.boolean :hat_holder
      t.boolean :immunity
      t.text :handicap
      t.text :golflink_number
      t.timestamps null: false
    end
  end
end
