require 'socket'
require_relative 'serverTratamento'
server = TCPServer.new 8000

Dir.chdir('serverSrc')
puts "Servidor \nDirname: serverSrc\nPort: 8000"
loop do
  #session = server.accept
  cliente = 0
  request = []
  Thread.fork(server.accept) do |session|
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end

  http_method, path, protocol = request[0].split(' ') #separa a linha de requisição

  puts "\nRequest:: #{http_method} #{path} #{protocol}"
  addres_vector = session.addr(:hostname)
  puts "Hostname:: #{addres_vector[2]}"
  puts "IP:: #{addres_vector[3]}"
  #puts request[3]

  if PAGES.keys.include? path
    status = "200 OK"
    type = content_type(path)
    puts "Status: #{status}"
    puts "Content-type: #{type}"
    f = File.open(PAGES[path],"r")
    response_body = f.read()
    f.close
  else
    status = "404 Not Found"
    response_body = PAGE_NOT_FOUND
  end

  session.puts <<-HEREDOC
HTTP/1.1 #{status}

#{response_body}
  HEREDOC

  session.close
  end
end
