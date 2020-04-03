class CreateSetlists < ActiveRecord::Migration
  	def change
    	create_table :setlists do |t|
			t.string :event
			t.text :description
			t.timestamps :created_on
			t.timestamps :updated_on
			t.integer :user_id
    	end
  	end
end
