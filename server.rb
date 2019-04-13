require 'socket'
server = TCPServer.new 8000

PAGES = {
  "/" => "index.html",
  "/about" => "about.html",
  "/news" => "news.html",
  "/43775.jpg" => "43775.jpg",
  "/flavio.jpg" => "flavio.jpg"
}
# possiveis extensões
CONTENT_TYPE_MAPPING = {
    'html' => 'text/html',
    'txt' => 'text/plain',
    'png' => 'image/png',
    'jpg' => 'image/jpeg'
}

PAGE_NOT_FOUND = "404 Page Not Found. Não tem nada aqui ):"

# trata como binario os tipos n identificados
DEFAULT_CONTENT_TYPE = 'application/octet-stream'

# verifica o tipo de arquivo pela extensão.
def content_type(path)
  ext = PAGES[path].split('.').last
  if CONTENT_TYPE_MAPPING[ext]
    return CONTENT_TYPE_MAPPING[ext]
  else
    return DEFAULT_CONTENT_TYPE
  end
end
  puts "Servidor \nDirname: clienteServer\nPort: 8000"
loop do
  #session = server.accept

  cliente = 0
  request = []
  Thread.fork(server.accept) do |session|
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end
  puts "\n"
  http_method, path, protocol = request[0].split(' ') #separa a linha de requisição

  puts "Request:: #{http_method} #{path} #{protocol}"
  addres_vector = session.addr(:hostname)
  puts "Hostname:: #{addres_vector[2]}"
  puts "IP:: #{addres_vector[3]}"
  puts request[3]
  if PAGES.keys.include? path
    status = "200 OK"
    type = content_type(path)
    puts "content-type: #{type}"
    f = File.open(PAGES[path],"r")
    response_body = f.read()
    f.close
  else
    status = "404 Not Found"
    response_body = PAGE_NOT_FOUND
  end
  #sputs response_body
  session.puts <<-HEREDOC
HTTP/1.1 #{status}

#{response_body}
  HEREDOC

  session.close
  end
end
