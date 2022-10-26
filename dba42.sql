select ServerName=@@ServerName, DatabaseName=DB_NAME(), UserName=suser_sname()
go
drop table if exists t42
go
create table t42(
   c1 int primary key,
   c2 char(32)
);
go
insert into t42 values(1, 'Monza')
insert into t42 values(2, 'Fortytwo')
go
select * from t42
go
