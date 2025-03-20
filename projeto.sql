--                                    CRIAÇÃO DA PRIMEIRA DATABASE

CREATE DATABASE sales1;

USE sales1;


CREATE TABLE sales (
	sales_id INT PRIMARY KEY,
    sales_person_id INT,
    customer_id INT,
    product_id INT,
    quantity INT,
    discount INT, 
    total_price INT,
    sales_date DATE,
    transaction_number varchar(12)
);



/* Para inserir os dados nas tabelas tive que abrir o MYSQL pelo CMD através do seguinte 
código:
  mysql -u root -p --local-infile=1
Vale resaltar que estou usando um sistema Windows10*/
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(64),
    price FLOAT(10,2),
    category_id INT,
    class 	VARCHAR(6),
    modify_date DATE,
    resistant VARCHAR(10),
    is_alergic VARCHAR(10),
    vitality_days INT
);



-- Aqui o arquivo CSV estava usando ';' como separador. Tive que usar FIELDS TERMINATED BY ';' 
-- para o SQL saber qual era o separador correto
LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;



/* Ao fazer a inserção dos dados de PRODUCTS percebi que muitas datas estavam como NULL, visualizei no 
EXCEL e percebi que os dados estavam com a data no formato do Brasil, oque eu fiz? Deletei a
tabela, fiz o tratamento dessas datas no EXCEL colocando-as no padrão do MYSQL ISO 8601 e voltei a 
inserir os dados na tabela.*/
CREATE TABLE employees (
	employee_id INT PRIMARY KEY,
    first_name VARCHAR(16),
    middle_initial CHAR(1),
    last_name VARCHAR(16),
    birth_date DATETIME,
    gender CHAR(1),
    city_id INT,
    hire_date DATETIME
);



LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    first_name VARCHAR(16),
    middle_initial CHAR(1),
    last_name VARCHAR(16),
    city_id INT,
    address VARCHAR(32)
);



LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\customers.csv'
INTO TABLE  customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE countries (
	country_id INT PRIMARY KEY,
    country_name VARCHAR(20),
    country_code CHAR(2)
);

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\countries.csv'
INTO TABLE  countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE cities (
	city_id INT PRIMARY KEY,
    city_name VARCHAR(16),
    zipcode INT,
    country_id INT
);



LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\cities.csv'
INTO TABLE  cities
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE categories (
	category_id INT PRIMARY KEY,
    category_name VARCHAR(16)
);



LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\categories.csv'
INTO TABLE  categories
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;








--                                  INSERÇÃO DAS CHAVES ESTRANGEIRAS                     


-- Agora começo a inserção das chaves estrangeiras
ALTER TABLE sales
ADD CONSTRAINT fk_sales_employees FOREIGN KEY (sales_person_id) REFERENCES employees(employee_id);


/* O MYSQL retornou um erro dizendo que minha tabela tem datas irregulares, e que essas datas eram 
'0000-00-00'. Resolvi investigar o caso e consultei o número de linhas que tinham essa data.*/
SELECT sales_date, count(*)
FROM sales
WHERE sales_date = '0000-00-00'
GROUP BY sales_date;


/* Essa consulta me gerou um outro erro dizendo que eu não poderia fazer essa consulta porquê o SQL não
 aceita o registro '0000-00-00'. Dei uma pesquisada e descobri que o comando abaixo desativaria esse tipo
 de restrição para que eu pudesse executar minha consulta*/
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';


/* Apóes executar a QUERY descobri que 1% dos meus dados tinham valores irregulares. Resolvi fazer um 
UPDATE deixando todos esses valores como NULL*/
UPDATE sales
SET sales_date = NULL
WHERE sales_date = '0000-00-00';


/* Finalmente consigo usar o comando de inserção de chave entrangeira com sucesso*/
ALTER TABLE sales
ADD CONSTRAINT fk_sales_employees FOREIGN KEY (sales_person_id) REFERENCES employees(employee_id);


