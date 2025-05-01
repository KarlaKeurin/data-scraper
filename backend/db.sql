CREATE DATABASE IF NOT EXISTS db_intuitive_care;
USE db_intuitive_care;

DROP TABLE IF EXISTS Relatorio_cadop;
CREATE TABLE IF NOT EXISTS Relatorio_cadop (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Registro_ANS VARCHAR(20),
    CNPJ VARCHAR(20),
    Razao_Social VARCHAR(255),
    Nome_Fantasia VARCHAR(255),
    Modalidade VARCHAR(100),
    Logradouro VARCHAR(255),
    Numero VARCHAR(255),
    Complemento VARCHAR(255),
    Bairro VARCHAR(100),
    Cidade VARCHAR(100),
    UF CHAR(2),
    CEP VARCHAR(10),
    DDD VARCHAR(5),
    Telefone VARCHAR(20),
    Fax VARCHAR(20),
    Endereco_eletronico VARCHAR(255),
    Representante VARCHAR(255),
    Cargo_Representante VARCHAR(255),
    Regiao_de_Comercializacao VARCHAR(100),
    Data_Registro_ANS DATE
);

LOAD DATA LOCAL INFILE '../arquivos/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv'
INTO TABLE Relatorio_cadop
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@Registro_ANS, @CNPJ, @Razao_Social, @Nome_Fantasia, @Modalidade, @Logradouro, @Numero, 
 @Complemento, @Bairro, @Cidade, @UF, @CEP, @DDD, @Telefone, @Fax, 
 @Endereco_eletronico, @Representante, @Cargo_Representante, @Regiao_de_Comercializacao, @Data_Registro_ANS)
SET 
    Registro_ANS = NULLIF(@Registro_ANS, ''),
    CNPJ = NULLIF(@CNPJ, ''),
    Razao_Social = NULLIF(@Razao_Social, ''),
    Nome_Fantasia = NULLIF(@Nome_Fantasia, ''),
    Modalidade = NULLIF(@Modalidade, ''),
    Logradouro = NULLIF(@Logradouro, ''),
    Numero = NULLIF(REGEXP_REPLACE(TRIM(@Numero), '[^0-9]', ''), ''),
    Complemento = NULLIF(@Complemento, ''),
    Bairro = NULLIF(@Bairro, ''),
    Cidade = NULLIF(@Cidade, ''),
    UF = NULLIF(@UF, ''),
    CEP = NULLIF(@CEP, ''),
    DDD = NULLIF(@DDD, ''),
    Telefone = NULLIF(@Telefone, ''),
    Fax = NULLIF(@Fax, ''),
    Endereco_eletronico = NULLIF(@Endereco_eletronico, ''),
    Representante = NULLIF(@Representante, ''),
    Cargo_Representante = NULLIF(@Cargo_Representante, ''),
    Regiao_de_Comercializacao = NULLIF(@Regiao_de_Comercializacao, ''),
    Data_Registro_ANS = STR_TO_DATE(NULLIF(@Data_Registro_ANS, ''), '%Y-%m-%d');

DROP TABLE IF EXISTS demonstracoes_contabeis;
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    reg_ans VARCHAR(10),
    cd_conta_contabil VARCHAR(20),
    descricao TEXT,
    vl_saldo_inicial DECIMAL(20,2),
    vl_saldo_final DECIMAL(20,2)
);

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2023/1T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2023/2t2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2023/3T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2023/4T2023.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%d/%m/%Y'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2024/1T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2024/2T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2024/3T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');

LOAD DATA LOCAL INFILE '../arquivos/demonstracoes_contabeis/2024/4T2024.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data = STR_TO_DATE(@data, '%Y-%m-%d'),
    reg_ans = NULLIF(@reg_ans, ''),
    cd_conta_contabil = NULLIF(@cd_conta_contabil, ''),
    descricao = NULLIF(@descricao, ''),
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');