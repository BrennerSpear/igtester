class AddBrandBcColumns < ActiveRecord::Migration
	def change

		add_column :brands, :bcid, :string
		add_column :brands, :bctoken, :string
	end
end