class Tag < ApplicationRecord
	has_many :posts

	validates_uniqueness_of :name_ar, :name_en
	validates_length_of :name_ar, :name_en, minimum: 3, maximum: 100

  	def to_s
    	self.name_ar || self.name_en
  	end
end
