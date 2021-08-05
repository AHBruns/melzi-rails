class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :salted_password_hash, null: false
      t.string :salt, null: false

      t.timestamps
    end

    create_table :buyers do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :submissions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :buyer, null: false, foreign_key: true
      t.belongs_to :work, null: false, foreign_key: true

      t.integer :status, null: false # open, accepted, rejected

      t.timestamps
    end

    create_table :works do |t|
      t.belongs_to :user, foreign_key: true

      t.integer :stage, null: false # draft, written
      t.string :title, null: false

      t.timestamps
    end
  end
end