/* Para testar tento fazer uma inserção na tabela, uma inserção que viola a chave estrangeira. 
Como eu sei que a chave está funcionando? Ao inserir um registro que viola a chave estrangeira o MYSQL 
retorna um erro dizendo que eu estou violando a chave.*/
INSERT INTO sales 
(sales_id, sales_person_id, customer_id, product_id, quantity, discount, total_price, sales_date, transaction_number)
 VALUES (999999999, 2147483647, 1, 1, 1, 0, 0,'1993-12-19', 'OHFDO231');

 
 
-- Inserindo mais uma chave na tabela sales 
ALTER TABLE sales
ADD CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);


ALTER TABLE sales
ADD CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Para inserir a chave abaixo tive que passar por um processo parecido com o da primeira chave
ALTER TABLE products
ADD CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(category_id);


/* A coluna modify_date estava com registros '0000-00-00'. Resolvi contar quantos desses registros haviam
na tabela e descobri que 369 dos 452 registros existentes na tabela estavam como '0000-00-00'*/ 
SELECT modify_date, count(*)
FROM products
WHERE modify_date = '0000-00-00'
GROUP BY modify_date;  369


-- Transformando os registros em NULL
UPDATE products
SET modify_date = NULL
WHERE modify_date = '0000-00-00';


-- Adicionando a chave
ALTER TABLE products
ADD CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(category_id);



-- As chaves a seguir foram inseridas sem problemas
ALTER TABLE employees
ADD CONSTRAINT fk_employee_city FOREIGN KEY (city_id) REFERENCES cities(city_id);

ALTER TABLE customers
ADD CONSTRAINT fk_customers_city FOREIGN KEY (city_id) REFERENCES cities(city_id);

ALTER TABLE cities
ADD CONSTRAINT fk_cities_countries FOREIGN KEY (country_id) REFERENCES countries(country_id);


/* Criando indíces para a tabela SALES */

CREATE INDEX idx_sales_person_id ON sales(sales_person_id);

CREATE INDEX idx_customer_id ON sales(customer_id);

CREATE INDEX idx_product_id ON sales(product_id);

CREATE INDEX idx_sales_date ON sales(sales_date);


--                            CRIAÇÃO DA SEGUNDA DATABASE (DATA WAREHOUSE)

CREATE DATABASE sales_dw;

USE sales_dw;


/* Criação da tabela dim_date. A tabela dim_date é uma referência a cada data da coluna sales_date 
da tabela sales da database sales1.*/
CREATE TABLE dim_date (
	date_key INT PRIMARY KEY,
    date_value DATE,
    day INT,
    month INT,
    year INT,
    quarter INT,
    day_name VARCHAR(10),
    month_name VARCHAR(10)
);


/*Inserindo os dados na tabela dim_date.*/
INSERT INTO dim_date (date_key, date_value, day, month, year, quarter, day_name, month_name)
SELECT
	(YEAR(sales_date)*10000 + MONTH(sales_date) * 100 + DAY(sales_date)) as date_key,
    /* Acima eu multiplico o ano por 10000, somo com o valor do mês multiplicado por 100 e adiciono o 
    valor da data criando um identificador único para cada data e esse identificador é o próprio valor
    da data.*/
    sales_date,
    DAY(sales_date) AS day,
    MONTH(sales_date) AS month,
    YEAR(sales_date) AS year,
    QUARTER(sales_date) AS quarter,
    DAYNAME(sales_date) AS day_name,
    MONTHNAME(sales_date) AS month_name
FROM (SELECT DISTINCT sales_date FROM sales1.sales WHERE sales_date IS NOT NULL) AS dates;


CREATE TABLE dim_product (
  product_key INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT,
  product_name VARCHAR(64),
  price FLOAT(10,2),
  category_id INT,
  class VARCHAR(6),
  modify_date DATE,
  resistant VARCHAR(10),
  is_alergic VARCHAR(10),
  vitality_days INT
);

