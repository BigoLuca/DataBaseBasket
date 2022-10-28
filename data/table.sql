
CREATE TABLE [dbo].[GIOCATORE] (
    [IdGiocatore]   INT          IDENTITY (1, 1) NOT NULL,
    [Nome]          VARCHAR (15) NOT NULL,
    [Cognome]       VARCHAR (20) NOT NULL,
    [Età]           INT          NOT NULL,
    [Telefono]      INT          NULL,
    [E-mail]        VARCHAR (50) NULL,
    [NumeroMaglia]  INT          NOT NULL,
    [CodiceFiscale] CHAR (16)    NOT NULL, 

    CONSTRAINT [PK_GIOCATORE] PRIMARY KEY ([IdGiocatore]),
);


CREATE TABLE [dbo].[ALLENATORE] (
    [IdAllenatore]  INT          IDENTITY (1, 1) NOT NULL,
    [Nome]          VARCHAR (15) NOT NULL,
    [Cognome]       VARCHAR (20) NOT NULL,
    [CodiceFiscale] CHAR (16)    NOT NULL,
    [Età]           INT          NOT NULL,
    [Telefono]      INT          NULL,
    [E-mail]        VARCHAR (50) NULL, 

    CONSTRAINT [PK_ALLENATORE] PRIMARY KEY ([IdAllenatore]),
	
);


CREATE TABLE [dbo].[ATTREZZATURA] (
    [IdAttrezzatura]	INT	IDENTITY (1, 1) NOT NULL,
    [Descrizione]		VARCHAR (50) NOT NULL, 
	[Quantita]			INT NOT NULL DEFAULT 0,

    CONSTRAINT [PK_ATTREZZATURA] PRIMARY KEY ([IdAttrezzatura]),

);

CREATE TABLE [dbo].[PALESTRA] (
    [IdPalestra] INT          IDENTITY (1, 1) NOT NULL,
    [Nome]       VARCHAR (10) NOT NULL,
    [Indirizzo]  VARCHAR (50) NOT NULL,

	[IdAttrezzatura] INT NOT NULL, 

    CONSTRAINT [PK_PALESTRA] PRIMARY KEY ([IdPalestra]), 

);


CREATE TABLE [dbo].[SQUADRA] (
	[IdSquadra]			INT          IDENTITY (1, 1) NOT NULL,
   	[Nome]				VARCHAR (15) NOT NULL,
    	[Annata]			INT          NOT NULL,
    	[NumeroGiocatori]	INT          DEFAULT ((0)) NOT NULL, 
	[Livello]			VARCHAR (15) NOT NULL,

	[IdAllenatore]	INT	NOT NULL,
	[IdGiocatore]	INT NOT NULL,

    CONSTRAINT [PK_SQUADRA] PRIMARY KEY ([IdSquadra]), 
);


CREATE TABLE [dbo].[ALLENAMENTO] (
    [IdSquadra]		INT			NOT NULL,
    [IdPalestra]		INT			NOT NULL,
    [Giorno]		NCHAR (10)	NOT NULL,
    [Ora]			INT			NOT NULL,
	
	CONSTRAINT [PK_ALLENAMENTO] PRIMARY KEY ([IdSquadra], [Giorno], [Ora]), 

);

CREATE TABLE [dbo].[CAMPO_ESTIVO] (
    [IdCampoEstivo] INT          IDENTITY (1, 1) NOT NULL,
    [Anno]          INT          NOT NULL,
    [Settimana]     INT          NOT NULL,
    [Descrizione]   VARCHAR (50) NULL,

	[IdAllenatore]	INT NOT NULL,
	[IdGiocatore]	INT NOT NULL,
	[IdPalestra]	INT NOT NULL,

    CONSTRAINT [PK_CAMPO_ESTIVO] PRIMARY KEY ([IdCampoEstivo]), 
);

CREATE TABLE [dbo].[PARTITA] (
    [IdPartita]   INT        IDENTITY (1, 1) NOT NULL,
    [Data]        DATE       NOT NULL,
    [Ora]         TIME (7)   NOT NULL,
    [Avversiario] NCHAR (10) NOT NULL,
    [PuntiFatti]  INT        NULL,
    [PuntiSubiti] INT        NULL, 

	[IdSquadra]		INT NOT NULL,
    
	CONSTRAINT [PK_PARTITA] PRIMARY KEY ([IdPartita]), 

);

CREATE TABLE [dbo].[STATISTICA_GIOCATORE]
(
	
	
	[TirtiLiberi] INT NULL DEFAULT 0, 
    [DuePunti] INT NULL DEFAULT 0, 
    [TrePunti] INT NULL DEFAULT 0, 
    [Falli] INT NULL DEFAULT 0, 
    [Rimbalzi] INT NULL DEFAULT 0, 
    [Recuperate] INT NULL DEFAULT 0, 
    [Perse] INT NULL DEFAULT 0,

	[IdPartita] INT NOT NULL,
	[IdGiocatore] INT NOT NULL, 

    CONSTRAINT [PK_STATISTICA_GIOCATORE] PRIMARY KEY ([IdPartita], [IdGiocatore]), 
);


CREATE TABLE [dbo].[SCONTRINO] (
    [IdScontrino] INT      IDENTITY (1, 1) NOT NULL,
    [Data]        DATE     NOT NULL,
    [Ora]         TIME (7) NOT NULL,
    [Valore]      INT      NOT NULL,
    [Sconto]      INT      NOT NULL DEFAULT 0, 
    [Quantita] INT NOT NULL DEFAULT 1, 

    CONSTRAINT [PK_SCONTRINO] PRIMARY KEY ([IdScontrino]),

);

CREATE TABLE [dbo].[QUOTA] (
    [IdQuota] INT IDENTITY (1, 1) NOT NULL,
    [Anno]    INT NOT NULL,
    [Costo]   INT NOT NULL,
	
	[IdGiocatore] INT NOT NULL,
	[IdScontrino] INT NOT NULL,

    CONSTRAINT [PK_QUOTA] PRIMARY KEY ([IdQuota]), 
);

CREATE TABLE [dbo].[MATERIALE] (
    [idMateriale]   INT            IDENTITY (1, 1) NOT NULL,
    [descrizione]   VARCHAR (50)   NOT NULL,
    [disponibilità] INT            DEFAULT ((0)) NOT NULL,
    [prezzo]        DECIMAL (3, 2) DEFAULT ((0)) NOT NULL,

   	[IdGiocatore] INT NOT NULL,
	[IdScontrino] INT NOT NULL,

    CONSTRAINT [PK_MATERIALE] PRIMARY KEY ([idMateriale]), 

);