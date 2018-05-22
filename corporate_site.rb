require 'sinatra'
require 'pony'

# set :public_dir, File.expand_path(__dir__, 'public')

configure :development do
require 'better_errors'
  use BetterErrors::Middleware
  # you need to set the application root in order to abbreviate filenames
  # within the application:
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/?' do
  File.read(File.join('index.erb'))
end

get '/contact' do
  File.read(File.join('contact.erb'))
end

get '/downloads/:file' do |file|
  pdf_file = File.read(File.join('public/files/', file))
  attachment(pdf_file,:disposition => 'attachment', :filename => File.basename(file), :type => "application/octet-stream")
  # response.headers['Content-Transfer-Encoding'] = "binary"
  # file = File.join('/public/files/', file)
  # send_file(file,:disposition => 'attachment', :filename => File.basename(file), :type => "application/octet-stream")
end


post '/mail' do
  # p request.path_info
  # p request.fullpath 
  # p request.url
	Pony.options = {   
                   :from           => "#{params[:first_name]}",
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
  Pony.mail(subject: "A message from #{params[:first_name]}",
                 to: 'support@fusionrl.com, lex@fusionrl.co',
               body: "#{params[:first_name]},\n
                      #{params[:company]},\n
                      #{params[:last_name]},\n
                      #{params[:email]},\n
                      #{params[:phone]},\n
                      #{params[:role]},\n
                      #{params[:region]},\n
                      #{params[:message]}")
	redirect('/?')
end








