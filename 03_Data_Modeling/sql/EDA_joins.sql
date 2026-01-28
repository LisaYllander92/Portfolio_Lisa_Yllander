SET
    search_path TO yrkesco,
    public;

-- Vilken Anläggning (Stockholm eller Göteborg) har flest Studenter?
SELECT
    anl.anlaggnings_id,
    adr.ort AS Stad,
    COUNT(s.student_id) AS Antal_Studenter
FROM
    Anlaggning anl
    JOIN Adress adr ON anl.adress_id = adr.adress_id
    LEFT JOIN Anstallda ans ON anl.anlaggnings_id = ans.anlaggnings_id
    LEFT JOIN UtbildningsLedare ul ON ans.anstallnings_id = ul.anstallnings_id
    LEFT JOIN Klass k ON ul.ul_id = k.ul_id
    LEFT JOIN Student s ON k.klass_id = s.klass_id
GROUP BY
    anl.anlaggnings_id,
    adr.ort
ORDER BY
    Antal_Studenter DESC;

-- Hur stor andel av utbildarna är konsulter på respektive anläggning?
SELECT 
    adr.ort AS Stad,
    COUNT(u.utbildare_id) AS Totalt_Antal_Utbildare,
    COUNT(u.konsult_id) AS Antal_Konsulter,
    ROUND((COUNT(u.konsult_id)::NUMERIC / COUNT(u.utbildare_id) * 100), 1) || '%' AS Konsult_Andel
FROM Anlaggning anl
JOIN Adress adr ON anl.adress_id = adr.adress_id
JOIN Utbildare u ON (
    u.anstallnings_id IN (SELECT anstallnings_id FROM Anstallda WHERE anlaggnings_id = anl.anlaggnings_id)
    OR 
    u.konsult_id IS NOT NULL 
)
GROUP BY adr.ort;

-- Hur många studenter har lyckat hitta LIA-plats från respektive skola (anläggning)?
SELECT 
    adr.ort AS Stad,
    COUNT(DISTINCT s.student_id) AS antal_studenter,
    COUNT(DISTINCT l.student_id) AS antal_med_lia,
    ROUND((COUNT(DISTINCT l.student_id)::numeric / NULLIF(COUNT(DISTINCT s.student_id), 0)) * 100, 1) || '%' AS matchningsgrad_lia
FROM yrkesco.Anlaggning anl
JOIN yrkesco.Adress adr ON anl.adress_id = adr.adress_id
LEFT JOIN yrkesco.Anstallda ans ON anl.anlaggnings_id = ans.anlaggnings_id
LEFT JOIN yrkesco.UtbildningsLedare ul ON ans.anstallnings_id = ul.anstallnings_id
LEFT JOIN yrkesco.Klass k ON ul.ul_id = k.ul_id
LEFT JOIN yrkesco.Student s ON k.klass_id = s.klass_id
LEFT JOIN yrkesco.LIA_Matchning l ON s.student_id = l.student_id
GROUP BY adr.ort;