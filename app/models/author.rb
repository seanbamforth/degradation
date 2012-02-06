class Author < ActiveRecord::Base
	has_many :books, :dependent => :destroy

	def isCreateAuthor?
		return true if self.renewal.nil? 
		return true if self.renewal < DateTime.now 
		return false 	
	end 


end
