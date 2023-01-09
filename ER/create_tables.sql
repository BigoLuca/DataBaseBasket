+-- *********************************************
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


create table MOVIMENTO (
     id integer not null, 
     data date not null,
     totale integer not null, 
     direzione char(32) not null, 
     beneficiario char(256) not null, 
     causale char(256) not null, 
     idSede integer not null,
     constraint ID primary key (id),
     foreign key (idSede) references SEDE);

create table ACQUISTO (
     id integer not null, 
     valore integer not null, 
     idMovimento integer not null, 
     idSede integer not null, 
     constraint ID primary key (id),
     foreign key (idMovimento) references MOVIMENTO,
     foreign key (idSede) references SEDE);

create table SEDE (
     id integer not null,
     nome char(64),
     citta char(64),
     constraint ID primary key (id));

create table ALLENAMENTO (
     id integer not null,
     giorno_settimanale char(32) not null,
     ora_inizio integer not null,
     ora_fine integer not null,
     idSquadra integer not null,
     idPalestra integer not null,
     constraint ID primary key (id),
     foreign key (idSquadra) references SQUADRA,
     foreign key (idPalestra) references PALESTRA);

create table ALLENATORE (
     id integer not null,
     CF char(32) not null,
     nome char(32) not null,
     cognome char(64) not null,
     data_nascita date not null,
     telefono integer not null,
     email char(128) not null,
     idSede integer not null,
     constraint ID primary key (id),
     foreign key (idSede) references SEDE);

create table ATTREZZATURA (
     id integer not null,
     quantita integer not null,
     tipo char(64) not null,
     idPalestra integer not null,
     constraint ID primary key (id),
     foreign key (idPalestra) references PALESTRA);

create table CAMPO_ESTIVO (
     id integer not null,
     data_inizio date not null,
     descrizione char(256) not null,
     idPalestra integer,
     constraint ID primary key (id),
     foreign key (idPalestra) references PALESTRA);

create table GIOCATORE (
     id integer not null,
     nMaglia integer not null,
     CF char(64) not null,
     nome char(64) not null,
     cognome char(128) not null,
     data_nascita date not null,
     telefono integer not null,
     email char(128) not null,
     idSede integer not null,
     constraint ID primary key (id)
     foreign key (idSede) references SEDE);

create table MATERIALE (
     id integer not null,
     descrizione char(256) not null,
     disponibilità integer not null,
     prezzo integer not null,
     idSede integer not null,
     constraint ID primary key (id)
     foreign key (idSede) references SEDE);

create table PALESTRA (
     id integer not null,
     indirizzo char(256) not null,
     nome char(64) not null,
     constraint ID primary key (id));

create table PARTITA (
     id integer not null,
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
     constraint ID primary key (id),
     foreign key (idSquadra) references SQUADRA);

create table QUOTA (
     id integer not null,
     anno integer not null,
     costo integer not null,
     idGiocatore integer not null,
     idMovimento integer not null,
     constraint ID primary key (id),
     foreign key (idGiocatore) references GIOCATORE,
     foreign key (idMovimento) references MOVIMENTO);

create table SQUADRA (
     id integer not null,
     nome char(32) not null,
     annata integer not null,
     constraint ID primary key (id));

create table STATISTICA_GIOCATORE (
     id integer not null,
     tiri_liberi integer not null,
     due_punti integer not null,
     tre_punti integer not null,
     falli char(1) not null,
     rimbalzi integer not null,
     palle_recuperate integer not null,
     palle_perse integer not null,
     idPartita integer not null,
     idGiocatore integer not null,
     constraint ID primary key (id),
     foreign key (idPartita) references PARTITA,
     foreign key (idGiocatore) references GIOCATORE);

create table VENDITA (
     id integer not null,
     data date not null,
     costo_totale integer not null,
     quantita integer not null,
     idMateriale integer not null,
     idSede integer not null,
     constraint ID primary key (id),
     foreign key (idMateriale) references MATERIALE,
     foreign key (idSede) references SEDE);


create table appartiene (
     id integer primary key not null,
     idSquadra integer not null,
     idGiocatore integer not null);

create table gestisce (
     id integer primary key not null,
     idAllenatore integer not null,
     idSquadra integer not null);

create table partecipa (
     id integer primary key not null,
     idGiocatore integer not null,
     idCampoEstivo integer not null);

create table organizza (
     id integer primary key not null,
     idAllenatore integer not null,
     idCampoEstivo integer not null);

-- Index Section
-- _____________ 