/* Pegando os dados da tabela sales1.product e inserindo na tabela sales_dw.dim_product */
INSERT INTO dim_product (product_id, product_name, price, category_id, class, modify_date, resistant, is_alergic, vitality_days)
SELECT product_id, product_name, price, category_id, class, modify_date, resistant, is_alergic, vitality_days
FROM sales1.products;


CREATE TABLE dim_employee (
  employee_key INT PRIMARY KEY AUTO_INCREMENT,
  employee_id INT,
  first_name VARCHAR(16),
  middle_initial CHAR(1),
  last_name VARCHAR(16),
  birth_date DATETIME,
  gender CHAR(1),
  city_id INT,
  hire_date DATETIME
);

/* Pegando os dados da tabela sales1.employees e inserindo na tabela sales_dw.dim_employee*/
INSERT INTO dim_employee (employee_id, first_name, middle_initial, last_name, birth_date, gender, city_id, hire_date)
SELECT employee_id, first_name, middle_initial, last_name, birth_date, gender, city_id, hire_date
FROM sales1.employees;




CREATE TABLE dim_customer (
  customer_key INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  first_name VARCHAR(16),
  middle_initial CHAR(1),
  last_name VARCHAR(16),
  city_id INT,
  address VARCHAR(32)
);

/* Pegando os dados da tabela sales1.customers e inserindo na tabela sales_dw.dim_customer*/
INSERT INTO dim_customer (customer_id, first_name, middle_initial, last_name, 
city_id, address)
SELECT customer_id, first_name, middle_initial, last_name, city_id, address
FROM sales1.customers;


/* Aqui temos a tabela fact_sales que une todas as tabelas dimensão do dataware house. Ela pega dados
da tabela sales1.sales e das demais tabelas do banco sales_dw.*/
CREATE TABLE fact_sales (
  sales_id INT PRIMARY KEY,
  employee_key INT,
  customer_key INT,
  product_key INT,
  quantity INT,
  discount INT, 
  total_price INT,
  date_key INT,
  transaction_number VARCHAR(12)
);



-- Inserindo as chaves estrangeiras na tabela fact_sales
ALTER TABLE fact_sales
ADD CONSTRAINT fk_sales_employee FOREIGN KEY (employee_key) REFERENCES dim_employee(employee_key);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_sales_customer FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_sales_product FOREIGN KEY (product_key) REFERENCES dim_product(product_key);

ALTER TABLE fact_sales
ADD CONSTRAINT fk_sales_date  FOREIGN KEY (date_key) REFERENCES dim_date(date_key);


/* Inserindo os dados na tabela fact_sales. Como a tabela tinha mais de 6 milhões de linhas e 
estava travando meu PC para fazer a inserção resolvi fazendo apenas uma amostra dos dados com 100 mil linhas*/
INSERT INTO fact_sales (sales_id, employee_key, customer_key, product_key, quantity, discount, total_price, date_key, transaction_number)
SELECT 
    s.sales_id,
    de.employee_key,
    dc.customer_key,
    dp.product_key,
    s.quantity,
    s.discount, 
    s.total_price,
    dd.date_key,
    s.transaction_number
FROM sales1.sales s
INNER JOIN dim_employee de ON s.sales_person_id = de.employee_id
INNER JOIN dim_customer dc ON s.customer_id = dc.customer_key
INNER JOIN dim_product dp ON s.product_id = dp.product_key
INNER JOIN dim_date dd ON s.sales_date = dd.date_value
LIMIT 100000; 


-- Criando índices para a tabela fact_sales
CREATE INDEX idx_fact_sales_sales ON fact_sales(sales_id);

CREATE INDEX idx_fact_sales_employee ON fact_sales(employee_key);

CREATE INDEX idx_fact_sales_customer ON fact_sales(customer_key);

CREATE INDEX idx_fact_sales_product ON fact_sales(product_key);

CREATE INDEX idx_fact_sales_date ON fact_sales(date_key);

SHOW INDEXES FROM fact_sales;



