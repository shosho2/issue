require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	return SQLite3::Database.new 'mydatabase.db'
end

configure do

db = get_db

db.execute "CREATE TABLE IF NOT EXISTS 
	'users'
	(
		'id' integer PRIMARY KEY AUTOINCREMENT,
	 	'username' text,
	 	'mail' text,
	 	'datestamp' text,
	 	'barber' text,
	 	'color' text
	 )" 
end
#db.close
get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end


get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts	
end

post '/contacts' do
	@user = params[:user]
	@comment = params[:comment]

	erb 'Хз, еще учить нужно хуйню'

end

post '/visit' do
	

	@name = params[:user_name]
	@mail = params[:mail]
	@date = params[:date]
	@barber = params[:barber]
	@color = params[:color]
	
	hh = {:user_name => 'Enter ur name', :mail => 'Enter ur mail', :date => 'Enter correct date'}

	@error = hh.select {|key,_| params[key] == ''}.values.join(', ')

	if @error != ''
			return erb :visit
	end

	db = get_db
	  db.execute 'insert into 
	  	users
	  	(username, mail, datestamp, barber, color)
	  	values (?, ?, ?, ?, ?)' , [@name, @mail, @date, @barber, @color]
#	hh.each do |key, value|

#		if params[key] == ''
#			@error = hh[key]

#			return erb :visit
#		end
#	end
	erb	"name: #{@name}, mail: #{@mail}, date: #{@date}, barber: #{@barber}, color: #{@color}"
end





	#f = File.open "clients.txt", "a"
	#f.write "name: #{@name}, mail: #{@mail}, date: #{@date}, barber: #{@barber}, color: #{@color}"
	#f.close
