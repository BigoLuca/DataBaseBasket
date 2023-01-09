-- OP1 Inserire allenatore
INSERT INTO ALLENATORE (CF, nome, cognome, eta, telefono, email) 
VALUES (?, ?, ?, ?, ?, ?);

-- OP2 Inserire giocatore assegnandogli una squadra
INSERT INTO GIOCATORE (CF, nome, cognome, eta, telefono, email, nMaglia)
VALUES (?, ?, ?, ?, ?, ?,?);
INSERT INTO appartiene (idGiocatore, idSquadra)
VALUES (?, ?);

-- OP3 Visualizzare il numero totale di persone della società
SELECT 
(SELECT COUNT(*) FROM ALLENATORE) + 
(SELECT COUNT(*) FROM GIOCATORE);

-- OP4 Creare una squadra
INSERT INTO SQUADRA (nome, annata, nGiocatori)
VALUES (?, ?, ?);

-- OP5 Modificare annata di una squadra
UPDATE SQUADRA
WHERE ID = ?
SET annata = ?;

-- OP6 Rimuovere un giocatore da una squadra
DELETE FROM appartiene
WHERE GIOCATORE.id = ?;

-- OP7 Assegnare un allenatore ad una squadra
INSERT INTO gestisce (idAllenatore, idSquadra)
VALUES(?, ?);

-- OP8 Visualizzare i giocatori di una squadra
SELECT GIOCATORE
FROM appartiene A, GIOCATORE G
WHERE A.idGiocatore = G.idGiocatore AND A.idSquadra = ?;

-- OP9 Assegnare un giocatore ad un campo estivo
INSERT INTO partecipa (idGiocatore, idCampoEstivo)
VALUES (?, ?);

-- OP10 Assegnare un allenatore ad un campo estivo
INSERT INTO organizza (idAllenatore, idCampoEstivo)
VALUES (?, ?);

-- OP11 Visualizzare i giocatori di un campo estivo
SELECT GIOCATORE
FROM partecipa P
WHERE P.idCampoEstivo = ?;

-- OP12 Visualizzare le attrezzature di una palestra
SELECT ATTREZZATURA
FROM ATTREZZATURA A
WHERE A.idPalestra = ?;

-- OP13 Visualizzare le partite di una squadra tra due date
SELECT PARTITA
FROM PARTITA P
WHERE P.idSquadra = ?
AND P.data BETWEEN ? AND ?;

-- OP14 Visualizzare i campionati giocati da una squadra negli anni (in ordine decrescente)
SELECT PARTITA.campionato_anno, PARTITA.campionato_nome, PARTITA.campionato_livello 
FROM PARTITA P
WHERE P.idSquadra = ?
ORDER BY P.campionato_anno DESC;

-- OP15 Visualizzare gli allenamenti di una squadra e in che palestra
SELECT ALLENAMENTO, PALESTRA
FROM ALLENAMENTO A, PALESTRA P
WHERE A.idPalestra = P.idPalestra 
AND A.idSquadra = ?;
-- alternativa con join
SELECT *
FROM ALLENAMENTO 
JOIN PALESTRA
ON A.idPalestra = P.idPalestra;
WHERE A.idSquadra = ?;

-- OP-16 Acquistare x paia di calzini
-- Innanzitutto, bisogna controllare che gli oggetti desiderati siano disponibili. 
SELECT disponibilita -- Se ritorna un valore alloa OK
FROM MATERIALE
WHERE idMateriale = ? 
AND disponibilita >= ?;
-- Creo un Movimento
INSERT INTO MOVIMENTO (id, data, totale, direzione, beneficiario, causale, idSede)
VALUES (?, GETDATE(), ?, ?, ?, ?, ?);
-- Creo un nuovo acquisto
INSERT INTO ACQUISTO (id, valore, idMovimento, idSede) 
VALUES (?, ?, ?, ?);
-- A questo punto bisogna diminuire la quantità dell’oggetto. 
UPDATE MATERIALE
SET quantita = quantita - ? 
WHERE idMateriale = ?;

-- OP-17 Visualizzare i materiali disponibili
SELECT MATERIALI;

-- OP18 Visualizzare numero di vendite fatte nelle varie sedi
SELECT SEDE, COUNT(*) AS N_VENDITE
FROM ACQUISTO A
WHERE A.idSede = S.idSede
GROUP BY SEDE.idSede;

-- OP-19 Visualizzare numero di giocatori in ogni squadra
SELECT SQUARA, COUNT(GIOCATORE) AS Giocatori
GROUP BY SQUADRA.idSquadra;

-- OP20 Visualizzare i movimenti e il guadagno totale in un periodo di una sede
SELECT *
FROM MOVIMENTO
AND MOVIMENTO.idSede = ?
WHERE data BETWEEN ? AND ?

SELECT(	SELECT SUM(MOVIMENTO.totale)
		FROM MOVIMENTO
		WHERE MOVIMENTO.direzione = "entrata"
		AND MOVIMENTO.idSede = ?
		AND MOVIMENTO.data BETWEEN ? ANd ?
		-
		SELECT SUM(MOVIMENTO.totale)
		FROM MOVIMENTO
		WHERE MOVIMENTO.direzione = "uscita"
		AND MOVIMENTO.idSede = ?
		AND MOVIMENTO.data BETWEEN ? ANd ?
		);


