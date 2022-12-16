-- *********************************************
-- * SQL SQLite generation                     
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Wed Dec 14 18:32:35 2022 
-- * LUN file: C:\Users\tella_tasat48\Workspace\DataBaseBasket\ER\ER.lun 
-- * Schema: Basket Imola/3-Logico 
-- ********************************************* 


-- Database Section
-- ________________ 


-- Tables Section
-- _____________ 

create table SEDE (
     idSede integer not null,
     nome char(64),
     citta char(64),
     constraint IDSEDE primary key (idSede));

create table ALLENAMENTO (
     idAllenamento integer not null,
     giorno char(32) not null,
     ora integer not null,
     durata integer not null,
     idSquadra integer not null,
     idPalestra integer not null,
     constraint IDALLENAMENTO primary key (idAllenamento),
     foreign key (idSquadra) references SQUADRA,
     foreign key (idPalestra) references PALESTRA);

create table ALLENATORE (
     idAllenatore integer not null,
     CF char(32) not null,
     nome char(32) not null,
     cognome char(64) not null,
     data nascita date not null,
     telefono integer not null,
     email char(128) not null,
     idSede integer not null,
     constraint IDALLENATORE primary key (idAllenatore)
     foreign key (idSede) references SEDE);

create table ATTREZZATURA (
     idAttrezzatura integer not null,
     quantita integer not null,
     tipo char(64) not null,
     idPalestra integer not null,
     constraint IDATTREZZATURA primary key (idAttrezzatura),
     foreign key (idPalestra) references PALESTRA);

create table CAMPO_ESTIVO (
     idCampoEstivo integer not null,
     data_inizio date not null,
     descrizione char(256) not null,
     idPalestra integer,
     constraint IDCAMPO_ESTIVO primary key (idCampoEstivo),
     foreign key (idPalestra) references PALESTRA);

create table GIOCATORE (
     idGiocatore integer not null,
     nMaglia integer not null,
     CF char(64) not null,
     nome char(64) not null,
     cognome char(128) not null,
     data_nascita date not null,
     telefono integer not null,
     email char(128) not null,
     idSede integer not null,
     constraint IDGIOCATORE primary key (idGiocatore)
     foreign key (idSede) references SEDE);

create table MATERIALE (
     idMateriale integer not null,
     descrizione char(256) not null,
     disponibilità integer not null,
     prezzo integer not null,
     constraint IDMATERIALE primary key (idMateriale));

create table PALESTRA (
     idPalestra integer not null,
     indirizzo char(256) not null,
     nome char(64) not null,
     constraint IDPALESTRA primary key (idPalestra));

create table PARTITA (
     idPartita integer not null,
     idStatistica integer,
     data date not null,
     ora integer not null,
     avversario char(128) not null,
     punti_fatti integer not null,
     punti_subiti integer not null,
     campionato_livello char(32) not null,
     campionato_nome char(64) not null,
     campionato_anno integer not null,
     idSquadra integer not null,
     constraint IDPARTITA primary key (idPartita),
     foreign key (idSquadra) references SQUADRA);

create table QUOTA (
     idGiocatore integer not null,
     anno integer not null,
     costo integer not null,
     constraint IDQUOTA primary key (idGiocatore, anno),
     foreign key (idGiocatore) references GIOCATORE);

create table SQUADRA (
     idSquadra integer not null,
     nome char(32) not null,
     annata integer not null,
     constraint IDSQUADRA primary key (idSquadra));

create table STATISTICA_GIOCATORE (
     idStatistica integer not null,
     tiri_liberi integer not null,
     due_punti integer not null,
     tre_punti integer not null,
     falli char(1) not null,
     rimbalzi integer not null,
     palle_recuperate integer not null,
     palle_perse integer not null,
     idPartita integer not null,
     idGiocatore integer not null,
     constraint IDSTATISTICA_GIOCATORE primary key (idStatistica),
     foreign key (idPartita) references PARTITA,
     foreign key (idGiocatore) references GIOCATORE);

create table VENDITA (
     idVendita integer not null,
     data date not null,
     costo_totale integer not null,
     quantita integer not null,
     idMateriale integer not null,
     idSede integer not null,
     constraint IDSEDE primary key (idVendita);
     foreign key (idMateriale) references MATERIALE,
     foreign key (idSede) references SEDE);


create table appartiene (
     idRel integer primary key not null,
     idSquadra integer not null,
     idGiocatore integer not null);

create table gestisce (
     idRel integer primary key not null,
     idAllenatore integer not null,
     idSquadra integer not null);

create table partecipa (
     idRel integer primary key not null,
     idGiocatore integer not null,
     idCampoEstivo integer not null);

create table organizza (
     idRel integer primary key not null,
     idAllenatore integer not null,
     idCampoEstivo integer not null);

-- Index Section
-- _____________ 

