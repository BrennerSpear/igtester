class AddOmniauthToShoppers < ActiveRecord::Migration
  def change
    add_column :shoppers, :provider, :string
    add_index :shoppers, :provider
    add_column :shoppers, :uid, :string
    add_index :shoppers, :uid
  end
end
