-- *********************************************
-- * SQL SQLite generation                     
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Wed Dec 14 15:50:57 2022 
-- * LUN file: C:\Users\tella_tasat48\Workspace\DataBaseBasket\ER\ER.lun 
-- * Schema: Basket Imola/3-Logico 
-- ********************************************* 


-- Database Section
-- ________________ 


-- Tables Section
-- _____________ 

create table ALLENAMENTO (
     idAllenamento char(1) not null,
     giorno char(1) not null,
     ora char(1) not null,
     durata char(1) not null,
     idSquadra char(1) not null,
     idPalestra char(1) not null,
     constraint IDALLENAMENTO primary key (idAllenamento),
     foreign key (idSquadra) references SQUADRA,
     foreign key (idPalestra) references PALESTRA);

create table ALLENATORE (
     idAllenatore char(1) not null,
     CF char(1) not null,
     nome char(1) not null,
     cognome char(1) not null,
     data nascita char(1) not null,
     telefono char(1) not null,
     email char(1) not null,
     constraint IDALLENATORE primary key (idAllenatore));

create table ATTREZZATURA (
     quantità -- Compound attribute -- not null,
     tipo attrezzo char(1) not null,
     idPalestra char(1) not null,
     constraint IDATTREZZATURA primary key (tipo attrezzo),
     foreign key (idPalestra) references PALESTRA);

create table CAMPO ESTIVO (
     idCampoEstivo char(1) not null,
     anno char(1) not null,
     settimana char(1) not null,
     descrizione char(1) not null,
     idPalestra char(1),
     idAllenatore char(1) not null,
     idGiocatore char(1),
     constraint IDCAMPO ESTIVO primary key (idCampoEstivo),
     foreign key (idPalestra) references PALESTRA,
     foreign key (idAllenatore) references ALLENATORE,
     foreign key (idGiocatore) references GIOCATORE);

create table GIOCATORE (
     idGiocatore char(1) not null,
     nMaglia char(1) not null,
     CF char(1) not null,
     nome char(1) not null,
     cognome char(1) not null,
     data nascita char(1) not null,
     telefono char(1) not null,
     email char(1) not null,
     constraint IDGIOCATORE primary key (idGiocatore) --,
--     check(exists(select * from MATERIALE
--                  where MATERIALE.idGiocatore = idGiocatore)) 
 --,
--     check(exists(select * from SQUADRA
--                  where SQUADRA.idGiocatore = idGiocatore)) 
);

create table MATERIALE (
     idMateriale char(1) not null,
     idGiocatore char(1),
     descrizione char(1) not null,
     disponibilità -- Compound attribute -- not null,
     prezzo char(1) not null,
     idAllenatore char(1) not null,
     constraint IDMATERIALE primary key (idMateriale),
     constraint FKacquista1 unique (idGiocatore),
     foreign key (idGiocatore) references GIOCATORE);

create table PALESTRA (
     idPalestra char(1) not null,
     indirizzo char(1) not null,
     nome char(1) not null,
     constraint IDPALESTRA primary key (idPalestra));

create table PARTITA (
     idPartita char(1) not null,
     idStatistica char(1),
     data char(1) not null,
     ora char(1) not null,
     avversario char(1) not null,
     punti fatti char(1) not null,
     punti subiti char(1) not null,
     Campionato -- Compound attribute -- not null,
     constraint IDPARTITA primary key (idPartita) --,
--     check(exists(select * from SQUADRA
--                  where SQUADRA.idPartita = idPartita)) 
);

create table QUOTA (
     idGiocatore char(1) not null,
     anno char(1) not null,
     costo char(1) not null,
     constraint IDQUOTA primary key (idGiocatore, anno),
     foreign key (idGiocatore) references GIOCATORE);

create table SQUADRA (
     idSquadra char(1) not null,
     idGiocatore char(1),
     nome char(1) not null,
     annata char(1) not null,
     nGiocatori char(1) not null,
     idPartita char(1),
     idAllenatore char(1) not null,
     constraint FKappartiene unique (idGiocatore),
     constraint IDSQUADRA primary key (idSquadra),
     foreign key (idGiocatore) references GIOCATORE,
     foreign key (idPartita) references PARTITA,
     foreign key (idAllenatore) references ALLENATORE);

create table STATISTICA GIOCATORE (
     idStatistica char(1) not null,
     tiri liberi char(1) not null,
     2 punti char(1) not null,
     3 punti char(1) not null,
     falli char(1) not null,
     rimbalzi char(1) not null,
     palle recuperate char(1) not null,
     palle perse char(1) not null,
     idPartita char(1) not null,
     idGiocatore char(1) not null,
     constraint IDSTATISTICA GIOCATORE primary key (idStatistica),
     foreign key (idPartita) references PARTITA,
     foreign key (idGiocatore) references GIOCATORE);


-- Index Section
-- _____________ 

