class Book < ActiveRecord::Base
	belongs_to :author

	def axis_text 
		"#{self.title} - #{self.year}"
	end

	def showrating
		r = self.rating
		return 0 if r.nil? 
		self.rating.to_f / 100
	end
end
