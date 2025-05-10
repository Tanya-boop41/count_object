require "sinatra"

class ScreenServer < Sinatra::Base
  get "/" do
    erb :index, locals: { screen: settings.screen }
  end

  get '/solution' do
    erb :index, locals: { screen: settings.screen }
  end

  get "/beep.mp3" do
    content_type "audio/mpeg"
    response.body = File.read(File.expand_path("../../../../public/beep.mp3", __FILE__))
  end

  configure do
    set :logging, Logger::DEBUG
  end
end
ScreenServer.set :views, File.expand_path("../../../../views", __FILE__)
