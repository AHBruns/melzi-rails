class RemovePasswordResetTokensTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :password_reset_tokens
  end
end
