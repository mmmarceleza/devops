MySQL
========================

## Comandos básicos

Comando para listar todos os bancos e sua utilização de disco:

```
SELECT table_schema AS "Database", 
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)" 
FROM information_schema.TABLES 
GROUP BY table_schema;
```

## Backup do banco de dados

### Comando básico para gerar o backup de um banco de dados:

```bash
$ mysqldump -u [USER] -p [NOME_DO_BANCO] > backup.sql
```

Se usar o parâmetro `--databases`, não será necessário criar um banco vazio antes de fazer a importação.

### Comando para restaurar o backup do banco de dados:

- Antes de restaurar o backup, é importante criar o banco de dados vazio para receber as informações, caso não se tenha utilizado o parâmetro `--databases`.
  
  ```bash
  $ mysqladmin create [DB_VAZIO]
  ```
  
  ```bash
  $ mysql -u [USER] -p [DB_VAZIO] < backup.sql
  ```

- Caso se tenha usado a opção `--databases`, a sintaxe fica da seguinte forma:
  
  ```bash
  $ mysql -u [USER] -p < backup.sql
  ```

### Backup via Crontab:

Para automatizar o processo de backup, é mais fácil criar um script com as instruções e cadastrar no Crontab para executar regularmente. Ao utilizar o MySQL no Shell, a senha de usuário do banco de dados é requerida. Para não pausar o processo na etapa de solicitação dessa senha, recomenda-se fazer o seguinte procedimento:

- criar o arquivo oculto `.my.cnf` na pasta `/root/`;
- mudar as permissões para apenas o root ter acesso `# chmod 600 .my.cnf`
- colocar as informações de acesso no arquivo conforme abaixo:

```bash
[client]
user=root
password="ROOT_PASSWORD"
```
