class Origin < ApplicationRecord
	validates :name, uniqueness: { case_sensitive: false }, length: { minimum: 1 }
end