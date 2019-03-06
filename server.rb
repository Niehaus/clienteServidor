# file server.rb
require 'socket'

server = TCPServer.open(3001)  # Abre socket em escuta na porta 3001
hostname = 'https://www.google.com.br'
loop { # o servidor nunca morre, fica sempre executando
  client = server.accept      # aceita conexão do cliente
  msg_cliente = client.recvfrom( 10000 ) # recebe mensagem - 10000 bytes - do cliente

  puts  "Mensagem do cliente: #{msg_cliente}" # imprime a mensagem do cliente no servidor
  client.puts "Ola cliente eu, o servidor, recebi sua mensagem" #envia uma mensagem ao cliente
  client.puts "Vamos conetá-lo ao "
  #puts TCPSocket.gethostbyname(hostname)
  client.close # fecha conexão
}