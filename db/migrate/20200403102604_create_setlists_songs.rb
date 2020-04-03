class CreateSetlistsSongs < ActiveRecord::Migration
  	def change
    	create_table :setlists_songs do |t|
			t.integer :setlist_id
			t.integer :song_id
			t.timestamps null: false
    	end
  	end
end

