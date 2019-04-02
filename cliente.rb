require 'socket'
require 'fileutils'

#socket = TCPSocket.new 'localhost', 8000

host = 'www.tutorialspoint.com'     # The web server
port = 80                       # Default HTTP port
path = '/index.html'                 # The file we want

# This is the HTTP request we send to fetch a file
request = "GET #{path} HTTP/1.0\r\n\r\n"
#addr = Socket.getaddrinfo(host, "http", nil, :STREAM)
#puts "oie = #{addr.at(2)}"
socket = TCPSocket.new host, port

socket.print(request)               # Send request
response = socket.read              # Read complete response
# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
print body

dirname = "public_html"
file_name = 'index.html'
FileUtils.mkdir_p(dirname) unless Dir.exists?(dirname)
f = File.open(File.join(Dir.pwd, dirname, file_name),"w+")
f.write(body)
f.close
