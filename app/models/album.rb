class Album < ApplicationRecord
	belongs_to :cd
	has_many :music_in_cds
end
