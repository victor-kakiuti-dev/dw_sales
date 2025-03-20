# 📊 Projeto DW_Sales: ETL para Data Warehouse

## 📌 Descrição
Este projeto é uma simulação do processo de **ETL (Extração, Transformação e Carga)** para a criação de um **Data Warehouse (DW)**. 

- 📥 **Extração**: Dados brutos foram extraídos de arquivos CSV.
- 🔄 **Transformação**: Tratamento e limpeza de dados no **Excel**.
- 📤 **Carga**: Dados foram armazenados em um **Data Warehouse** no **MySQL**.

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



                          
                                                    
 
