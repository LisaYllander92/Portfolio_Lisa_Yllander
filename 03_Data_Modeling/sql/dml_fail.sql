SET
    search_path TO yrkesco,
    public;

-- 1. Testar att skriva in betyget 'MVG' i betyg som endast godkänner 'G', 'VG', eller 'IG'
INSERT INTO Registrering (registrerings_id, registerings_datum, betyg, betygs_datum, reg_status, genomforande_id, student_id) VALUES 
(1, '2024-09-25', 'MVG', '2024-11-20', 'Betygsatt', 1, 1);

-- 2. Testar att skriva in felaktigt format för email-adress
INSERT INTO Anstallda (anstallnings_id, a_fornamn, a_efternamn, jobb_titel, jobb_mail, avdelning, anlaggnings_id) VALUES 
(7, 'Karin', 'Mattsson', 'Utbildningsledare', 'KarinMattsson1@yrkco', 'Admin', 2);

-- 3. Lägger till både anstallnings_id och konsult_id (Ska endast gå att lägga till en av dessa)
INSERT INTO Utbildare (utbildare_id, specialisering, anstallnings_id, konsult_id) VALUES
(7, 'Data Modellering', NULL, 7, 4);

