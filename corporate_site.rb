require 'sinatra'
require 'pony'

configure :development do
require 'better_errors'
  use BetterErrors::Middleware
  # you need to set the application root in order to abbreviate filenames
  # within the application:
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/?' do
  File.read(File.join('index.html'))
end

get '/contact' do
  File.read(File.join('contact.html'))
end

post '/mail' do
  # p request.path_info
  # p request.fullpath 
  # p request.url
	Pony.options = {   
                   :from           => "#{params[:name]}<lex@fusionrl.co>",
                   :via            => :smtp,
                   :via_options    => {
                     :address        => 'smtp.sendgrid.net',
                     :port           => '587',
                     :user_name      => ENV['SENDGRID_USERNAME'],
                     :password       => ENV['SENDGRID_PASSWORD'],
                     :authentication => :plain, 
                     :domain         => 'heroku.com'
                    }
                 }
  Pony.mail(subject: "A message from #{params[:name]}", to: 'support@fusionrl.com', body: "#{params[:name]} #{params[:email]} #{params[:message]}")
	redirect('/?')
end


