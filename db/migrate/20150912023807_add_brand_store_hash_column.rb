class AddBrandStoreHashColumn < ActiveRecord::Migration
	def change

		add_column :brands, :store_hash, :string
	end
end