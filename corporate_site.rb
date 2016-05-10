require 'sinatra'

get '/' do
  File.read(File.join('index.html'))
  # File.read(File.join('layout.html'))
  # File.read(File.join('reference.html'))
end