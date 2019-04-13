require 'socket'
require 'fileutils'

# arquivos vão estar nesse diretorio
WEB_ROOT = './public'

# possiveis extensões
CONTENT_TYPE_MAPPING = {
    'html' => 'text/html',
    'txt' => 'text/plain',
    'png' => 'image/png',
    'jpg' => 'image/jpeg'
}

# trata como binario os tipos n identificados
DEFAULT_CONTENT_TYPE = 'application/octet-stream'

# verifica o tipo de arquivo pela extensão.
def content_type(path)
  ext = File.extname(path).split('.').last
  CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
end

# pega o request e transforma num caminho p servidor a partir do web-root
def requested_file(request_line)
  request_uri  = request_line.split(' ')[1]
  path         = URI.unescape(URI(request_uri).path)

  clean = []

  # divide caminho em componentes
  parts = path.split('/')

  parts.each do |part|
    # passa direto por qlq diretorio vazio
    next if part.empty? || part == '.'
    # se o caminho sobe um nível de diretorio (".."),
    # remove o ultimo compenente limpo
    # se n vai pro array de components limposs
    part == '..' ? clean.pop : clean << part
  end

  # retonar raiz p novo caminho limpo
  File.join(WEB_ROOT, *clean)
end

# server starts here
server = TCPServer.new('localhost', 8080)

loop do
  socket       = server.accept
  request_line = socket.gets

  STDERR.puts "Recebi:: #{request_line}"

  path = requested_file(request_line)
  path = File.join(path, 'index.html') if File.directory?(path)
  puts path
  # verifica se existe o arquivo e se n é diretorio
  if File.exist?(path) && !File.directory?(path)
    File.open(path, 'rb') do |file|
      STDERR.puts "200. All set!"
      socket.print "HTTP/1.1 200 OK\r\n" +
                       "Content-Type: #{content_type(file)}\r\n" +
                       "Content-Length: #{file.size}\r\n" +
                       "Connection: close\r\n"
      socket.print "\r\n"

      # escreve o conteudo do arquivo no socket
      IO.copy_stream(file, socket)
    end
  else #404 n existe arquivo
    message = "File not found\n"
    STDERR.puts "404. Not Found"

    socket.print "HTTP/1.1 404 Not Found\r\n" +
                     "Content-Type: text/plain\r\n" +
                     "Content-Length: #{message.size}\r\n" +
                     "Connection: close\r\n"

    socket.print "\r\n"

    socket.print message
  end
  socket.close
end
