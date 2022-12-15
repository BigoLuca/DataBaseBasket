-- OP1 Inserire allenatore
INSERT INTO ALLENATORE (CF, nome, cognome, eta, telefono, email) 
VALUES (?, ?, ?, ?, ?, ?)

-- OP2 Inserire giocatore assegnandogli una squadra
INSERT INTO GIOCATORE (CF, nome, cognome, eta, telefono, email, nMaglia)
VALUES (?, ?, ?, ?, ?, ?,?)
INSERT INTO appartiene (idGiocatore, idSquadra)
VALUES (?, ?)
UPDATE SQUADRA
SET nGiocatori = nGiocatori + 1

-- OP3 Visualizzare il numero totale di persone della società
SELECT COUNT (*) AS persone
FROM ALLENATORE, GIOCATORE

-- OP4 Creare una squadra
INSERT INTO SQUADRA (idSquadra, nome, annata, nGiocatori)
VALUES (?, ?, ?, ?)

-- OP5 Modificare annata di una squadra
UPDATE SQUADRA
SET annata = ?

-- OP6 Rimuovere un giocatore da una squadra
DELETE FROM appartiene
WHERE GIOCATORE.idGiocatore = ?
UPDATE SQUADRA
WHERE SQUADRA.idSquadra = ?
SET nGiocatori = nGiocatori - 1

-- OP7 Assegnare un allenatore ad una squadra
INSERT INTO gestisce (idAllenatore, idSquadra)
VALUES (?, ?)

-- OP8 Visualizzare i giocatori di una squadra
SELECT GIOCATORE
FROM appartiene A, GIOCATORE G
WHERE A.idGiocatore = G.idGiocatore AND A.idSquadra = ?

-- OP9 Assegnare un giocatore ad un campo estivo
INSERT INTO partecipa (idGiocatore, idCampoEstivo)
VALUES (?, ?)

-- OP10 Assegnare un allenatore ad un campo estivo
INSERT INTO organizza (idAllenatore, idCampoEstivo)
VALUES (?, ?)

-- OP11 Visualizzare i giocatori di un campo estivo
SELECT GIOCATORE
FROM partecipa P
WHERE P.idCampoEstivo = ?

-- OP12 Visualizzare le attrezzature di una palestra
SELECT ATTREZZATURE, dispone.quantita
FROM dispone D
WHERE D.idPalestra = ?

-- OP13 Visualizzare le partite di una squadra
SELECT PARTITA
FROM PARTITA P
WHERE P.idSquadra = ?

OP-14 Visualizzare il campionato di ogni squadra
SELECT CAMPIONATO, SQUADRA.idSquadra
FROM iscritta I
WHERE iscritta.anno = ?
OP-15 Visualizzare gli allenamenti di una squadra
SELECT ALLENAMENTO
WHERE pratica.idSquadra = ?
OP-16 Acquistare x paia di calzini
Innanzitutto, bisogna controllare che gli oggetti desiderati siano disponibili. 
SELECT disponibilita 
FROM MATERIALE
WHERE idMateriale = ? 
AND disponibilita >= ?
Una volta controllato che l’oggetto sia disponibile, procedo all’acquisto aggiungendo una nuova vendita. 
INSERT INTO acquisto (idGiocatore, idMateriale, quantita) 
VALUES (?, ?, ?)
Creo un nuovo scontrino
INSERT INTO SCONTRINO (idScontrino, data, ora, valore, sconto) 
VALUES (?, GETDATE(), ?, ?, ?)
A questo punto bisogna diminuire la quantità dell’oggetto. 
UPDATE MATERIALE
SET quantita = quantita - ? 
WHERE idMateriale = ?
OP-17 Visualizzare i materiali disponibili
SELECT MATERIALI 
OP-18 Visualizzare il guadagno totale
SELECT SUM(valore) AS guadagno
FROM SCONTRINO S 
I dati da inserire sono la data iniziale e la data finale fra cui visualizzare i guadagni (estremi inclusi), la costante 105 indica il formato italiano per DateTime (gg-mm-aaaa) 
WHERE S.data BETWEEN CONVERT(DATETIME, ?, 105) AND CONVERT(DATETIME, ?, 105)+1 
Nel caso si voglia inserire solo l’anno
WHERE DATEPART(yyyy, P.data) = ?
OP-19 Visualizzare numero di giocatori in una squadra
SELECT SQUADRA.nGiocatori
WHERE  SQUADRA.idSquadra = ?
