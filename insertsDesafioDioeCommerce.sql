use ecomerce;

insert into clients (Fname, Minit, Lname, CPF, Address)
	values ('Maria','M','Silva',21432423122,'X casa 23 - Cidade das flores'),
		   ('Mateus','O','Pimentel',43432112366,'X casa 234 - Cidade das flores'),
		   ('Ricardo','F','França',21432423188,'X casa 55 - Cidade das flores');
            

insert into product (Pname, classification_kids, category, avaliação, size) values
				('Fone',false,'eletronico','4',null),   
                ('Barbie',true,'brinquedos','3',null),
                ('Body',true,'vestimento','5',null);
                
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1);
                        
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,2,1,null),
                         (3,3,1,null);
                
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10);
                            
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,3,'GO');


insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 3425342652346,'1234567223'),
                            ('Eletrônicos Silva',5432113412,'565431234'),
                            ('Eletrônicos Valma', 5675233125235,'657486534');

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,3,633);
                       

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 42135151235, null, 'Rio de Janeiro', 213213214),
					    ('Botique Durgas',null,null,563226712,'Rio de Janeiro', 1241324),
						('Kids World',null,1234512356722,null,'São Paulo', 6564356234);

insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,3,80),
                         (2,1,10);
select * from productSeller;


select * from clients c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from orders;

-- recuperação de pedido com produto associado
select * from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder
		group by idClient; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 
