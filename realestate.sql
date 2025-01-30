create database realEstate;
use realEstate;

-- agents table
create table Agents(agent_id int primary key auto_increment, name varchar(20), 
email varchar(20) unique, phone varchar(20), commission decimal(5,2));

insert into Agents (name,email,phone,commission) values ('rohith','rohith.d@gmail.com',9150320499,2.5);
insert into Agents (name,email,phone,commission) values ('ram','ram.20@gmail.com',925032000,3.0);

-- client table
create table clients(client_id int primary key auto_increment, name varchar(20), 
email varchar(50) unique, phone varchar(20));

insert into clients (name,email,phone) values('siva','siva@gmail.com','9042320188');
insert into clients (name,email,phone) values('prem','prem@gmail.com','90423000188');

-- properties table
create table Properties(property_id int primary key auto_increment,
address varchar(50) not null, city varchar(20), 
state varchar(20), price int, agent_id int, 
status enum('available','sold') default 'available', 
foreign key(agent_id) references Agents(agent_id));

insert into Properties(address,city,state,price,agent_id,status) values ('111 roh st','chennai','tn',500000,1,'available');
insert into Properties(address,city,state,price,agent_id,status) values ('222 hor tt','goa','g',750000,2,'sold');

-- transaction table
create table Transactions(transaction_id int primary key auto_increment,
property_id int, client_id int, agent_id int, sale_price int, transaction_date date,
foreign key (property_id) references Properties(property_id),
foreign key (client_id) references clients(client_id),
foreign key (agent_id) references Agents(agent_id));

insert into Transactions(property_id,client_id,agent_id,sale_price,transaction_date) values (2,1,2,720000,'2024-01-29');

select * from Properties;
select * from clients;
select * from agents;
select * from transactions;

-- join
select p.address,p.city,p.state,p.price,
a.name as agent_name,a.email as agent_email,a.phone as agent_ph_no 
from Properties p join agents a on p.agent_id = a.agent_id;

-- view
create view sold_properties as select p.property_id,p.address,p.city,p.state,
t.sale_price,t.transaction_date from transactions t 
join properties p on t.property_id = p.property_id 
join agents a on t.agent_id = a.agent_id
join clients c on t.client_id = c.client_id;

select * from sold_properties;
drop view sold_properties;

-- subquery
select name, email from agents where agent_id in (select distinct agent_id from transactions);

-- procedure
delimiter &&
create procedure GetSoldPropertyCount()
begin
select count(*) as SoldPropertiesCount from transactions;
end &&
delimiter ;

call GetSoldPropertyCount();
drop procedure GetSoldPropertyCount;
