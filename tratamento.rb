require 'fileutils'

ERROS = {
'403' => 'Erro 403 Forbidden.',
'404' => 'Erro 404 Page Not Found. Sorry ):',
'400' => 'Erro 400 Bad Request.'
}

ACCPTS = {
'200' => '200 OK!',
'202' => '202 Accepted!'
}

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
  puts Dir.entries(Dir.pwd)
  Dir.entries(Dir.pwd).each do |arquivo|
    if arquivo == '.' || arquivo == '..'
      next
    elsif File.exist?(arquivo)
      puts "#{arquivo} content:\n"
      f =   File.open(arquivo,"r")
    #  puts f.read
      f.close
    end
  end
  Dir.chdir("..")
end

def escreveIndex(hostname,body)
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
