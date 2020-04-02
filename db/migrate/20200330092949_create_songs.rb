class CreateSongs < ActiveRecord::Migration
  	def change
		create_table :songs do |t|
			t.string :title
			t.text :themes
			t.text :notes
			t.text :lyrics
			t.timestamps :created_on
			t.timestamps :updated_on
			t.integer :user_id
		end
	end
end
