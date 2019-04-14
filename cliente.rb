require 'socket'
require_relative 'tratamento'

while 1
  puts "\nInsira a url:"
  url = gets.chomp
  puts "Insira a porta:"
  port = gets.chomp

  uri = URI(trataEntrada(url)) #separa em uri elements
  uri.port = setPort(port)
  puts "hostname: #{uri.host}\npath request: #{uri.request_uri}\nport: #{uri.port}\n"
    if Dir.exist?(uri.host)
       puts "\nDiretorio existente! Files:"
       mostraContent(uri.host)
    else
      puts "Diretorio #{uri.host} não existe."
      #HTTP request aqui
      socket = TCPSocket.new uri.host, uri.port
      socket.puts("GET #{uri.request_uri} HTTP/1.1\r\nHost: #{uri.host}\r\nConnection: keep-alive\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent:BarbsClient/5.0 (X11; Linux x86_64)\r\nAccept: text/html\r\nAccept-Encoding: deflate\r\nAccept-Language: en-US,en;q=0.9,pt-BR;q=0.8,pt;q=0.7\r\n\r\n")
      response = socket.read
      headers,body = response.split("\r\n\r\n", 2)
      status = headers.split("\n").first
      returnErros(status)
      escreveIndex(uri.host,body)
    end
end
