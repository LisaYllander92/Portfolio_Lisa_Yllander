-- Väljer rätt schema
SET search_path TO yrkesco, public;

-- 1. Adresser 
INSERT INTO Adress (adress_id, gatu_namn, gatu_nr, post_nr, ort) VALUES 
(1, 'Götgatan', '12', '11846', 'Stockholm'),
(2, 'Lilla Torget', '4', '41103', 'Göteborg'),
(3, 'Södergatan', '22', '21134', 'Malmö'),
(4, 'Vasagatan', '1', '11120', 'Stockholm'),
(5, 'Avenyn', '10', '41136', 'Göteborg'),
(6, 'Hamngatan', '5', '11147', 'Stockholm');

-- 2. Program (behövs för Klass och KursGenomförande)
INSERT INTO Program (program_id, program_namn, start_datum, slut_datum) VALUES 
(1, 'Systemutvecklare Java', '2024-09-01', '2026-06-05'),
(2, 'Frontend Developer', '2024-09-01', '2026-06-05');

-- 3. Kurser
INSERT INTO Kurs (kurs_id, kurs_namn, kurs_kod, poang, kurs_beskrivning) VALUES 
(1, 'Databasteknik', 'DB24', 25, 'SQL, datamodellering och relationsdatabaser'),
(2, 'Java Grundkurs', 'JAVA1', 35, 'Grundläggande programmering och OOP'),
(3, 'React & JavaScript', 'JSFE', 30, 'Moderna ramverk för webbutveckling'),
(4, 'UX Design', 'UX24', 15, 'Användarupplevelse och gränssnitt');

-- 4. Anläggningar
INSERT INTO Anlaggning (anlaggnings_id, byggnads_ar, adress_id) VALUES 
(1, 2010, 1), -- Stockholm
(2, 2018, 2); -- Göteborg

-- 5. Företag
INSERT INTO Foretag (foretags_id, org_nr, foretags_namn, f_skatt_status, adress_id) VALUES 
(1, '556123-4567', 'IT-Konsulterna AB', TRUE, 2),
(2, '559876-5432', 'Code Masters Stockholm', TRUE, 1),
(3, '554433-2211', 'LIA-Partner Väst', TRUE, 5);

-- 6. Konsulter (måste finnas innan Utbildare)
INSERT INTO Konsult (konsult_id, k_fornamn, k_efternamn, timarvode, foretags_id) VALUES 
(1, 'Anders', 'Ek', 850.0, 1),
(2, 'Beatrice', 'Lind', 920.0, 2),
(3, 'Christer', 'Storm', 750.0, 1);

-- 7. Anställda 
INSERT INTO Anstallda (anstallnings_id, a_fornamn, a_efternamn, jobb_titel, jobb_mail, avdelning, ar_utbildare, ar_ul, anlaggnings_id) VALUES 
(1, 'Karin', 'Sjöberg', 'Utbildningsledare', 'karin@yrkco.se', 'Administration', FALSE, TRUE, 1),
(2, 'Mikael', 'Nilsson', 'Senior Lärare', 'micke@yrkco.se', 'IT', TRUE, FALSE, 1), -- STHLM
(3, 'Linda', 'Karlsson', 'Utbildningsledare', 'linda@yrkco.se', 'Administration', FALSE, TRUE, 2),
(4, 'Sven', 'Svensson', 'Lärare', 'sven@yrkco.se', 'IT', TRUE, FALSE, 2), -- GBG
(5, 'Anna', 'Borg', 'Lärare', 'anna@yrkco.se', 'IT', TRUE, FALSE, 1), -- STHLM
(6, 'Erik', 'Lund', 'Lärare', 'erik@yrkco.se', 'IT', TRUE, FALSE, 2); -- GBG

-- 8. Utbildningsledare
INSERT INTO Utbildningsledare (ul_id, anstallnings_id) VALUES 
(1, 1), -- Karin Sjöberg blir UL nr 1
(2, 3); -- Linda Karlsson blir UL nr 2

-- 9. Utbildare 
INSERT INTO Utbildare (utbildare_id, specialisering, anstallnings_id, konsult_id) VALUES 
(1, 'Java & Backend', 2, NULL),  -- Mikael (Anställd STHLM)
(2, 'SQL Specialist', NULL, 1), -- Anders (Konsult)
(3, 'Frontend Expert', NULL, 2),-- Beatrice (Konsult)
(4, 'C# & Web', 4, NULL),        -- Sven (Anställd GBG)
(5, 'UX & Design', 5, NULL),     -- Anna (Anställd STHLM)
(6, 'JavaScript', 6, NULL);      -- Erik (Anställd GBG)

-- 10. Klasser (Behöver Program och UL)
INSERT INTO Klass (klass_id, klass_namn, start_ar, program_id, ul_id, omgang) VALUES 
(1, 'JAVAS24', 2024, 1, 1, 1),
(2, 'FRONT24', 2024, 2, 2, 2);

-- 11. Studenter 
INSERT INTO Student (student_id, s_fornamn, s_efternamn, klass_id) VALUES 
(1, 'Erik', 'Andersson', 1),
(2, 'Sara', 'Lundin', 1),
(3, 'Johan', 'Viktorsson', 2),
(4, 'Maria', 'Sjö', 2);

-- 12. LIA_Matchning (Endast 2 av 4 studenter har fått LIA)
INSERT INTO LIA_Matchning (lia_id, handledare_namn, period, student_id, foretags_id) VALUES 
(1, 'Karl Handledarsson', 'LIA 1', 1, 3), -- Erik har LIA
(2, 'Anna Chefsson', 'LIA 2', 2, 2);    -- Sara har LIA
-- Johan och Maria har ingen post här = Ingen LIA ännu.

-- 13. KursGenomförande
INSERT INTO KursGenomforande (genomforande_id, start_datum, slut_datum, termin, status, utbildare_id, kurs_id) VALUES 
(1, '2024-10-01', '2024-11-15', 'HT24', 'Pågår', 2, 1),
(2, '2024-09-01', '2024-10-30', 'HT24', 'Avslutad', 1, 2),
(3, '2024-11-01', '2024-12-20', 'HT24', 'Pågår', 4, 1);

-- 14. Registreringar 
INSERT INTO Registrering (registrerings_id, registerings_datum, betyg, betygs_datum, reg_status, genomforande_id, student_id) VALUES 
(1, '2024-09-25', 'VG', '2024-11-20', 'Betygsatt', 1, 1),
(2, '2024-09-25', 'G', '2024-11-20', 'Betygsatt', 1, 2),
(3, '2024-09-25', NULL, NULL, 'Registrerad', 1, 3);

