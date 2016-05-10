require 'sinatra'

get '/' do
  File.read(File.join('index.html'))
  # File.read(File.join('layout.html'))
  # File.read(File.join('reference.html'))
end

post '/' do
    require 'pony'
    Pony.mail(
      from: "MIKE<mike@fusionrl.co>",
      to: 'mike@fusionrl.co',
      subject: "A message from the DAZ4126 website",
      body: params[:message],
      port: '587',
      via: :smtp,
      via_options: { 
        :address              => 'smtp.sendgrid.net', 
        :port                 => '587', 
        :enable_starttls_auto => true, 
        :user_name            => ENV['SENDGRID_USERNAME'], 
        :password             => ENV['SENDGRID_PASSWORD'], 
        :authentication       => :plain, 
        :domain               => 'heroku.com'
      })
    redirect '/' 
end