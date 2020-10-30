-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.

SELECT name, code FROM country
WHERE region = 'Southern Europe'
AND population in (
    SELECT MIN(population) FROM country 
    WHERE region = 'Southern Europe')

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.

SELECT language FROM countrylanguage
WHERE countrycode IN (
    SELECT code FROM country
    WHERE region = 'Southern Europe'
    AND population in (
        SELECT MIN(population) FROM country 
        WHERE region = 'Southern Europe'))

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.

SELECT c.region, c.name, c.code FROM countrylanguage cl, country c
WHERE language = 'Italian'
AND cl.countrycode = c.code
AND c.region = 'Southern Europe'
AND 1 = (
    SELECT COUNT(language) FROM countrylanguage
    WHERE countrycode = c.code
)
AND c.code != 'VAT'

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
 -- There are only two cities she could be flying to in the country. One is named the same as the country – that
 -- would be too obvious. We're following our gut on this one; find out what other city in that country she might
 --  be flying to.

 SELECT name, countrycode FROM city
 WHERE countrycode IN (
     SELECT code FROM country
     WHERE name = 'San Marino'
 )
 AND name != 'San Marino'

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

SELECT name, countrycode FROM city
WHERE name LIKE 'Serra%'

SELECT name FROM country
WHERE code IN (
    SELECT countrycode FROM city
    WHERE name = 'Serra'
)


-- Clue #6/#7: 
SELECT name, countrycode FROM city
WHERE id IN (
    SELECT capital FROM country
    WHERE name = 'Brazil'
)

-- Clue #8: Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our play date of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.

SELECT name, countrycode FROM city
WHERE population = 91084



She's in SANTA MONICA!
