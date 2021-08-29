class CreateEmailTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :email_tokens do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :value, null: false, unique: true
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
