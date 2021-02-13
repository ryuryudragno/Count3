require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

require 'sinatra/activerecord'
# require './models'

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

# helpers do
#   def current_counter
#     Count.find_by(id: session[:user])
#   end

# end

get '/' do
  @counters = Count.all
  # @number = Count.first.number
  erb :index
end

post '/plus/:id' do
  count = Count.find(params[:id])#その列のものを表示
  #idは定義しなくても使える万能くん
  count.number = count.number + 1
  count.save
  redirect '/'
end

post '/minus/:id' do
  # count = Count.first
  count = Count.find(params[:id])#その列のものを表示
  count.number = count.number - 1
  count.save
  redirect '/'
end

post '/clear/:id' do
  count = Count.find(params[:id])#その列のものを表示
  count.number = 0
  count.save
  redirect '/'
end

post '/delete/:id' do
  count = Count.find(params[:id])#その列のものを表示
  count.destroy
  redirect '/'
end

post '/new' do
  Count.create(
      number: 0
  )#countersに新しく0のカウンターを作る
  redirect '/'
end