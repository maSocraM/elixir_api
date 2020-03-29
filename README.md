# elixir_api
API construída em Elixir e Phoenix, simulando o mecanismo de postagens do Twitter, visando somente testes com a linguagem e o framework.


## 1. Instalação

O *stack* utilizando para o desenvolvimento deste teste foi:

- **Sistema operacional:** GNU/Linux (Arch Linux)
- **Banco de dados:** MariaDB 10.1
- **Linguagem de programação:** Erlang/OTP 22 (erts-10.6.4) e Elixir 1.10.1
- **Virtualização:** Docker e docker-compose

A não utilização exata deste *stack* pode trazer resultados não esperados.


### 1.1. Obter o código fonte

O código fonte pode ser obtido por meio de download diretamente do [repositório oficial "https://github.com/maSocraM/elixir_api"] (https://github.com/maSocraM/elixir_api), ou através do comando:

```
git clone https://github.com/maSocraM/elixir_api.git
```

Para utilizar o comando **git clone**, é necessário ter o git instalado no sistema, instruções podem ser obtidas em [https://git-scm.com/downloads](https://git-scm.com/downloads).


### 1.2. Banco de dados

Como já falado, é necessário um acesso a uma instância de banco de dados **"MariaDB 10.1"**, no qual pode-se ser utilizado um contêiner **Docker** juntamente com **docker-compose** (instruções de instalação podem ser obtidas em [https://docs.docker.com/install/](https://docs.docker.com/install/) e [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)) ou por outro meio qualquer.

Se optar pela instância docker, basta seguir os seguintes passos:

- Entrar no diretório [elixir_api/__docker](elixir_api/__docker) ;
- Executar o comando:

```
docker-compose up -d
```
Isso fará com que o Docker crie um imagem do MariaDB, baixando a imagem principal, e crie os banco de dados necessários para executar a aplicação.


**Obs.:** Os dados para acesso ao banco de dados via Docker são:
- **Usuário:** root
- **Senha:**
- **Host:** 127.0.0.1
- **Bancos de dados:** elixir_api e elixir_api_test


## 2. Configuração

Se for utilizar o banco de dados via Docker, nenhuma configuração adicional será necessária, pelo contrário é necessário efetuar as seguintes alterações nos arquivos [config/dev.exs] (config/dev.exs) e [config/test.exs] (config/test.exs):

`config/dev.exs`

```elixir
...
config :elixir_api, ElixirApi.Repo,
  ...
  username: "<insira aqui o usuário do banco de dados utilizado>",
  password: "<senha para o usuário>",
  database: "<nome do banco de dados>",
  hostname: "<endereço do banco de dados>",
...

```

`config/test.exs`

```elixir
...
config :elixir_api, ElixirApi.Repo,
  ...
  username: "<insira aqui o usuário do banco de dados para testes utilizado>",
  password: "<senha para o usuário>",
  database: "<nome do banco de dados de teste>",
  hostname: "<endereço do banco de dados de teste>",
...

```

## 3. Executando a aplicação

Primeiro é necessário recriar toda a estrutura de dados no banco de dados, para isso:

- Entre dentro do diretório **"elixir_api"**;
- Digite o comando:
```
mix ecto.migrate
```

- Após a conclusão do processo de criação da estrutura de tabela, basta executar o servidor embutido, com o comando:
```
mix phx.server
```
 A saída deste comando será algo próximo ao exemplo abaixo:
 ```
[info] Running ElixirApiWeb.Endpoint with cowboy 2.7.0 at 0.0.0.0:4000 (http)
[info] Access ElixirApiWeb.Endpoint at http://localhost:4000

webpack is watching the files…

Hash: d9f8029c417e2fd1cc24
Version: webpack 4.41.5
Time: 815ms
Built at: 29/03/2020 13:32:02
                Asset       Size       Chunks             Chunk Names
       ../css/app.css   10.6 KiB  ./js/app.js  [emitted]  ./js/app.js
       ../favicon.ico   1.23 KiB               [emitted]  
../images/phoenix.png   13.6 KiB               [emitted]  
        ../robots.txt  202 bytes               [emitted]  
               app.js   5.16 KiB  ./js/app.js  [emitted]  ./js/app.js
Entrypoint ./js/app.js = ../css/app.css app.js
[0] multi ./js/app.js 28 bytes {./js/app.js} [built]
[./css/app.css] 39 bytes {./js/app.js} [built]
[./js/app.js] 469 bytes {./js/app.js} [built]
    + 2 hidden modules
Child mini-css-extract-plugin node_modules/css-loader/dist/cjs.js!css/app.css:
    Entrypoint mini-css-extract-plugin = *
    [./node_modules/css-loader/dist/cjs.js!./css/app.css] 436 bytes {mini-css-extract-plugin} [built]
    [./node_modules/css-loader/dist/cjs.js!./css/phoenix.css] 10.9 KiB {mini-css-extract-plugin} [built]
        + 1 hidden module
 ```

A aplicação já se encontra disponível para uso em testes, bastando somente utilizar um client HTTP (Postman ou mesmo o Curl) na url [http://localhost:4000](http://localhost:4000).

## 4. Execução dos testes
Para executar os testes (em ambiente Linux), com o servidor embutido não ativo, siga os passos:
- Entre no diretório raiz [elixir_api](elixir_api) ;
- Executar os comandos:

```
MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
mix test
```
Estes dispararão a criação do ambiente e execução das rotinas de testes.


## 5. Documentação da API
Por padrão, o framework **Phoenix** possue um comando específico para a exebição de todas as rotas existentes (`mix phx.routes`), neste projeto, saída deste comando será:
```
[CrashTestDummy:~/Projetos/elixir_api]$ mix phx.routes
 user_path  POST    /api/users/signup  ElixirApiWeb.UserController :create
 user_path  POST    /api/users/signin  ElixirApiWeb.UserController :signin
tweet_path  GET     /api/tweets        ElixirApiWeb.TweetController :index
tweet_path  GET     /api/tweets/:id    ElixirApiWeb.TweetController :show
tweet_path  POST    /api/tweets        ElixirApiWeb.TweetController :create
tweet_path  PATCH   /api/tweets/:id    ElixirApiWeb.TweetController :update
            PUT     /api/tweets/:id    ElixirApiWeb.TweetController :update
tweet_path  DELETE  /api/tweets/:id    ElixirApiWeb.TweetController :delete
 websocket  WS      /socket/websocket  ElixirApiWeb.UserSocket
```
Porém estas serão discutidas com maior detalhe a seguir.

---

### 5.1. Criar usuários
Endpoint voltado para a criação de usuários visando o controle de acesso nos endpoints da API.

#### 5.1.1. Detalhes
- **Endpoint:** /api/users/signup
- **Tipo:** JSON
- **Método HTTP:** POST
- **Autenticação:** Nenhuma

#### 5.1.2. Payload de entrada
```json
{
  "user": {
           "name": "", 
           "lastname": "", 
           "username": "", 
           "email": "", 
           "password": ""
           }
}
```
- **Descrição dos campos do payload:**
  - **name**
    - **Descrição:** Nome próprio do usuário a ser criado
    - **Tipo:** String
    - **Tamanho máximo:** 100
  - **lastname**
    - **Descrição:** Sobrenome do usuário a ser criado
    - **Tipo:** String
    - **Tamanho máximo:** 100
  - **username**
    - **Descrição:** Nome de usuário
    - **Tipo:** String
    - **Tamanho máximo:** 191
    - **Único:** Sim
  - **email**
    - **Descrição:** E-mail do usuário
    - **Tipo:** String
    - **Tamanho máximo:** 191
    - **Único:** Sim
  - **password**
    - **Descrição:** Senha a ser utilizada no usuário
    - **Tipo:** String
    - **Tamanho máximo:** 255
    - **Único:** Sim
    - 
#### 5.1.3. Mensagem de retorno
```json
{
    "email": "",
    "id": 0,
    "token": "",
    "username": ""
}
```
- **Descrição dos campos da mensagem de retorno:**
  - **username**
    - **Descrição:** Nome de usuário criado
    - **Tipo:** String
  - **email**
    - **Descrição:** E-mail do usuário criado
    - **Tipo:** String
  - **id**
    - **Descrição:** Id do usuário criado no sistema
    - **Tipo:** Numérico inteiro
  - **token**
    - **Descrição:** Token gerado para acesso aos demais endpoints
    - **Tipo:** String

---

### 5.2. Fazer login
Endpoint voltado para a autenticação de um usuário já criado e geração de token para acesso nos demais endpoints da API.

#### 5.2.1. Detalhes
- **Endpoint:** /api/users/signin
- **Tipo:** JSON
- **Método HTTP:** POST
- **Autenticação:** Nenhuma

#### 5.2.2. Payload de entrada
```json
{
	"email": "", 
    "password": ""
}
```
- **Descrição dos campos do payload:**
  - **email**
    - **Descrição:** E-mail do usuário cadastrado
    - **Tipo:** String
    - **Tamanho máximo:** 191
  - **password**
    - **Descrição:** Senha do usuário cadastrado
    - **Tipo:** String
    - **Tamanho máximo:** 255

#### 5.2.3. Mensagem de retorno
```json
{
    "email": "",
    "id": 0,
    "token": "",
    "username": ""
}
```
- **Descrição dos campos da mensagem de retorno:**
  - **email**
    - **Descrição:** E-mail do usuário cadastrado
    - **Tipo:** String
  - **id**
    - **Descrição:** Id do usuário usuário cadastrado
    - **Tipo:** Numérico inteiro
  - **token**
    - **Descrição:** Token de login gerado para acesso aos demais endpoints
    - **Tipo:** String
  - **username**
    - **Descrição:** Nome de usuário do usuário cadastrado
    - **Tipo:** String

### 5.3. Recuperar todos os tweets
Retorna todos os tweets existentes no sistema.

#### 5.3.1. Detalhes
- **Endpoint:** /api/tweets
- **Tipo:** JSON
- **Método HTTP:** GET
- **Autenticação:** Bearer "token"

#### 5.3.2. Payload de entrada
```json
Nenhum
```

#### 5.3.3. Mensagem de retorno
```json
{
    "data": [
        {
            "content": "",
            "id": 0,
            "retweet_cnt": null
        },
        ...
    ]
}
```
- **Descrição dos campos da mensagem de retorno:**
  - **data**
    - **Descrição:** Lista com tweets cadastrados no sistema
    - **Tipo:** Lista
      - **content**
        - **Descrição:** Conteúdo do tweet
        - **Tipo:** String
      - **id**
        - **Descrição:** Id do usuário usuário cadastrado
        - **Tipo:** Numérico inteiro
      - **retweet_cnt**
        - **Descrição:** Quantidade de retweets
        - **Tipo:** null ou Numérico inteiro

### 5.4. Recuperar tweet específico
Retorna tweet especifico existente no sistema.

#### 5.4.1. Detalhes
- **Endpoint:** /api/tweets/{id}
- **Tipo:** JSON
- **Método HTTP:** GET
- **Autenticação:** Bearer "token"
- **Parâmetro:** ID do registrro

#### 5.4.2. Payload de entrada
```json
Nenhum
```

#### 5.4.3. Mensagem de retorno
```json
{
    "data": {
            "content": "",
            "id": 0,
            "retweet_cnt": null
    }
}
```
- **Descrição dos campos da mensagem de retorno:**
  - **data**
    - **Descrição:** Contêiner de retorno dos campos da resposta
    - **Tipo:** Contêiner
      - **content**
        - **Descrição:** Conteúdo do tweet
        - **Tipo:** String
      - **id**
        - **Descrição:** Id do usuário usuário cadastrado
        - **Tipo:** Numérico inteiro
      - **retweet_cnt**
        - **Descrição:** Quantidade de retweets
        - **Tipo:** null ou Numérico inteiro


### 5.5 Inserir tweet
Retorna tweet especifico existente no sistema.

#### 5.5.1. Detalhes
- **Endpoint:** /api/tweets
- **Tipo:** JSON
- **Método HTTP:** POST
- **Autenticação:** Bearer "token"

#### 5.5.2. Payload de entrada
```json
{
    "tweet": {
        "content": "",
        "user_id": 0
    }
}
```
- **Descrição dos campos do payload:**
  - **tweet**
    - **Descrição:** Contêiner de retorno dos campos da resposta
    - **Tipo:** Contêiner
      - **content**
        - **Descrição:** Conteúdo do tweet
        - **Tipo:** String
      - **user_id**
        - **Descrição:** Id do usuário usuário cadastrado
        - **Tipo:** Numérico inteiro

#### 5.5.3. Mensagem de retorno
```json
{
    "data": {
            "content": "",
            "id": 0,
            "retweet_cnt": null
    }
}
```
- **Descrição dos campos da mensagem de retorno:**
  - **data**
    - **Descrição:** Contêiner de retorno dos campos da resposta
    - **Tipo:** Contêiner
      - **content**
        - **Descrição:** Conteúdo do tweet
        - **Tipo:** String
      - **id**
        - **Descrição:** Id do usuário usuário cadastrado
        - **Tipo:** Numérico inteiro
      - **retweet_cnt**
        - **Descrição:** Quantidade de retweets
        - **Tipo:** null ou Numérico inteiro

### 5.6 Atualizar tweet (não funcional)
Retorna tweet especifico existente no sistema.

#### 5.6.1. Detalhes
- **Endpoint:** /api/tweets/{id}
- **Tipo:** JSON
- **Método HTTP:** PUT / PATCH
- **Autenticação:** Bearer "token"
- **Parâmetro:** ID do registrro

#### 5.6.2. Payload de entrada
```json
{
    "tweet": {
        "content": "",
        "user_id": 0
    }
}
```
- **Descrição dos campos do payload:**
  - **tweet**
    - **Descrição:** Contêiner de retorno dos campos da resposta
    - **Tipo:** Contêiner
      - **content**
        - **Descrição:** Conteúdo do tweet
        - **Tipo:** String
      - **user_id**
        - **Descrição:** Id do usuário usuário cadastrado
        - **Tipo:** Numérico inteiro

#### 5.6.3. Mensagem de retorno
```json
{
    "data": {
            "content": "",
            "id": 0,
            "retweet_cnt": null
    }
}
```
- **Descrição dos campos da mensagem de retorno:**
  - **data**
    - **Descrição:** Contêiner de retorno dos campos da resposta
    - **Tipo:** Contêiner
      - **content**
        - **Descrição:** Conteúdo do tweet
        - **Tipo:** String
      - **id**
        - **Descrição:** Id do usuário usuário cadastrado
        - **Tipo:** Numérico inteiro
      - **retweet_cnt**
        - **Descrição:** Quantidade de retweets
        - **Tipo:** null ou Numérico inteiro

### 5.7 Apagar tweet
Apaga tweet específico

#### 5.7.1. Detalhes
- **Endpoint:** /api/tweets/{id}
- **Tipo:** JSON
- **Método HTTP:** DELETE
- **Autenticação:** Bearer "token"
- **Parâmetro:** ID do registrro

#### 5.7.2. Payload de entrada
```json
Nenhum
```

#### 5.7.3. Mensagem de retorno
```json
Nenhum - código HTTP: 204
```

## 6. Experiência no desenvolvimento

