------------------------------------------------------------

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

GO
CREATE INDEX [INDX_PK_GIOCATORE] ON [dbo].[GIOCATORE] ([IdGiocatore]);


----------------------------------------------------------------

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


GO
CREATE INDEX [INDX_PK_ALLENATORE] ON [dbo].[ALLENATORE] ([IdAllenatore]);

--------------------------------------------------

CREATE TABLE [dbo].[ATTREZZATURA] (
    [IdAttrezzatura]	INT	IDENTITY (1, 1) NOT NULL,
    [Descrizione]		VARCHAR (50) NOT NULL, 
	[Quantita]			INT NOT NULL DEFAULT 0,

    CONSTRAINT [PK_ATTREZZATURA] PRIMARY KEY ([IdAttrezzatura]),

);


GO
CREATE INDEX [INDX_PK_ATTREZZATURA] ON [dbo].[ATTREZZATURA] ([IdAttrezzatura]);

--------------------------------------------------
CREATE TABLE [dbo].[PALESTRA] (
    [IdPalestra] INT          IDENTITY (1, 1) NOT NULL,
    [Nome]       VARCHAR (10) NOT NULL,
    [Indirizzo]  VARCHAR (50) NOT NULL,

	[IdAttrezzatura] INT NOT NULL, 

    CONSTRAINT [PK_PALESTRA] PRIMARY KEY ([IdPalestra]), 
    CONSTRAINT [FK_dispone] FOREIGN KEY ([Idattrezzatura]) REFERENCES [ATTREZZATURA]([IdAttrezzatura]),


);


GO
CREATE INDEX [INDX_PK_PALESTRA] ON [dbo].[PALESTRA] ([IdPalestra])

GO
CREATE INDEX [INDX_FK_dispone] ON [dbo].[PALESTRA] ([IdAttrezzatura])

--------------------------------------------------

CREATE TABLE [dbo].[SQUADRA] (
	[IdSquadra]			INT          IDENTITY (1, 1) NOT NULL,
   	[Nome]				VARCHAR (15) NOT NULL,
    	[Annata]			INT          NOT NULL,
    	[NumeroGiocatori]	INT          DEFAULT ((0)) NOT NULL, 
	[Livello]			VARCHAR (15) NOT NULL,

	[IdAllenatore]	INT	NOT NULL,
	[IdGiocatore]	INT NOT NULL,

    CONSTRAINT [PK_SQUADRA] PRIMARY KEY ([IdSquadra]), 
    CONSTRAINT [FK_gestisce] FOREIGN KEY ([IdAllenatore]) REFERENCES [ALLENATORE]([IdAllenatore]), 
    CONSTRAINT [FK_appartiene] FOREIGN KEY ([IdGiocatore]) REFERENCES [GIOCATORE]([IdGiocatore]),
);


GO
CREATE INDEX [INDX_PK_SQUADRA] ON [dbo].[SQUADRA] ([IdSquadra]);

GO
CREATE INDEX [INDX_FK_gestisce] ON [dbo].[SQUADRA] ([IdAllenatore]);

GO
CREATE INDEX [INDX _FK_appartiene] ON [dbo].[SQUADRA] ([IdGiocatore]);


--------------------------------------------------

CREATE TABLE [dbo].[ALLENAMENTO] (
    [IdSquadra]		INT			NOT NULL,
    [IdPalestra]		INT			NOT NULL,
    [Giorno]		NCHAR (10)	NOT NULL,
    [Ora]			INT			NOT NULL,
	
	CONSTRAINT [FK_pratica]		FOREIGN KEY ([IdSquadra]) REFERENCES [SQUADRA] ([IdSquadra]), 
    	CONSTRAINT [FK_effettuato]	FOREIGN KEY ([IdPalestra]) REFERENCES [PALESTRA]([IdPalestra]),
	
	CONSTRAINT [PK_ALLENAMENTO] PRIMARY KEY ([IdSquadra], [Giorno], [Ora]), 

);


GO
CREATE INDEX [INDX_PK_ALLENAMENTO] ON [dbo].[ALLENAMENTO] ([IdSquadra], [Giorno], [Ora]);

GO
CREATE INDEX [INDX_FK_pratica] ON [dbo].[ALLENAMENTO] ([IdSquadra]);

GO
CREATE INDEX [INDX_FK_effettuato] ON [dbo].[ALLENAMENTO] ([IdPalestra]);

------------------------------------------------------

CREATE TABLE [dbo].[CAMPO_ESTIVO] (
    [IdCampoEstivo] INT          IDENTITY (1, 1) NOT NULL,
    [Anno]          INT          NOT NULL,
    [Settimana]     INT          NOT NULL,
    [Descrizione]   VARCHAR (50) NULL,

	[IdAllenatore]	INT NOT NULL,
	[IdGiocatore]	INT NOT NULL,
	[IdPalestra]	INT NOT NULL,

    CONSTRAINT [PK_CAMPO_ESTIVO] PRIMARY KEY ([IdCampoEstivo]), 

    CONSTRAINT [FK_organizza] FOREIGN KEY ([IdAllenatore]) REFERENCES [ALLENATORE]([IdAllenatore]),
    CONSTRAINT [FK_partecipa] FOREIGN KEY ([IdGiocatore]) REFERENCES [GIOCATORE]([IdGiocatore]), 
    CONSTRAINT [FK_svolto] FOREIGN KEY ([IdPalestra]) REFERENCES [PALESTRA]([IdPalestra]),

);


GO
CREATE INDEX [INDX_PK_CAMPO ESTIVO] ON [dbo].[CAMPO_ESTIVO] ([IdCampoEstivo]);



