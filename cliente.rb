# file client.rb
require 'socket'
require 'net/http'

hostname = 'google.com.br'
server = TCPSocket.open('localhost', 3001) # conecta ao servidor na porta 3001
server.puts 'Ola servidor eu, o cliente, estou enviando uma mensagem' # envia mensagem para o servidor
resp = server.recvfrom(10_000) # recebe a mensagem -10000 bytes - do servidor

puts resp

server.close # Fecha a conexão com o servidor

