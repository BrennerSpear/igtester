class AddInfoToShoppers < ActiveRecord::Migration
  def change
    add_column :shoppers, :nickname, :string
    add_column :shoppers, :name, :string
    add_column :shoppers, :image, :string
    add_column :shoppers, :bio, :string
    add_column :shoppers, :website, :string
  end
end
