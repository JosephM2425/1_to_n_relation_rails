class CreateApartments < ActiveRecord::Migration[6.1]
  def change
    create_table :apartments do |t|
      t.integer :number, default: 101
      t.belongs_to :building, null: false, foreign_key: true

      t.timestamps
    end
  end
end
