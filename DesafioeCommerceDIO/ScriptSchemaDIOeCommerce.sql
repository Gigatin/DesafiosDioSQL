-- criação de banco de dados para o e-commerce

--  drop database ecomerce;
create database ecomerce;

use ecomerce;

-- tabela cliente

create table clients(
 idClient int auto_increment primary key,
 Fname varchar(10),
 Minit char(3),
 Lname varchar(20),
 CPF char(11) not null,
 Adress varchar(30),
 constraint unique_cpf_client unique(CPF)
);

alter table clients auto_increment=1;

-- tabela produto
create table product(
 idProduct int auto_increment primary key,
 Pname varchar(10),
 classifcation_kids bool,
 category enum('eletronico','vestimento','brinquedos','alimentos','moveis') not null,
 avaliação float default 0,
 size varchar(10)
);

-- tabela payments

create table payments(
	idclient int,
    id_payment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limiteAvaliable float,
    primary key(idClient, id_payment)
);



-- tabela pedido
create table orders(
idOrder int auto_increment primary key,
idOrderClient int,
orderStatus enum('cancelado', 'confirmado', 'processamento') default 'processamento',
orderDescription varchar(255),
sandValue float default 10, 
idpayment int,
paymentCash bool default false,
-- constraint fk_ordes_payment foreign key (idpayment) references payments(id_payment),
constraint fk_ordes_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
 );
desc orders;
 
 -- tabela estoque
 create table productStorage(
	idProdstorage int auto_increment primary key,
	storageLocation varchar(255),
    quantity int default 0
 );
 
 
 -- tabela fornecedor
  create table supplier (
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
	constraint unique_supplier unique (CNPJ)
  );
 
 -- tabela vendedor
create table seller (
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
AbstName varchar(255),
CNPJ char(15),
CPF char(9),
location varchar(255),
contact char(11) not null,
constraint unique_cnpj_seller unique (CNPJ),
constraint unique_cpf_seller unique (CPF)
); 


-- tabela produto vendido
create table productSeller(
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references product (idProduct)
);

create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum ('disponivel', 'sem estoque') default 'disponivel',
primary key (idPOproduct,idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct,idLstorage),
constraint fk_storage_location_product_seller foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_product foreign key (idLstorage) references productStorage (idProdstorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPSsupplier, idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)

);

show tables;

show databases;
