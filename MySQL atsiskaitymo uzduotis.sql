USE hrcompany;

-- 1. Pasirinkite visus darbuotojus: parašykite SQL užklausą, kuri gautų visus darbuotojų
-- įrašus iš Employees lentelės.

SELECT*
FROM employees;

-- 2. Pasirinkite tam tikrus stulpelius: parodykite visus vardus ir pavardes iš Employees
-- lentelės.

SELECT firstname AS vardas,lastname AS pavarde
FROM employees;

-- 3. Filtruokite pagal skyrius: gaukite darbuotojų sąrašą, kurie dirba HR skyriuje
-- (department lentelė).

SELECT CONCAT(firstname,' ',lastname) AS vardas_pavarde,
departments.departmentname AS skyrius
FROM employees 
JOIN departments
	ON employees.departmentid = departments.departmentid
    WHERE departmentname = "HR";

-- 4. Surikiuokite darbuotojus: gaukite darbuotojų sąrašą, surikiuotą pagal jų įdarbinimo
-- datą didėjimo tvarka.

SELECT CONCAT(firstname,' ',lastname) AS vardas_pavarde,
hiredate AS idarbinimo_data
FROM employees
ORDER BY idarbinimo_data ASC;

-- 5. Suskaičiuokite darbuotojus: raskite kiek iš viso įmonėje dirba darbuotojų.

SELECT COUNT(*) AS is_viso_dirbanciu
FROM employees;

-- 6. Sujunkite darbuotojus su skyriais: išveskite bendrą darbuotojų sąrašą, šalia
-- kiekvieno darbuotojo nurodant skyrių kuriame dirba.

SELECT CONCAT(firstname,' ',lastname) AS vardas_pavarde,
departments.departmentname AS skyrius
FROM employees
JOIN departments
	ON employees.departmentid = departments.departmentid;

-- 7. Apskaičiuokite vidutinį atlyginimą: suraskite koks yra vidutinis atlyginimas
-- įmonėje tarp visų darbuotojų.

SELECT AVG(salaryamount) AS vidutinis_atlyginimas
FROM salaries;

-- ARBA DAR (suapvalinant)

SELECT ROUND(AVG(salaryamount)) AS vidutinis_atlyginimas
FROM salaries;
 
-- 8. Išfiltruokite ir suskaičiuokite: raskite kiek darbuotojų dirba IT skyriuje.

SELECT CONCAT(firstname,' ',lastname) AS vardas_pavarde,
departments.departmentname AS skyrius
FROM employees
JOIN departments
	ON employees.departmentid=departments.departmentid
WHERE departmentname ='IT';

-- ARBA
 
SELECT COUNT(*) AS darbuotoju_skaicius
FROM employees
WHERE departmentid = (SELECT departmentid FROM departments WHERE departmentname = "IT");

-- 9. Išrinkite unikalias reikšmes: gaukite unikalių siūlomų darbo pozicijų sąrašą iš
-- jobpositions lentelės.

SELECT DISTINCT positiontitle AS darbo_pozicijos
FROM jobpositions;

-- ARBA

SELECT positiontitle AS darbo_pozicijos
FROM jobpositions
GROUP BY darbo_pozicijos; 

-- 10. Išrinkite pagal datos rėžį: gaukite darbuotojus, kurie buvo nusamdyti tarp 2020-02-
-- 01 ir 2020-11-01.

SELECT*
FROM employees
WHERE hiredate BETWEEN "2020-02-01" AND "2020-11-01";

-- 11. Darbuotojų amžius: gaukite kiekvieno darbuotojo amžių pagal tai kada jie yra gimę.

SELECT CONCAT(firstname," ",lastname) AS vardas_pavarde,
ROUND(DATEDIFF(hiredate,dateofbirth) / 365) AS amzius
FROM employees;

-- 12. Darbuotojų el. pašto adresų sąrašas: gaukite visų darbuotojų el. pašto adresų sąrašą
-- abėcėline tvarka.

SELECT email AS el_pastas
FROM employees
ORDER BY el_pastas ASC;

-- 13. Darbuotojų skaičius pagal skyrių: suraskite kiek kiekviename skyriuje dirba
-- darbuotojų.

SELECT departmentname AS  skyrius,
COUNT(employeeid) AS darbuotoju_skaicius
FROM departments
LEFT JOIN employees
	ON departments.departmentid = employees.departmentid
GROUP BY departments.departmentname;

-- 14. Darbštus darbuotojas: išrinkite visus darbuotojus, kurie turi daugiau nei 3 įgūdžius
-- (skills).

SELECT employees.*,
COUNT(employeeskills.skillid) AS igudziu_skaicius
FROM employees
JOIN employeeskills
	ON employees.employeeid=employeeskills.employeeid
GROUP BY employees.employeeid
HAVING igudziu_skaicius > 3;

