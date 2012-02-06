load "degradation_goodreads.rb"

class HomeController < ApplicationController
  def searchTable (searchlist)
  	data_table = GoogleVisualr::DataTable.new

  	data_table.new_column('string', 'Book Title' ) 
	data_table.new_column('number', 'Rating') 

	searchlist.each do |book|
		data_table.add_row([book.axis_text,book.showrating])
	end

	if !searchlist.blank? 
		every = searchlist.count / 10
	else
		every = 0
	end

	chartarea = {left:30,top:0,width:"100%",height:"100%"}
	hAxis = {slantedTextAngle: 90}
	option = {axisTitlesPosition: "none", 
		fontSize: 12, 
		chartArea: chartarea, 
		hAxis: hAxis, 
		width: 630, height: 300, 
		title: 'Degradation', curveType: 'function' }
	result = GoogleVisualr::Interactive::LineChart.new(data_table, option)
  end

  def index
  	sSearch = params[:search]
  	if !sSearch.blank?
  		searcher = Degradation_goodreads.new
  		@search = searcher.book_list(sSearch)
  		@author = searcher.current_author
  		@chart = searchTable(@search)
  	end
  end
end
