SET search_path TO yrkesco, public; 

-- Lägger till "omgång" i klass för att tydliggöra att en klass beviljas i tre omgångar.
ALTER TABLE Klass 
ADD COLUMN omgang INTEGER CHECK (omgang BETWEEN 1 AND 3);

-- Lägger till en CHECK constraint för att säkerställa att betygskalan är enhetlig med en yrkeshögskola (IG-VG)
ALTER TABLE Registrering
ADD CONSTRAINT check_betyg CHECK (betyg IN('IG', 'G', 'VG') OR betyg is NULL);


-- Lägger till CHECK contraint för att stryra formatet på e-post adresser
ALTER TABLE StudentUppgifter
ADD CONSTRAINT s_email_check
CHECK (s_email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

ALTER TABLE AnstalldaUppgifter
ADD CONSTRAINT a_email_check
CHECK (a_email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

ALTER TABLE Anstallda
ADD CONSTRAINT j_email_check
CHECK (jobb_mail ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
