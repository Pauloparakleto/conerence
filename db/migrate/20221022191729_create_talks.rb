class CreateTalks < ActiveRecord::Migration[6.1]
  def change
    create_table :talks do |t|
      t.string :name
      t.time :initial_time

      t.timestamps
    end
  end
end
