class AddBuyerName < ActiveRecord::Migration[6.1]
  def change
    add_column :buyers, :name, :string
  end
end