-- 15. Vidutinė papildomos naudos kaina: apskaičiuokite vidutines papildomų naudų
-- išmokų (benefits lentelė) išlaidas darbuotojams.

 SELECT ROUND (AVG(benefits.cost)) AS vidutine_papildomu_naudu_suma
 FROM employeebenefits
 JOIN benefits
	ON employeebenefits.benefitid=benefits.benefitid;

-- ARBA (neapvalinus)

SELECT AVG(benefits.cost) AS vidutine_papildomu_naudu_suma
FROM employeebenefits
JOIN benefits
	ON employeebenefits.benefitid=benefits.benefitid;
    
-- 16. Jaunausias ir vyriausias darbuotojai: suraskite jaunausią ir vyriausią darbuotoją
-- įmonėje.

-- Jauniausias darbuotojas

SELECT*
FROM employees
ORDER BY dateofbirth DESC
LIMIT 1;

-- Vyriausias darbuotojas

SELECT*
FROM employees
ORDER BY dateofbirth ASC
LIMIT 1;

-- 17. Skyrius su daugiausiai darbuotojų: suraskite kuriame skyriuje dirba daugiausiai
-- darbuotojų.

SELECT departments.departmentname AS skyrius,
COUNT(*) AS darbuotoju_skaicius
FROM departments
JOIN employees
	ON departments.departmentid = employees.departmentid
GROUP BY departments.departmentname
ORDER BY darbuotoju_skaicius DESC
LIMIT 1;

-- 18. Tekstinė paieška: suraskite visus darbuotojus su žodžiu “excellent” jų darbo
-- atsiliepime (performancereviews lentelė).

SELECT employees.*,reviewtext
FROM employees
JOIN performancereviews
	ON employees.employeeid = performancereviews.employeeid
WHERE performancereviews.reviewtext LIKE "%excellent%";

-- 19. Darbuotojų telefono numeriai: išveskite visų darbuotojų ID su jų telefono
-- numeriais.

SELECT employeeid AS darbuotoju_id,phone AS telefono_numeris
FROM employees;

-- 20. Darbuotojų samdymo mėnesis: suraskite kurį mėnesį buvo nusamdyta daugiausiai
-- darbuotojų.

SELECT MONTH(hiredate) AS idarbinimo_menuo,
COUNT(*) AS darbuotoju_skaicius
FROM employees
GROUP BY idarbinimo_menuo
ORDER BY darbuotoju_skaicius DESC
LIMIT 1;

-- 21. Darbuotojų įgūdžiai: išveskite visus darbuotojus, kurie turi įgūdį “Communication”.

SELECT CONCAT(firstname," ",lastname) AS vardas_pavarde,
skillname AS igudis
FROM employees
JOIN employeeskills
	ON employees.employeeid = employeeskills.employeeid
JOIN skills
	ON employeeskills.skillid = skills.skillid
WHERE skills.skillname = "communication";

-- 22. Sub-užklausos: suraskite kuris darbuotojas įmonėje uždirba daugiausiai ir išveskite
-- visą jo informaciją.

SELECT employees.*
FROM employees
JOIN salaries
	ON employees.employeeid = salaries.employeeid
WHERE salaries.salaryamount = (SELECT MAX(salaryamount) FROM salaries);

-- 23. Grupavimas ir agregacija: apskaičiuokite visas įmonės išmokų (benefits lentelė)
-- išlaidas.

SELECT SUM(benefits.cost) AS ismoku_islaidos
FROM employeebenefits
JOIN benefits
	ON employeebenefits.benefitid = benefits.benefitid;

-- 24. Įrašų atnaujinimas: atnaujinkite telefono numerį darbuotojo, kurio id yra 1.

UPDATE employees
SET PHONE = "555-555-5541"
WHERE employeeid = 1;

SELECT*
FROM employees;

-- 25. Atostogų užklausos: išveskite sąrašą atostogų prašymų (leaverequests), kurie laukia
-- patvirtinimo.

SELECT*
FROM leaverequests
WHERE status = "pending";

-- 26. Darbo atsiliepimas: išveskite darbuotojus, kurie darbo atsiliepime yra gavę 5 balus.

SELECT employees.*,
performancereviews.rating
FROM employees
JOIN performancereviews
	ON employees.employeeid = performancereviews.employeeid
WHERE performancereviews.rating = 5;

-- 27. Papildomų naudų registracijos: išveskite visus darbuotojus, kurie yra užsiregistravę
-- į “Health Insurance” papildomą naudą (benefits lentelė).

SELECT employees.*,
benefits.benefitname
FROM employees
JOIN employeebenefits
	ON employees.employeeid = employeebenefits.employeeid
JOIN benefits
	ON employeebenefits.benefitid = benefits.benefitid
WHERE benefits.benefitname = "health insurance";

-- 28. Atlyginimų pakėlimas: parodykite kaip atrodytų atlyginimai darbuotojų, dirbančių
-- “Finance” skyriuje, jeigu jų atlyginimus pakeltume 10 %.

