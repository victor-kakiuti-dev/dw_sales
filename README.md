  d w _ s a l e s

Projeto simples de ETL para criação de um DATAWARE HOUSE. 

Criei um projeto que simula a ideia de extrair dados brutos de uma base de dados e os transforma em um Data Warehouse (DW). Para isso, apliquei conhecimentos de modelagem, normalização e DML na construção do projeto.

O projeto utiliza SQL para extrair dados de uma base de dados que eu mesmo montei no MySQL e faz a tranferência para outra base de dados (o Data Warehouse), ainda dentro do mesmo SGBD.

Parte do tratamento dos dados precisou ser feita no Excel, pois os dados continham erros e não podiam ser carregados diretamente no banco de dados. Esses dados foram obtidos a partir de arquivos CSV disponibilizados no Kaggle. 

https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset

Antes de fazer os carregamentos criei o modelo conceitual do BD e do DW para que ilustrasse melhor tudo oque estava por trás dos códigos que seriam feitos.


                                          MODELO CONCEITUAL DO BANCO DE DADOS OLTP (Online Transaction Processing)

![sales1 drawio](https://github.com/user-attachments/assets/523923d7-dbfb-4bc0-862b-910faf82b50a)




                                          MODELO CONCEITUAL DO DATAWARE HOUSE

![sales_dw drawio](https://github.com/user-attachments/assets/04d41da3-d380-487c-8c55-8d61f98e3af5)



O projeto foi meu segundo desafio com dados e realmente aprendi bastante coisa com ele! Tive momentos em que travei e não sabia oque fazer mas também tive momentos em que as coisas se encaixavam e tudo ia bem. No fim das contas apesar de eu não ter conseguido disponibilizar toda a base de dados dentro do DATAWARE HOUSE (o meu computador não conseguiu carregar tudo de uma banco para o outro) acredito ter feito um bom trabalho e que tudo valeu a pena. 

# 📊 Projeto DW_Sales: ETL para Data Warehouse

## 📌 Descrição
Este projeto é uma simulação do processo de **ETL (Extração, Transformação e Carga)** para a criação de um **Data Warehouse (DW)**. 

- 📥 **Extração**: Dados brutos foram extraídos de arquivos CSV.
- 🔄 **Transformação**: Tratamento e limpeza de dados no **Excel**.
- 📤 **Carga**: Dados foram armazenados em um **Data Warehouse** no **MySQL**.

Durante o desenvolvimento, apliquei conhecimentos de **modelagem, normalização e DML (Data Manipulation Language)** para estruturar os bancos de dados de forma eficiente. O projeto envolveu a transferência dos dados de um **banco transacional (OLTP)** para um **Data Warehouse (DW)** dentro do mesmo **SGBD (MySQL)**.

## 🚀 Tecnologias Utilizadas
- 🛢️ **MySQL** – Banco de dados OLTP e Data Warehouse
- 📊 **Excel** – Tratamento de dados
- 📂 **Kaggle** – Fonte dos dados (CSV)
- 🔎 **SQL** – Extração, transformação e carga dos dados

## 🔧 Estrutura do Projeto
1. **Modelagem conceitual** do banco de dados OLTP e do Data Warehouse.
2. **Extração de dados** a partir de arquivos CSV.
3. **Transformação** e limpeza de dados no Excel.
4. **Carga de dados** no Data Warehouse usando SQL.
5. **Consultas e validação** para análise dos dados no DW.

## 📜 Modelagem Conceitual

### 🏢 **Banco de Dados OLTP (Online Transaction Processing)**
![sales1 drawio](https://github.com/user-attachments/assets/523923d7-dbfb-4bc0-862b-910faf82b50a)

### 📊 **Data Warehouse (DW)**
![sales_dw drawio](https://github.com/user-attachments/assets/04d41da3-d380-487c-8c55-8d61f98e3af5)

## 📎 Fonte de Dados
Os dados utilizados neste projeto foram extraídos do **Kaggle**, através do seguinte dataset:

🔗 **[Grocery Sales Dataset](https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset)**

## 📖 Experiência e Aprendizado
Este foi meu segundo desafio com **dados** e aprendi muito ao longo do caminho! 🙌

- **Dificuldades:** Tive momentos de **bloqueio**, sem saber como avançar.
- **Conquistas:** Quando as coisas começaram a **se encaixar**, foi gratificante ver os resultados.
- **Limitações:** Meu computador não conseguiu **carregar toda a base de dados** para o DW, mas ainda assim consegui estruturar e validar o processo.

No fim, fiquei muito satisfeito com o que aprendi e desenvolvi! 🚀

---

## 💡 Como Executar o Projeto
1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/dw_sales.git
   cd dw_sales
   ```
2. **Importe os arquivos CSV no MySQL.**
3. **Execute os scripts SQL para criar as tabelas e realizar a ETL.**
4. **Realize consultas no Data Warehouse para análise dos dados.**

📌 **Caso tenha dúvidas ou sugestões, sinta-se à vontade para contribuir!** 😊

                          
                                                    
 
