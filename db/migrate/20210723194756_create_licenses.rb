class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :work, null: false, foreign_key: true
      t.belongs_to :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
