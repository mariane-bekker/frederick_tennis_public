class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :server_name
      t.string :receiver_name
      t.integer :server_score
      t.integer :receiver_score

      t.timestamps
    end
  end
end
