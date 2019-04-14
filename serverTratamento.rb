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
