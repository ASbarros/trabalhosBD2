//dando permissao
GRANT SELECT ON aviao TO mateus_silva;
GRANT SELECT ON tipo_aviao TO mateus_silva;
//pegando as permissoes
select * from mateus_silva.aviao;
---------------------------------------------------
create table aviao2(
nregavi number primary key,
modtipoavi varchar2(200) not null);
----------------------------------------------------------
desc tipo_aviao
create table tipo_aviao2(
   modtipoavi varchar2(100) primary key,
   fabtipoavi varchar2(100),
   captipoavi number,
   pesotipoavi number);
-----------------------------------------------------
select * from aviao2
 --------------------------------------------------
-------copiando a tabela aviao-----------
declare
cursor c_aviao2 is
    select *
    from aviao;

begin
for v_aviao2 in c_aviao2 loop
   insert into aviao2(nregavi, modtipoavi)
   values (v_aviao2.nregavi, v_aviao2.modtipoavi);
end loop;
end;
-----------------------------------------------------------------------------
-------copiando a tabela tipo_aviao--------------
declare
cursor c_tipoaviao2 is
    select *
    from tipo_aviao;

begin
for v_tipo_aviao2 in c_tipoaviao2 loop
   insert into tipo_aviao2(modtipoavi, fabtipoavi, captipoavi, pesotipoavi)
   values (v_tipo_aviao2.modtipoavi, v_tipo_aviao2.fabtipoavi,v_tipo_aviao2.captipoavi,v_tipo_aviao2.pesotipoavi);
end loop;
end;
------------------------------------------------
select * from tipo_aviao2
------------------------------------------------
declare 
cursor c_tipo_aviao2 is 
    select * 
    from tipo_aviao2;
cursor c_tipo_aviao2_aux is
    select *
    from mateus_silva.tipo_aviao;

existe number := 0;
begin 
for v_tipo_aviao2_aux in c_tipo_aviao2_aux loop
    existe := 0;
    for v_tipo_aviao2 in c_tipo_aviao2 loop
        if v_tipo_aviao2.modtipoavi = v_tipo_aviao2_aux.modtipoavi then
            existe := 1;
        end if;
    end loop;
    if existe = 0 then
        insert into tipo_aviao2(modtipoavi, fabtipoavi, captipoavi, pesotipoavi)
        values (v_tipo_aviao2_aux.modtipoavi, v_tipo_aviao2_aux.fabtipoavi,v_tipo_aviao2_aux.captipoavi,v_tipo_aviao2_aux.pesotipoavi);
    end if;
end loop;
end;
----------------------------------------------------------------------------
------sequencia----------------------------
create sequence sequence_aviao2
    start with 18
    increment by 1;

declare 

cursor c_aviao2_aux is
    select *
    from mateus_silva.aviao;

begin 
for v_aviao2_aux in c_aviao2_aux loop
    insert into aviao2(nregavi, modtipoavi)
    values (sequence_aviao2.nextVal, v_aviao2_aux.modtipoavi);
end loop;
end;