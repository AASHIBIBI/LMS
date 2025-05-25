#!/usr/bin/env ruby

# Simple script to start Rails server with error capturing
puts "Starting Rails server with error capturing..."

begin
  # Set Rails environment to development
  ENV['RAILS_ENV'] = 'development'
  ENV['DISABLE_DATABASE'] = 'true'
  
  # Try to start the server
  require './config/environment'
  require 'rack/handler/puma'
  
  puts "Rails environment loaded successfully!"
  
  # Start Puma server
  Rack::Handler::Puma.run Rails.application, Port: 3000
rescue => e
  puts "ERROR: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
  puts "\nPress any key to exit..."
  gets
end 