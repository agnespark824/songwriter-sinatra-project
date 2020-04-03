class Song < ActiveRecord::Base
    belongs_to :user
    has_and_belongs_to_many :setlists
end
