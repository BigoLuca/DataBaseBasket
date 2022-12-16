-- OP1 Inserire allenatore
INSERT INTO ALLENATORE (CF, nome, cognome, eta, telefono, email) 
VALUES (?, ?, ?, ?, ?, ?);

-- OP2 Inserire giocatore assegnandogli una squadra
INSERT INTO GIOCATORE (CF, nome, cognome, eta, telefono, email, nMaglia)
VALUES (?, ?, ?, ?, ?, ?,?);
INSERT INTO appartiene (idGiocatore, idSquadra)
VALUES (?, ?);

-- OP3 Visualizzare il numero totale di persone della società
SELECT COUNT(*) AS persone
FROM ALLENATORE, GIOCATORE;

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

-- OP13 Visualizzare le partite di una squadra
SELECT PARTITA
FROM PARTITA P
WHERE P.idSquadra = ?;

-- OP14 Visualizzare i campionato giocati da una squadra negli anni (in ordine decrescente)
SELECT PARTITA.campionato_anno, PARTITA.campionato_nome, PARTITA.campionato_livello 
FROM PARTITA P
WHERE P.idSquadra = ?
ORDER BY P.campionato_anno DESC;

-- OP15 Visualizzare gli allenamenti di una squadra e in che palestra
SELECT ALLENAMENTO, PALESTRA
FROM ALLENAMENTO A, PALESTRA P
WHERE A.idPalestra = P.idPalestra AND A.idSquadra = ?;

-- OP-16 Acquistare x paia di calzini
INSERT INTO richiesta(idMateriale, idVendita, quantita)
SELECT MATERIALE.idMateriale, VENDITA.idVendita, VALUES(?)
WHERE MATERIALE.disponibilita > ?;
-- Innanzitutto, bisogna controllare che gli oggetti desiderati siano disponibili. 
SELECT disponibilita 
FROM MATERIALE
WHERE idMateriale = ? 
AND disponibilita >= ?;
-- Creo un nuovo scontrino
INSERT INTO VENDITA (idVendita, data, costo_totale) 
VALUES (?, GETDATE(), MATERIALE.prezzo * richiesta.quantita);
-- A questo punto bisogna diminuire la quantità dell’oggetto. 
UPDATE MATERIALE
SET quantita = quantita - ? 
WHERE idMateriale = ?;

-- OP-17 Visualizzare i materiali disponibili
SELECT MATERIALI;

-- OP18 Visualizzare numero di vendite fatte nelle varie sedi
SELECT SEDE, COUNT(*) AS N_VENDITE
FROM VENDITA V
WHERE V.idSede = S.idSede
GROUP BY SEDE.idSede;

-- OP19 Visualizzare il guadagno totale per anno di una sede
SELECT SUM(Q.costo) AS Quote, (	SELECT SUM(V.costo_totale)
								FROM VENDITE V
                                WHERE V.idSede = ? AND DATEPART(yyyy, V.data) = ? ) AS Vendite
FROM QUOTA Q
WHERE QUOTA.idGiocatore = (	SELECT GIOCATORE.idGipocatore
							FROM GIOCATORE
							WHERE GIOCATORE.idSede = ?) AND Q.anno = ?;


-- OP-20 Visualizzare numero di giocatori in ogni squadra
SELECT SQUARA, COUNT(GIOCATORE) AS Giocatori
GROUP BY SQUADRA.idSquadra;
