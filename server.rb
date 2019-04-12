require 'socket'
server = TCPServer.new 8000

PAGES = {
  "/" => "index.html",
  "/about" => "about.html",
  "/news" => "news.html",
  "/img" => "img.html",
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

PAGE_NOT_FOUND = "Não tem nada aqui ):"

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

loop do
  session = server.accept
  request = []
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end
  http_method, path, protocol = request[0].split(' ') #separa a linha de requisição
  type = content_type(path)
  f = File.open(PAGES[path],"r")
  puts "Request:: #{http_method} #{path} #{protocol}"
  puts IPSocket.getaddress("localhost")
  
  if PAGES.keys.include? path
    status = "200 OK"
    puts "content-type: #{type}"
    puts "caminho = #{path}"
    response_body = f.read()
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
  f.close
end
