-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Wed Aug 24 22:03:46 2022 
-- * LUN file: C:\Users\bighi\source\repos\BASI DI DATI\DataBaseBasket\ER.lun 
-- * Schema: Basket Imola/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database Basket Imola;


-- DBSpace Section
-- _______________


-- Tables Section
-- _____________ 

create table acquista (
     idGiocatore char(1) not null,
     idMateriale char(1) not null,
     quantita char(1) not null,
     constraint ID_acquista_ID primary key (idGiocatore, idMateriale));

create table SCONTRINO (
     idScontrino char(15) not null,
     data char(1) not null,
     ora char(1) not null,
     valore char(1) not null,
     sconto char(1) not null,
     constraint ID_SCONTRINO_ID primary key (idScontrino));

create table ALLENAMENTO (
     nome char(1) not null,
     annata char(1) not null,
     giorno char(1) not null,
     ora char(1) not null,
     durata char(1) not null,
     idPalestra char(1) not null,
     constraint ID_ALLENAMENTO_ID primary key (nome, annata, giorno, ora));

create table ALLENATORE (
     idAllenatore char(1) not null,
     constraint ID_ALLENATORE_ID primary key (idAllenatore));

create table CAMPIONATO (
     livello char(1) not null,
     eta_max char(1) not null,
     constraint ID_CAMPIONATO_ID primary key (livello, eta_max));

create table CAMPO_ESTIVO (
     idCampoEstivo char(1) not null,
     anno char(1) not null,
     settimana char(1) not null,
     descrizione char(1) not null,
     constraint ID_CAMPO_ESTIVO_ID primary key (idCampoEstivo));

create table GIOCATORE (
     idGiocatore char(1) not null,
     nMaglia char(1) not null,
     nome char(1) not null,
     annata char(1) not null,
     constraint ID_GIOCATORE_ID primary key (idGiocatore));

create table MATERIALE (
     idMateriale char(1) not null,
     descrizione char(1) not null,
     disponibilita -- Compound attribute -- not null,
     prezzo char(1) not null,
     idScontrino char(1) not null,
     constraint ID_MATERIALE_ID primary key (idMateriale));

create table QUOTA (
     idQuota char(1) not null,
     idScontrino char(1) not null,
     anno char(1) not null,
     costo char(1) not null,
     idGiocatore char(1) not null,
     constraint ID_QUOTA_ID primary key (idQuota),
     constraint FKfattura_ID unique (idScontrino));

create table PALESTRA (
     idPalestra char(1) not null,
     indirizzo char(1) not null,
     nome char(1) not null,
     constraint ID_PALESTRA_ID primary key (idPalestra));

create table PARTITA (
     idPartita char(1) not null,
     data char(1) not null,
     ora char(1) not null,
     avversario char(1) not null,
     punti_fatti char(1) not null,
     punti_subiti char(1) not null,
     livello char(1) not null,
     eta_max char(1) not null,
     constraint ID_PARTITA_ID primary key (data, ora),
     constraint SID_PARTITA_ID unique (idPartita));

create table PERSONA (
     idGiocatore char(1),
     idAllenatore char(1),
     CF char(1) not null,
     nome char(1) not null,
     cognome char(1) not null,
     eta char(1) not null,
     telefono char(1) not null,
     email char(1) not null,
     constraint FKPER_GIO_ID unique (idGiocatore),
     constraint FKPER_ALL_ID unique (idAllenatore));

create table ATTREZZATURA (
     idAttrezzatura char(1) not null,
     descrizione char(1) not null,
     constraint ID_ATTREZZATURA_ID primary key (idAttrezzatura));

create table dispone (
     idAttrezzatura char(1) not null,
     quantita char(1) not null,
     idPalestra char(1) not null,
     constraint FKdis_ATT_ID primary key (idAttrezzatura));

create table iscritta (
     livello char(1) not null,
     eta_max char(1) not null,
     anno char(1) not null,
     nome char(1) not null,
     annata char(1) not null,
     constraint FKisc_CAM_ID primary key (livello, eta_max));

create table organizza (
     idAllenatore char(1) not null,
     idCampoEstivo char(1) not null,
     constraint ID_organizza_ID primary key (idAllenatore, idCampoEstivo));

