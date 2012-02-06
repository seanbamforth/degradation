require 'goodreads'
class Degradation_goodreads

	def initialize
		Goodreads.configure({:api_key => "qeYGfb1f0koITL63hz4IA"})
	end

	def insert_books(work)
		author = @author.name 

		work.each do |book|
	  	#pp book
  		
			begin 
	  		if @author.didyoumean.nil? 
					@author.didyoumean = book.best_book.author.name
		  	end

		  	if (book.best_book.author.name.downcase == author.downcase) and (book.ratings_count.to_i>100) and (!book.original_publication_year.blank?)
		  		@book = @author.books.new 
		  		@book.year = book.original_publication_year
		  		@book.rating = (book.average_rating.to_f*100)
		  		@book.title = book.best_book.title
		  		@book.isbn = book.isbn
			  end

		  rescue 
		  	"OK"
		  end

	  end
	end

	def override_author
		author = @author.name 
		@author.didyoumean = nil 
		@author.books.clear  

		client = Goodreads::Client.new
		search = client.search_books(author, {:field=>"author"})
		total_books = search.total_results
	  
	  insert_books(search.results.work)

	  page=1
	  while ((total_books!=search.results_end) and (page<10)) do  
	  	puts "#{total_books} : #{search.results_end}"
	  	page = page+1
	  	search = client.search_books(author, {:field=>"author", :page=>page})
	  	insert_books(search.results.work)
		end

		@author.renewal = 1.days.from_now
		@author.save 
	end

	def create_records(author)
		@author = Author.find_by_name(author)
		if @author == nil 
			@author = Author.new 
			@author.name = author
			@author.save 
		end

		if @author.isCreateAuthor? 
			override_author
		end
	end

	def current_author
		@author 
	end

	def book_list(author)
		create_records(author.downcase)
		@author.books.order("books.year")
	end

end