class TypeName < ApplicationRecord
	has_many :recommends, foreign_key: :recommend_type
	has_many :cds, through: :recommends
end
