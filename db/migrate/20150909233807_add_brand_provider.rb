class AddBrandProvider < ActiveRecord::Migration
	def change

		add_column :brands, :provider, :string
	end
end