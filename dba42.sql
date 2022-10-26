select ServerName=@@ServerName, DatabaseName=DB_NAME(), UserName=suser_sname()
go
create table t42(
   c1 int primary key,
   c2 char(32)
);
go
insert into t42 values(1, 'Monza')
insert into t42 values(2, 'Fortytwo')
go
select * from dbo.t42
go