create table partecipa (
     idCampoEstivo char(1) not null,
     idGiocatore char(1) not null,
     constraint ID_partecipa_ID primary key (idGiocatore, idCampoEstivo));

create table SQUADRA (
     idSquadra char(1) not null,
     nome char(1) not null,
     annata char(1) not null,
     nGiocatori char(1) not null,
     idAllenatore char(1) not null,
     constraint ID_SQUADRA_ID primary key (nome, annata),
     constraint SID_SQUADRA_ID unique (idSquadra));

create table STATISTICA_GIOCATORE (
     data char(1) not null,
     ora char(1) not null,
     idGiocatore char(1) not null,
     tiri_liberi char(1) not null,
     2_punti char(1) not null,
     3_punti char(1) not null,
     falli char(1) not null,
     rimbalzi char(1) not null,
     palle_recuperate char(1) not null,
     palle_perse char(1) not null,
     constraint ID_STATISTICA_GIOCATORE_ID primary key (data, ora, idGiocatore));

create table svolto (
     idCampoEstivo char(1) not null,
     idPalestra char(1) not null,
     constraint ID_svolto_ID primary key (idPalestra, idCampoEstivo));


-- Constraints Section
-- ___________________ 

alter table acquista add constraint FKacq_MAT_FK
     foreign key (idMateriale)
     references MATERIALE;

alter table acquista add constraint FKacq_GIO
     foreign key (idGiocatore)
     references GIOCATORE;

alter table SCONTRINO add constraint ID_SCONTRINO_CHK
     check(exists(select * from QUOTA
                  where QUOTA.idScontrino = idScontrino)); 

alter table ALLENAMENTO add constraint FKpratica
     foreign key (nome, annata)
     references SQUADRA;

alter table ALLENAMENTO add constraint FKeffettuato_FK
     foreign key (idPalestra)
     references PALESTRA;

alter table ALLENATORE add constraint ID_ALLENATORE_CHK
     check(exists(select * from PERSONA
                  where PERSONA.idAllenatore = idAllenatore)); 

alter table CAMPIONATO add constraint ID_CAMPIONATO_CHK
     check(exists(select * from iscritta
                  where iscritta.livello = livello and iscritta.eta_max = eta_max)); 

alter table GIOCATORE add constraint ID_GIOCATORE_CHK
     check(exists(select * from PERSONA
                  where PERSONA.idGiocatore = idGiocatore)); 

alter table GIOCATORE add constraint FKappartiene_FK
     foreign key (nome, annata)
     references SQUADRA;

alter table MATERIALE add constraint FKregistra_FK
     foreign key (idScontrino)
     references SCONTRINO;

alter table QUOTA add constraint FKfattura_FK
     foreign key (idScontrino)
     references SCONTRINO;

alter table QUOTA add constraint FKpaga_FK
     foreign key (idGiocatore)
     references GIOCATORE;

alter table PARTITA add constraint FKcostituito_FK
     foreign key (livello, eta_max)
     references CAMPIONATO;

alter table PERSONA add constraint EXTONE_PERSONA
     check((idAllenatore is not null and idGiocatore is null)
           or (idAllenatore is null and idGiocatore is not null)); 

alter table PERSONA add constraint FKPER_GIO_FK
     foreign key (idGiocatore)
     references GIOCATORE;

alter table PERSONA add constraint FKPER_ALL_FK
     foreign key (idAllenatore)
     references ALLENATORE;

alter table ATTREZZATURA add constraint ID_ATTREZZATURA_CHK
     check(exists(select * from dispone
                  where dispone.idAttrezzatura = idAttrezzatura)); 

alter table dispone add constraint FKdis_PAL_FK
     foreign key (idPalestra)
     references PALESTRA;

alter table dispone add constraint FKdis_ATT_FK
     foreign key (idAttrezzatura)
     references ATTREZZATURA;

alter table iscritta add constraint FKisc_SQU_FK
     foreign key (nome, annata)
     references SQUADRA;

alter table iscritta add constraint FKisc_CAM_FK
     foreign key (livello, eta_max)
     references CAMPIONATO;

alter table organizza add constraint FKorg_CAM_FK
     foreign key (idCampoEstivo)
     references CAMPO_ESTIVO;

