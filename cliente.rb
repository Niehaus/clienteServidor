require 'socket'
require 'fileutils'
require 'net/http'

# http://www.ruby-lang.org
puts "Informe a porta: "
port = $stdin.gets.chomp
path = '/'
url_correta = 'http://'
socket = TCPSocket.new 'localhost', port
puts "Informe a url: "
  url = $stdin.gets.chomp # $stdin is an object that's always present and manages user input from the console
  #puts socket.gets.chomp # wait for more content to appear in the socket and print it to the console
  if url =~/[http]/
    puts "não tem nada errado11!"
    uri = URI(url)
  elsif url =~/[https]/
    puts "HTTPS not supported - end of connection"
    exit!
  else
    url_correta << url
    puts url_correta
    uri = URI(url_correta)
  end

  req = Net::HTTP::Get.new(uri)
  req['some_header'] = "some_val"

  res = Net::HTTP.start(uri.hostname, uri.port) {|http|
    http.request(req)
  }
  socket.puts("GET #{path} HTTP/1.1\r\n\r\n") # take what you entered and send it via TCP to the socket file
  response = socket.read# Read complete response
  puts "o servidor respondeu: \n #{response}"
  # Split response at first blank line into headers and body
  #headers,body = response.split("\r\n\r\n", 2)
  #puts "server response #{body}"
  #puts socket.gets.chomp # wait for more content to appear in the socket and print it to the console



#uri = URI("http://www.ruby-lang.org")
#req = Net::HTTP::Get.new(uri)
#req['some_header'] = "some_val"

#res = Net::HTTP.start(uri.hostname, uri.port) {|http|
#  http.request(req)
#}

#puts res.body # <!DOCTYPE html> ... </html> => nil
#socket = TCPSocket.new 'localhost', 8000
#host = 'www.ruby-lang.org'     # The web server
#port = 80                       # Default HTTP port
#path = '/'                 # The file we want

# This is the HTTP request we send to fetch a file
#request = "GET #{path} HTTP/1.0\r\n\r\n"
#socket = TCPSocket.new host, port
#socket.print(request)               # Send request
#response = socket.read              # Read complete response
# Split response at first blank line into headers and body
#headers,body = response.split("\r\n\r\n", 2)
#print body


#dirname = "public_html"
#file_name = 'index.html'
#FileUtils.mkdir_p(dirname) unless Dir.exists?(dirname)
#f = File.open(File.join(Dir.pwd, dirname, file_name),"w+")
#f.write(body)
#f.close
