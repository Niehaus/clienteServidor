#!/usr/bin/ruby

require 'httpclient'
hostname = 'http://www.something.com'

client = HTTPClient.new
res = client.get hostname

method = 'GET'
url = URI.parse hostname
res2 = client.request method, url
hadfile = client.head 'http://www.something.com'

# connection status
puts "Connection status #{res2.status} :: sucessfull? #{HTTP::Status::successful? res2.status} "

# html download by request
if res.body.nil?
  puts "HTML error - download not complete"
else
  puts "HTML downloaded sucessfully"
  puts res.body
end

# head status
puts "Server: #{hadfile.header['Server'][0]}"
puts "Last modified: #{hadfile.header['Last-Modified'][0]}"
puts "Content type:  #{hadfile.header['Content-Type'][0]}"
puts "Content length: #{hadfile.header['Content-Length'][0]}"