alter table organizza add constraint FKorg_ALL
     foreign key (idAllenatore)
     references ALLENATORE;

alter table partecipa add constraint FKpar_GIO
     foreign key (idGiocatore)
     references GIOCATORE;

alter table partecipa add constraint FKpar_CAM_FK
     foreign key (idCampoEstivo)
     references CAMPO_ESTIVO;

alter table SQUADRA add constraint FKgestisce_FK
     foreign key (idAllenatore)
     references ALLENATORE;

alter table STATISTICA_GIOCATORE add constraint FKpossiede_FK
     foreign key (idGiocatore)
     references GIOCATORE;

alter table STATISTICA_GIOCATORE add constraint FKconta
     foreign key (data, ora)
     references PARTITA;

alter table svolto add constraint FKsvo_PAL
     foreign key (idPalestra)
     references PALESTRA;

alter table svolto add constraint FKsvo_CAM_FK
     foreign key (idCampoEstivo)
     references CAMPO_ESTIVO;


-- Index Section
-- _____________ 

create unique index ID_acquista_IND
     on acquista (idGiocatore, idMateriale);

create index FKacq_MAT_IND
     on acquista (idMateriale);

create unique index ID_SCONTRINO_IND
     on SCONTRINO (idScontrino);

create unique index ID_ALLENAMENTO_IND
     on ALLENAMENTO (nome, annata, giorno, ora);

create index FKeffettuato_IND
     on ALLENAMENTO (idPalestra);

create unique index ID_ALLENATORE_IND
     on ALLENATORE (idAllenatore);

create unique index ID_CAMPIONATO_IND
     on CAMPIONATO (livello, eta_max);

create unique index ID_CAMPO_ESTIVO_IND
     on CAMPO_ESTIVO (idCampoEstivo);

create unique index ID_GIOCATORE_IND
     on GIOCATORE (idGiocatore);

create index FKappartiene_IND
     on GIOCATORE (nome, annata);

create unique index ID_MATERIALE_IND
     on MATERIALE (idMateriale);

create index FKregistra_IND
     on MATERIALE (idScontrino);

create unique index ID_QUOTA_IND
     on QUOTA (idQuota);

create unique index FKfattura_IND
     on QUOTA (idScontrino);

create index FKpaga_IND
     on QUOTA (idGiocatore);

create unique index ID_PALESTRA_IND
     on PALESTRA (idPalestra);

create unique index ID_PARTITA_IND
     on PARTITA (data, ora);

create unique index SID_PARTITA_IND
     on PARTITA (idPartita);

create index FKcostituito_IND
     on PARTITA (livello, eta_max);

create unique index FKPER_GIO_IND
     on PERSONA (idGiocatore);

create unique index FKPER_ALL_IND
     on PERSONA (idAllenatore);

create unique index ID_ATTREZZATURA_IND
     on ATTREZZATURA (idAttrezzatura);

create index FKdis_PAL_IND
     on dispone (idPalestra);

create unique index FKdis_ATT_IND
     on dispone (idAttrezzatura);

create index FKisc_SQU_IND
     on iscritta (nome, annata);

create unique index FKisc_CAM_IND
     on iscritta (livello, eta_max);

create unique index ID_organizza_IND
     on organizza (idAllenatore, idCampoEstivo);

create index FKorg_CAM_IND
     on organizza (idCampoEstivo);

create unique index ID_partecipa_IND
     on partecipa (idGiocatore, idCampoEstivo);

create index FKpar_CAM_IND
     on partecipa (idCampoEstivo);

create unique index ID_SQUADRA_IND
     on SQUADRA (nome, annata);

create unique index SID_SQUADRA_IND
     on SQUADRA (idSquadra);

create index FKgestisce_IND
     on SQUADRA (idAllenatore);

create unique index ID_STATISTICA_GIOCATORE_IND
     on STATISTICA_GIOCATORE (data, ora, idGiocatore);

create index FKpossiede_IND
     on STATISTICA_GIOCATORE (idGiocatore);

create unique index ID_svolto_IND
     on svolto (idPalestra, idCampoEstivo);

create index FKsvo_CAM_IND
     on svolto (idCampoEstivo);

