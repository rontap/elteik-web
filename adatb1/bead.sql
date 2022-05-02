select vdani.get_bead('G07ZOE') from dual;
set serveroutput on;

-- Tatai Áron (G07ZOE): 7. beadandó 

--- ==============================
--- I. - Táblák létrehozása
--- ==============================
drop table iro;
drop table konyv;
drop table bolt;
drop table szallitas;
drop table kiado;
/*
Készíts adatbázist egy könyvkiadó cég számára.
Hozz létre táblákat tetszőleges attribútumokkal a 
-- szerzőknek, 
-- könyveknek, 
-- boltoknak, 
-- szállításoknak.
++ kiadó
*/
create table iro (
    szig char(6) primary key, -- személyazonosító
    nev varchar2(50) not null,
    szul_ido date not null
);

create table kiado (
     nev varchar(50) primary key,
     motto varchar(200),
     alapitas date
);

create table bolt (
    nev varchar(50) primary key,
    hely varchar(80),
    weblap varchar(50)
);

create table konyv (
    iro char(6) references iro(szig),
    kiado varchar2(50),
    isbn char(8) primary key,
    nev varchar(50) not null,
    ar number not null
);


create table szallitas (
    azon number primary key,
    konyv_isbn char(8) references konyv(isbn),
    hova varchar2(50) references bolt(nev),
    db number check (db > 0)  
);


--- ==============================
--- II. Adatok feltöltése
--- ==============================

insert into iro values (
    'RU6677', 'Isaac Asimov', to_date('1901.01.05','YYYY.MM.DD') );
    
insert into iro values (
    'UK5647', 'JK Rowling', to_date('1965.07.31','YYYY.MM.DD') );
    
insert into iro values (
    'HU6222', 'Böszörményi Gyula', to_date('1965.07.11','YYYY.MM.DD') );
    
insert into iro values (
    'US7862', 'Noam Chomsky', to_date('1924.11.05','YYYY.MM.DD') );
    
insert into iro values (
    'UK4633', 'GRRM', to_date('1901.01.05','YYYY.MM.DD') );
    
insert into kiado values (
    'Könyvmolyképző', 'Könyvmolyokat képzunk!',null );
    
insert into kiado values (
    'Guetemberg', 'Books.',to_date('1455','YYYY'));    
    
insert into kiado values (
    'Pearson', 'Do you like Pears Son?', to_date('1900.01','YYYY.MM'));
    
insert into kiado values (
    'Penguin books', 'Revolutionizing books since 1963', to_date('1963.05','YYYY.MM'));    
    
insert into kiado values (
    'MacMillan Publishin', 'Welcome to McWorld of McBooks', to_date('1999.05','YYYY.MM'));        

insert into bolt values (
    'Libri Westend', 'Bp. westend', 'libri.hu/westend');
    
insert into bolt values (
    'Libri Árkád', 'Bp. árkád i', 'libri.hu/arkad');
    
insert into bolt values (
    'Libri Etele', 'Bp. etele', 'libri.hu/etele');
    
insert into bolt values (
    'ELTE Könyvesbolt', 'Elte E-234626.26', 'bolt.konyv.inf.elte.hu/main.aspx');
    
insert into bolt values (
    'Konyvi', 'Szatmárcseke', null);
    
insert into bolt values (
    'Gigashop', 'UK, london, Picadilly', 'giga.shop.uk.co');    

--- DINAMIKUS ADATOK ============================== 
    
insert into konyv values (
    'UK5647',
    'Penguin books',
    'HP10UK',
    'Harry Potter I.',    4000
);

insert into konyv values (
    'UK5647',
    'Penguin books',
    'HP11UK',
    'Harry Potter II.',    4950
);
insert into konyv values (
    'UK5647',
    'Penguin books',
    'HP12UK',
    'Harry Potter III.',    4800
);
insert into konyv values (
    'UK5647',
    'Pearson',
    'HP13UK',
    'Harry Potter IV.',    4500
);
insert into konyv values (
    'US7862',
    'Guetemberg',
    'NC03UK',
    'Automaták és Manufucatured Consent',    18000
);
insert into konyv values (
    'US7862',
    'Pearson',
    'NC53US',
    'Grammatikák és Politika',    19850
);
insert into konyv values (
    'UK4633',
    'MacMillan Publishin',
    'GOT007',
    'Winds of Winter',    250
);
insert into konyv values (
    'RU6677',
    'Penguin books',
    'EVILAI',
    'Teljes Gép Univerzum Automatizált Alapítvány',    19850
);
insert into konyv values (
    'HU6222',
    'Könyvmolyképző',
    'HU5950',
    'Gergő és a Titkok kamrája',    5950
);

