# Ruby HTTP-Server-Client
## Trabalho para a disciplina de Redes 2019.1 - Prof. Flávio 
Para rodar o Servidor e o Cliente respectivamente:
```
ruby server.rb
ruby cliente.rb
```
##### O Servidor, porta 8000
O servidor funciona atraves de um sistema de Hash, ele irá consultar se o request feito a ele existe na sua Hash de arquivos, caso ele exista irá exibi-lo, caso não, retornará o erro de página não encontrada. Um método de acessá-lo é atráves do IPdaRede:8000, possuindo os seguintes links: 
```
(IPdaRede)localhost:8000/
(IPdaRede)localhost:8000/about
(IPdaRede)localhost:8000/news
```
##### O Cliente
O cliente irá, a partir de uma dada URL e de uma porta escolhida pelo usuário para baixar o arquivo pedido, realizando o download apenas das páginas HTTP, rejeitando as HTTPS. Além disso, cada hostname criará uma pasta, e a partir dela poderá adicionar arquivos a medida que faz requisições de um mesmo Hostname e poderá também apenas visualizar os arquivos existentes no diretório pertencente a requisição. Caso a requisição não seja efetuada com sucesso o cliente pode retornar os erros:
```
Erro 403 Forbidden.
Erro 404 Page Not Found.
Erro 400 Bad Request.
```
Ou os status code de sucesso:
```
200 OK.
202 Accepted.
```
Lista de sites possivelmente aceitos: https://bit.ly/2D9Iaov

Nas palavras de Tati Quebra Barraco:

> Quem gostou bate palma, quem não gostou paciência.
