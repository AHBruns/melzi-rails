class AddEmailVerificationField < ActiveRecord::Migration[6.1]
  def change
    add_column(:users, :email_verified, :boolean, null: false, default: false)
  end
end
