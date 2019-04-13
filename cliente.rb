require 'socket'
require 'uri'

def trataEntrada(url)
  http = "http://"
  path2 = '/'
  #retira www.
  if url =~ /[www.]/
    url = url.split('www.')
    url_correta = url.join
  else
    url_correta = url
  end
  #adiciona / pro path
  if url_correta =~ /[\/]/
  else
    url_correta << path2
  end
  #adiciona http pro URI
  if url_correta =~ /[http:]/
    if  url_correta[4] == "s"
      puts "https não é aceito!"
      exit!
    end
  else
    url_correta = http << url_correta
  end
  return url_correta
end

def setPort(port)
  if port.empty?
    port = 80
    return port
  else
    return port
  end
end

puts "Insira a url:"
url = gets.chomp
puts "Insira a porta:"
port = gets.chomp

uri = URI(trataEntrada(url)) #separa em uri elements
uri.port = setPort(port)
puts "hostname: #{uri.host}\npath request: #{uri.request_uri}\nport: #{uri.port}\n"

#HTTP request começa aqui
socket = TCPSocket.new uri.host, uri.port

socket.puts("GET #{uri.request_uri} HTTP/1.1\r\nHost: #{uri.host}\r\nConnection: keep-alive\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent:BarbsClient/5.0 (X11; Linux x86_64)\r\nAccept: text/html\r\nAccept-Encoding: deflate\r\nAccept-Language: en-US,en;q=0.9,pt-BR;q=0.8,pt;q=0.7\r\n\r\n")
puts socket.read
