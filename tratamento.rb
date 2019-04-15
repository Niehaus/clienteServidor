require 'fileutils'
require 'base64'
require 'socket'

ERROS = {
'403' => 'Erro 403 Forbidden.',
'404' => 'Erro 404 Page Not Found. Sorry ):',
'400' => 'Erro 400 Bad Request.'
}

ACCPTS = {
'200' => '200 OK!',
'202' => '202 Accepted!'
}

# possiveis extensões
IMGTYPE = {
'image/png' => 'png',
'image/jpeg' => 'jpg'
}

@i = 1
@i2 = 1
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

def mostraContent(hostname)
  Dir.chdir(hostname)
  Dir.entries(Dir.pwd).each do |arquivo|
    if arquivo == '.' || arquivo == '..'
      next
    elsif File.exist?(arquivo)
      puts "#{arquivo} content:\n"
      f = File.open(arquivo,"r")
      puts f.read
      f.close
    end
  end
  puts "\nArquivos do diretorio: #{Dir.entries(Dir.pwd)}"
  Dir.chdir("..")
end

def addFiles(hostname,path,port)
    puts "Add arquivos a #{hostname}"
    #HTTP request
    socket = TCPSocket.new hostname, port
    socket.puts("GET #{path} HTTP/1.1\r\nHost: #{hostname}\r\nConnection: keep-alive\r\nUpgrade-Insecure-Requests: 1\r\nUser-Agent:BarbsClient/5.0 (X11; Linux x86_64)\r\nAccept: text/html\r\nAccept-Encoding: deflate\r\nAccept-Language: en-US,en;q=0.9,pt-BR;q=0.8,pt;q=0.7\r\n\r\n")
    response = socket.read
    headers,body = response.split("\r\n\r\n", 2)
    status = headers.split("\n").first
    Dir.chdir(hostname)
    if headers.match? /png|jpeg/
      returnErros(status)
      #nwrite imagefile in the index
      filename = "imagem"
      filename = filename << @i.to_s
      filename = filename << ".jpg"
      @i.to_i
      @i += 1
      f = File.new(filename, 'w')
      f.write(body)
      puts "Imagem adicionada!"
    else
      returnErros(status)
      filename2 = "arquivo"
      filename2 = filename2 << @i2.to_s
      filename2 = filename2 << ".html"
      @i2.to_i
      @i2 += 1
      f = File.new(filename2,"w")
      f.write(body)
      f.close
      puts "Arquivo adicionado!"
    end
  Dir.chdir("..")
end

def escreveIndex(hostname,body,path)
  Dir.mkdir(hostname)
  puts "Diretorio criado."
  Dir.chdir(hostname)
  f = File.new("index.html","w")
  f.write(body)
  f.close
  puts "Conteúdo da solicitação foi escrito!"
  Dir.chdir("..")
end

def returnErros(statusCode)
  method,number,word = statusCode.split(' ', 3)
  if ERROS[number]
    puts "#{ERROS[number]}"
    exit!
  elsif ACCPTS[number]
    puts "All good. Status: #{ACCPTS[number]}"
  end
end

def imageDecode(dirname,content,name)
  # write file
  Dir.mkdir(dirname)
  puts "Diretorio criado."
  Dir.chdir(dirname)
  #name the file
  filename = "imagem"
  filename = filename << @i.to_s
  filename = filename << ".jpg"
  @i.to_i
  @i += 1
  f = File.new(filename, 'w')
  f.write(content)
  Dir.chdir('..')
end
