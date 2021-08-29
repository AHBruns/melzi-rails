class RemoveEmailVerificationTokensTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :email_verification_tokens
  end
end