GO
CREATE INDEX [INDX_FK_organizza] ON [dbo].[CAMPO_ESTIVO] ([IdAllenatore]);

GO
CREATE INDEX [INDX_FK_partecipa] ON [dbo].[CAMPO_ESTIVO] ([IdGiocatore]);

GO
CREATE INDEX [INDX_FK_svolto] ON [dbo].[CAMPO_ESTIVO] ([IdPalestra]);

----------------------------------------------------------------------------------

CREATE TABLE [dbo].[PARTITA] (
    [IdPartita]   INT        IDENTITY (1, 1) NOT NULL,
    [Data]        DATE       NOT NULL,
    [Ora]         TIME (7)   NOT NULL,
    [Avversiario] NCHAR (10) NOT NULL,
    [PuntiFatti]  INT        NULL,
    [PuntiSubiti] INT        NULL, 

	[IdSquadra]		INT NOT NULL,
    
	CONSTRAINT [PK_PARTITA] PRIMARY KEY ([IdPartita]), 
    CONSTRAINT [FK_gioca] FOREIGN KEY ([IdSquadra]) REFERENCES [SQUADRA]([IdSquadra]),




);


GO
CREATE INDEX [INDX_PK_PARTITA] ON [dbo].[PARTITA] ([IdPartita]);

GO
CREATE INDEX [INDX_FK_gioca] ON [dbo].[PARTITA] ([IdSquadra]);

-----------------------------------------------------------------------------

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
	
    CONSTRAINT [FK_conta] FOREIGN KEY ([IdPartita]) REFERENCES [PARTITA]([IdPartita]), 
    CONSTRAINT [FK_possiede] FOREIGN KEY ([IdGiocatore]) REFERENCES [GIOCATORE]([IdGiocatore]), 

    CONSTRAINT [PK_STATISTICA_GIOCATORE] PRIMARY KEY ([IdPartita], [IdGiocatore]), 
);


GO
CREATE INDEX [INDX_PK_STATISTICA_GIOCATORE] ON [dbo].[STATISTICA_GIOCATORE] ([IdPartita], [IdGiocatore]);

GO
CREATE INDEX [INDX_FK_conta] ON [dbo].[STATISTICA_GIOCATORE] ([IdPartita]);

GO
CREATE INDEX [INDX_FK_possiede] ON [dbo].[STATISTICA_GIOCATORE] ([IdGiocatore]);

----------------------------------------------------------------------------------

CREATE TABLE [dbo].[SCONTRINO] (
    [IdScontrino] INT      IDENTITY (1, 1) NOT NULL,
    [Data]        DATE     NOT NULL,
    [Ora]         TIME (7) NOT NULL,
    [Valore]      INT      NOT NULL,
    [Sconto]      INT      NOT NULL DEFAULT 0, 
    [Quantita] INT NOT NULL DEFAULT 1, 

    CONSTRAINT [PK_SCONTRINO] PRIMARY KEY ([IdScontrino]),

);


GO

CREATE INDEX [INDX_PK_SCONTRINO] ON [dbo].[SCONTRINO] ([IdScontrino]);

---------------------------------------------------------------------------------

CREATE TABLE [dbo].[QUOTA] (
    [IdQuota] INT IDENTITY (1, 1) NOT NULL,
    [Anno]    INT NOT NULL,
    [Costo]   INT NOT NULL,
	
	[IdGiocatore] INT NOT NULL,
	[IdScontrino] INT NOT NULL,

    CONSTRAINT [PK_QUOTA] PRIMARY KEY ([IdQuota]), 
    CONSTRAINT [FK_paga] FOREIGN KEY ([IdGiocatore]) REFERENCES [GIOCATORE]([IdGiocatore]), 
    CONSTRAINT [FK_fattura] FOREIGN KEY ([IdScontrino]) REFERENCES [SCONTRINO]([IdScontrino]),

);




GO
CREATE INDEX [INDX_PK_QUOTA] ON [dbo].[QUOTA] ([IdQuota]);

GO
CREATE INDEX [INDX_FK_paga] ON [dbo].[QUOTA] ([IdGiocatore]);


GO
CREATE INDEX [INDX_FK_fattura] ON [dbo].[QUOTA] ([IdScontrino]);

---------------------------------------------------------------------------

CREATE TABLE [dbo].[MATERIALE] (
    [idMateriale]   INT            IDENTITY (1, 1) NOT NULL,
    [descrizione]   VARCHAR (50)   NOT NULL,
    [disponibilità] INT            DEFAULT ((0)) NOT NULL,
    [prezzo]        DECIMAL (3, 2) DEFAULT ((0)) NOT NULL,

   	[IdGiocatore] INT NOT NULL,
	[IdScontrino] INT NOT NULL,

    CONSTRAINT [PK_MATERIALE] PRIMARY KEY ([idMateriale]), 
    CONSTRAINT [FK_acquista] FOREIGN KEY ([IdGiocatore]) REFERENCES [GIOCATORE]([IdGiocatore]), 
    CONSTRAINT [FK_registra] FOREIGN KEY ([IdScontrino]) REFERENCES [SCONTRINO]([IdScontrino]),

);




GO
CREATE INDEX [INDX_PK_MATERIALE] ON [dbo].[MATERIALE] ([idMateriale]);

GO
CREATE INDEX [INDX_FK_acquista] ON [dbo].[MATERIALE] ([IdGiocatore]);


GO
CREATE INDEX [INDX_FK_registra] ON [dbo].[MATERIALE] ([IdScontrino]);