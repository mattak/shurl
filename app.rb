require 'sinatra'
require 'shurl'

#
# routing
#

shurl = Shurl::Model.new

get '/' do
  "please post url"
end

# show raw url
get '/s/:code' do
  url = shurl.to_longurl(params[:code])

  if url == nil
    "no url found"
  else
    url
  end
end

# redirect
get '/:code' do
  url = shurl.to_longurl(params[:code])

  if url == nil
    redirect '/'
  else
    redirect url
  end
end

# shorten
post '/' do
  if params[:url] == nil
    halt 400, "please specify url param"
  else 
    short_url = shurl.find_or_create_url(request, params[:url])
    short_url
  end
end

