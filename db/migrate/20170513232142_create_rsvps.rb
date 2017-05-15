class CreateRsvps < ActiveRecord::Migration[5.0]
  def change
    create_table :rsvps do |t|
      t.string :url
      t.date :date
      t.string :name
      t.string :phone
      t.timestamps
    end
  end
end
