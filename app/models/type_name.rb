class TypeName < ApplicationRecord
	has_many :recommends, foreign_key: :recommend_type, dependent: :destroy
	has_many :cds, through: :recommends
end
