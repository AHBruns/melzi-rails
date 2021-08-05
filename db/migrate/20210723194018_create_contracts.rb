class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :buyer, null: false, foreign_key: true
      t.belongs_to :submission, null: true, foreign_key: true
      t.string :notes

      t.timestamps
    end
  end
end
