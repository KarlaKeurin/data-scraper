# WEB SCRAPING

Este repositório contém um projeto de Web Scraping. Siga os passos abaixo para rodá-lo em sua máquina. 🚀

## ⚙️ Configurações do Backend

### 1. Criando e ativando o ambiente virtual

```
python3 -m venv venv
source venv/bin/activate
```

### 2. Instalando as dependências

```
pip install -r requirements.txt
```

### 3. Iniciando o servidor FastAPI

Após instalar as dependências, inicie o servidor executando:

```
uvicorn main:app --reload
```

### 4. Web Scraping e Transformação de Dados
🔍 Faça o download dos Anexos I e II e crie um arquivo compactado com os PDFs.

```
python scraper.py
```

🔍 Para extrair a tabela do Anexo I, salvar no formato .csv e compactar o CSV em um arquivo .zip, rode o comando abaixo.

```
python data_transformer.py
```

### 5. Configurando o Banco de Dados

<details>
  <summary>💡 Talvez seja necessário setar o local_infile globalmente, siga as instruções caso necessário:</summary><br/>

  * No terminal, conecte-se ao MySQL como root:
  ```
  mysql -u root -p
  ```
  * Depois, rode este comando para ativar a opção no servidor:
  ```
  SET GLOBAL local_infile = 1;
  ```
  * Verifique se está ativado:
  ```
  SHOW VARIABLES LIKE 'local_infile';
  ```
  * Se retornar ON, então está ativado.
</details><br/>

Acessando o terminal MySQL

```
mysql -u root -p --local-infile=1
```

Dentro do terminal MySQL, selecione o banco de dados

```
USE db_intuitive_care;
```

💾 Faça a pesquisa 

```
SOURCE db.sql;
SOURCE queries.sql;
```

## 💻 Configuração do Frontend

Abra o terminal integrado da pasta frontend e execute os seguintes comandos:

### 1. Instalando as dependências

```
npm install
```

### 2. Iniciando o servidor
Inicie o frontend na porta 5173 e faça sua busca:

```
npm run dev
```
