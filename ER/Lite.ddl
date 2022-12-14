-- *********************************************
-- * SQL SQLite generation                     
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Wed Dec 14 17:55:56 2022 
-- * LUN file: C:\Users\tella_tasat48\Workspace\DataBaseBasket\ER\ER.lun 
-- * Schema: Basket Imola/3-Logico 
-- ********************************************* 


-- Database Section
-- ________________ 


-- Tables Section
-- _____________ 

create table ALLENAMENTO (
     idAllenamento numeric(32) not null,
     giorno char(32) not null,
     ora numeric(10) not null,
     durata numeric(10,3) not null,
     idSquadra numeric(32) not null,
     idPalestra numeric(32) not null,
     constraint IDALLENAMENTO primary key (idAllenamento),
     foreign key (idSquadra) references SQUADRA,
     foreign key (idPalestra) references PALESTRA);

create table ALLENATORE (
     idAllenatore numeric(32) not null,
     CF char(32) not null,
     nome char(32) not null,
     cognome char(64) not null,
     data nascita date not null,
     telefono numeric(64) not null,
     email char(128) not null,
     constraint IDALLENATORE primary key (idAllenatore));

create table ATTREZZATURA (
     idAttrezzatura numeric(32) not null,
     quantita numeric(10) not null,
     tipo char(64) not null,
     idPalestra numeric(32) not null,
     constraint IDATTREZZATURA primary key (idAttrezzatura),
     foreign key (idPalestra) references PALESTRA);

create table CAMPO_ESTIVO (
     idCampoEstivo numeric(32) not null,
     data_inizio date not null,
     descrizione char(256) not null,
     idPalestra numeric(32),
     idAllenatore numeric(32) not null,
     idGiocatore numeric(32),
     constraint IDCAMPO_ESTIVO primary key (idCampoEstivo),
     foreign key (idPalestra) references PALESTRA,
     foreign key (idAllenatore) references ALLENATORE,
     foreign key (idGiocatore) references GIOCATORE);

create table GIOCATORE (
     idGiocatore numeric(32) not null,
     nMaglia numeric(32) not null,
     CF char(64) not null,
     nome char(64) not null,
     cognome char(128) not null,
     data nascita date not null,
     telefono numeric(32) not null,
     email char(128) not null,
     idSquadra numeric(32) not null,
     constraint IDGIOCATORE primary key (idGiocatore));

create table MATERIALE (
     idMateriale numeric(32) not null,
     idGiocatore numeric(32),
     descrizione char(256) not null,
     disponibilità numeric(64) not null,
     prezzo numeric(64) not null,
     idAllenatore numeric(32) not null,
     constraint IDMATERIALE primary key (idMateriale),
     foreign key (idGiocatore) references GIOCATORE);

create table PALESTRA (
     idPalestra numeric(32) not null,
     indirizzo char(256) not null,
     nome char(64) not null,
     constraint IDPALESTRA primary key (idPalestra));

create table PARTITA (
     idPartita numeric(32) not null,
     idStatistica numeric(32),
     data date not null,
     ora numeric(32) not null,
     avversario char(128) not null,
     punti_fatti numeric(32) not null,
     punti_subiti numeric(32) not null,
     campionato_livello char(32) not null,
     campionato_nome char(64) not null,
     campionato_anno numeric(32) not null,
     idSquadra numeric(32) not null,
     constraint IDPARTITA primary key (idPartita),
     foreign key (idSquadra) references SQUADRA);

create table QUOTA (
     idGiocatore numeric(32) not null,
     anno numeric(32) not null,
     costo numeric(32) not null,
     constraint IDQUOTA primary key (idGiocatore, anno),
     foreign key (idGiocatore) references GIOCATORE);

create table SQUADRA (
     idSquadra numeric(32) not null,
     idGiocatore numeric(32),
     nome char(32) not null,
     annata numeric(16) not null,
     nGiocatori numeric(16) not null,
     idAllenatore numeric(32) not null,
     constraint IDSQUADRA primary key (idSquadra),
     foreign key (idAllenatore) references ALLENATORE,
     foreign key (idGiocatore) references GIOCATORE);

create table STATISTICA_GIOCATORE (
     idStatistica numeric(32) not null,
     tiri_liberi numeric(16) not null,
     due_punti numeric(16) not null,
     tre_punti numeric(16) not null,
     falli char(1) not null,
     rimbalzi numeric(16) not null,
     palle_recuperate numeric(16) not null,
     palle_perse numeric(16) not null,
     idPartita numeric(32) not null,
     idGiocatore numeric(32) not null,
     constraint IDSTATISTICA_GIOCATORE primary key (idStatistica),
     foreign key (idPartita) references PARTITA,
     foreign key (idGiocatore) references GIOCATORE);


-- Index Section
-- _____________ 

