class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :name
      t.string :email
      t.string :number
      t.text :message
      t.datetime :appointment

      t.timestamps
    end
  end
end