insert into konyv values (
    'UK4633',
    'MacMillan Publishin',
    'GOT011',
    'Hope of new Book',    45
);


insert into szallitas values  (
    0,
    'HU5950',
    'Libri Etele',    80
);
insert into szallitas values  (
    1,
    'HU5950',
    'Libri Árkád',    90
);
insert into szallitas values  (
    2,
    'HP10UK',
    'Libri Westend',    50
);
insert into szallitas values  (
    3,
    'HP10UK',
    'ELTE Könyvesbolt',    50
);
insert into szallitas values  (
    4,
    'HP11UK',
    'ELTE Könyvesbolt',    1
);
insert into szallitas values  (
    5,
    'HP12UK',
    'Konyvi',    85
);
insert into szallitas values  (
    6,
    'HP13UK',
    'Gigashop',    79
);
insert into szallitas values  (
    7,
    'NC03UK',
    'Gigashop',    790
);
insert into szallitas values  (
    8,
    'GOT007',
    'Libri Westend',    21
);

--- ==============================
--- III. {A} Feladat
--- ==============================
/* 
Írj PL/SQL procedúrát, amely kiírja a paraméterül megkapott szerző 
legnépszerűbb könyvének a címét. 
Ha az adott szerző nem létezik, kezeld kivételként és írj ki értelmes hibaüzenetet.
*/
create or replace view konyveladas
    as (select konyv_isbn isbn,sum(db) db from szallitas s
    join konyv
    on konyv.isbn = s.konyv_isbn
    group by konyv_isbn
);
select * from konyveladas;
select * from szallitas;


create or replace procedure legnepszerubb( c_nev varchar) is
    res varchar2(50);

begin
    select nev into res from 
        (select * from konyveladas natural join konyv isbn 
         where iro=
                (select szig from iro where nev=c_nev and rownum = 1
                )
         order by konyveladas.db desc 
        )
    where rownum = 1 ;
    
    dbms_output.put_line(
        res
    );
exception
    when others then
    dbms_output.put_line(
        'Hiba! Nem létezik Ilyen Szerző!!'
    );
end;
/

call legnepszerubb('JK Rowling'); -- harry potter i.
call legnepszerubb('Noam Chomsky'); -- automaták
call legnepszerubb('Peti'); -- hibakezelés
    
--- ==============================
--- IV.  {B} Feladat
--- ==============================
/*
Írk PL/SQL függvényt, amely módosító kruzor segítségével 
megnöveli a könyvek árát 10%-al. Töltsd be kollekcióba a könyvek címeit és árait. 
A függény adja meg azt, hogy hány könyv ára magasabb, mint a könyvek átlagára.  
*/

--create table konyvx as select * from konyv;
select * from konyvx;


create or replace function inflalas return numeric is 
    --PRAGMA AUTONOMOUS_TRANSACTION;    
       
    summ numeric := 0;
    cnt numeric := 0;
    av numeric := 0;
    res numeric;
    
    type k_base is table of number
        index by varchar(50);
  
    ks k_base;    
    
    cursor c1 is
        select * from konyv
        for update of ar;      
begin

    for sor in c1 loop
         update konyv set ar = round(ar + ar * 0.1) where current of c1;
         ks(sor.nev) := sor.ar;   
         
         av := av + round(sor.ar + sor.ar * 0.1);
         cnt := cnt + 1;
    end loop;
   
    select count(isbn)  into res from konyv where ar > (av/cnt);
    
    
    --commit;
    return res;
end;
/

declare 
    o number;
begin
    o := inflalas();
    dbms_output.put_line('Atlagnal nagyobbak: ' ||o);
end;
/

/*
insert into konyv values (
    'UK5647',
    'Pearson',
    'LALAL6',
    'Magna Charta',    100000000002
);

*/

select * from konyv ;

--- ==============================
--- V.   {C} Feladat
--- ==============================
/* 
Hozz létre egy triggert, 
amely új könyv beszúrása esetén kiírja a szerző könyveinek számát.
*/



CREATE OR REPLACE TRIGGER uj_konyv
BEFORE INSERT ON konyv
FOR EACH ROW 
DECLARE 
   curr_iro char(6); 
   cnt numeric;
BEGIN 
   curr_iro := :new.iro;
   select count(isbn) into cnt from konyv where iro=curr_iro;
   dbms_output.put_line('In Sert');
   dbms_output.put_line('Író Könyveinek száma: ' || (cnt+1));
END; 
/

insert into konyv values (
    'UK5647',
    'Pearson',
    'HP14UK',
    'Harry Potter V.',    9589
);

