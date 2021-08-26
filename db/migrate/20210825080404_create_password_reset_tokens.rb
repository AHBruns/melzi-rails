class CreatePasswordResetTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :password_reset_tokens do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
