require 'socket'

socket = TCPSocket.new 'localhost', 8000

while true
  msg = $stdin.gets.chomp # $stdin is an object that's always present and manages user input from the console
  socket.puts( msg ) # take what you entered and send it via TCP to the socket file
  puts socket.gets.chomp # wait for more content to appear in the socket and print it to the console
end