SELECT employeeid AS darbuotojo_id,
ROUND(salaryamount * 1.1) AS pakeltas_atlyginimas
FROM salaries
WHERE employeeid IN (SELECT employeeid FROM employees WHERE departmentid =
(SELECT departmentid FROM departments WHERE departmentname = "Finance"));
        
-- 29. Efektyviausi darbuotojai: raskite 5 darbuotojus, kurie turi didžiausią darbo
-- vertinimo (performance lentelė) reitingą.

SELECT employees.*,performancereviews.rating
FROM employees
JOIN performancereviews
	ON employees.employeeid = performancereviews.employeeid
WHERE rating = 5
ORDER BY rating DESC
LIMIT 5;

-- 30. Darbuotojo darbo stažas: suskaičiuokite vidutinį darbuotojo išdirbtą laiką įmonėje
-- metais, išgrupuotą pagal skyrius.

SELECT departmentname AS skyrius,
ROUND(AVG(DATEDIFF(NOW(),hiredate)) / 365) AS isdirbtas_laikas_metais
FROM employees
JOIN departments
	ON employees.departmentid = departments.departmentid
GROUP BY departmentname
ORDER BY skyrius DESC;

-- 31. Atostogų užklausų istorija: gaukite visą atostogų užklausų istoriją (leaverequests
-- lentelė) darbuotojo, kurio id yra 1.

SELECT*
FROM leaverequests
WHERE employeeid = 1;

-- 32. Atlyginimų diapozono analizė: nustatykite atlyginimo diapazoną (minimalų ir
-- maksimalų) kiekvienai darbo pozicijai.

SELECT jobpositions.positiontitle,
MIN(salaries.salaryamount) AS Minimalus,
MAX(salaries.salaryamount) AS Maksimalus
FROM jobpositions
JOIN employees
	ON jobpositions.positionsid = employees.positionsid
JOIN salaries
	ON employees.employeeid = salaries.employeeid;

-- 33. Papildomų naudų registracijos laikotarpis: raskite vidutinį visų papildomų naudų
-- išmokų (benefits lentelė) registracijos laikotarpį (mėnesiais).

SELECT ROUND(AVG(MONTH(enrollmentdate))) AS vidutinis_laikotarpis_menesiais
FROM employeebenefits
JOIN benefits
	ON employeebenefits.benefitid = benefits.benefitid;

-- 34. Darbo atsiliepimo istorija: gaukite visą istoriją apie darbo atsiliepimus
-- (performancereviews lentelė), darbuotojo, kurio id yra 2.

SELECT*
FROM performancereviews
WHERE employeeid = 2;

-- 35. Papildomos naudos kaina vienam darbuotojui: apskaičiuokite bendras papildomų
-- naudų išmokų išlaidas vienam darbuotojui (benefits lentelė).

SELECT employees.employeeid AS eiles_numeris,
CONCAT(firstname," ",lastname) AS vardas_pavarde,
SUM(benefits.cost) AS bendros_islaidos
FROM employees
JOIN employeebenefits
	ON employees.employeeid = employeebenefits.employeeid
JOIN benefits
	ON employeebenefits.benefitid = benefits.benefitid
GROUP BY employees.employeeid,vardas_pavarde;

-- 36. Geriausi įgūdžiai pagal skyrių: išvardykite dažniausiai pasitaikančius įgūdžius
-- kiekviename skyriuje.

SELECT departments.departmentname AS skyrius,
skills.skillname AS igudis,
COUNT(employeeskills.skillid) AS igudziu_skaicius
FROM departments
JOIN employees
	ON departments.departmentid = employees.departmentid
JOIN employeeskills
	ON employees.employeeid = employeeskills.employeeid
JOIN skills
	ON employeeskills.skillid = skills.skillid
GROUP BY departments.departmentname,skills.skillname;

-- 37. Atlyginimo augimas: apskaičiuokite procentinį atlyginimo padidėjimą kiekvienam
-- darbuotojui, lyginant su praėjusiais metais.
-- 38. Darbuotojų išlaikymas: raskite darbuotojus, kurie įmonėje dirba daugiau nei 5 metai
-- ir 0kuriems per tą laiką nebuvo pakeltas atlyginimas.
-- 39. Darbuotojų atlyginimų analizė: suraskite kiekvieno darbuotojo atlygį (atlyginimas
-- (salaries lentelė) + išmokos už papildomas naudas (benefits lentelė)) ir surikiuokite
-- darbuotojus pagal bendrą atlyginimą mažėjimo tvarka.
-- 40. Darbuotojų darbo atsiliepimų tendencijos: išveskite kiekvieno darbuotojo vardą ir
-- pavardę, nurodant ar jo darbo atsiliepimas (performancereviews lentelė) pagerėjo ar
-- sumažėjo.