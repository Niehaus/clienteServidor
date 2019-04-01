require 'socket'
server = TCPServer.new 8000

PAGES = {
  "/" => "Hi, welcome to the home page!",
  "/about" => "About us: we are http hackers",
  "/news" => "We haven't made much news yet with this server, but stay tuned"
}

PAGE_NOT_FOUND = "Sorry, there's nothing here."

loop do
  session = server.accept
  request = []
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end
  puts "finished reading"

  http_method, path, protocol = request[0].split(' ') # there are three parts to the request line

  if PAGES.keys.include? path
    status = "200 OK"
    response_body = PAGES[path]
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
