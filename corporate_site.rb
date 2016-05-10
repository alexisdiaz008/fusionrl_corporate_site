require 'sinatra'
require 'better_errors'
require 'pony'

configure :development do
  use BetterErrors::Middleware
  # you need to set the application root in order to abbreviate filenames
  # within the application:
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  File.read(File.join('index.html'))
  # File.read(File.join('layout.html'))
  # File.read(File.join('reference.html'))
end

post '/mail' do

	# Pony.options = {   
 #                   :from           => "MIKE<mike@fusionrl.co>",
 #                   :via            => :smtp,
 #                   :via_options    => {
 #                     :address        => 'smtp.sendgrid.net',
 #                     :port           => '587',
 #                     :user_name      => ENV['SENDGRID_USERNAME'],
 #                     :password       => ENV['SENDGRID_PASSWORD'],
 #                     :authentication => :plain, 
 #                     :domain         => 'heroku.com'
 #                    }
 #                 }
 #  Pony.mail(subject: "A message from the #{params[:name]}", to: 'mike@fusionrl.co', body: "#{params[:name]} #{params[:email]} #{params[:message]}")

  redirect('/')
end

