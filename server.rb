require 'socket'
server = TCPServer.new 8000

PAGES = {
  "/" => "index.html",
  "/about" => "about.html",
  "/news" => "news.html"
}

PAGE_NOT_FOUND = "Sorry, there's nothing here."

loop do
  session = server.accept
  request = []
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end
#  puts  "o que eu quero é #{request}"
  puts "finished reading"

  http_method, path, protocol = request[0].split(' ') # there are three parts to the request line
  puts "#{http_method} #{path} #{protocol}"

  if PAGES.keys.include? path
    status = "200 OK"
    dirname = "public"
    f = File.open(PAGES[path],"r")
    response_body = f.read()
    f.close
  else
    status = "404 Not Found"
    response_body = PAGE_NOT_FOUND
  end
  puts response_body
  session.puts <<-HEREDOC
HTTP/1.1 #{status}

#{response_body}
  HEREDOC

  session.close
end
