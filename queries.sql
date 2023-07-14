-- Query 1: Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- Query 2: List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- Query 3: List the name of all animals that are neutered and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- Query 4: List the date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- Query 5: List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Query 6: Find all animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- Query 7: Find all animals not named Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';

-- Query 8: Find all animals with a weight between 10.4kg and 17.3kg (including animals with weights equal to precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Begin the transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction
SAVEPOINT my_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;

-- Query 1: How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- Query 2: How many animals have never tried to escape?
SELECT COUNT(*) AS never_tried_to_escape FROM animals WHERE escape_attempts = 0;

-- Query 3: What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Query 4: Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- Query 5: What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals GROUP BY species;

-- Query 6: What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
SELECT *
   FROM animals LEFT JOIN owners
   ON animals.owner_id = owners.id
   WHERE full_name = 'Melody Pond';

SELECT *
   FROM animals LEFT JOIN species
   ON animals.species_id = species.id
   WHERE species.name = 'Pokemon';

SELECT *
   FROM owners FULL OUTER JOIN animals
   ON owners.id = animals.owner_id;

SELECT COUNT(*), species.name
   FROM animals JOIN species
   ON animals.species_id = species.id
   GROUP BY species.name;

SELECT *
   FROM animals JOIN owners
   ON animals.owner_id = owners.id
   JOIN species
   ON animals.species_id = species.id
   WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT *
   FROM animals JOIN owners
   ON animals.owner_id = owner_id
   WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT COUNT(*), owners.full_name
   FROM animals JOIN owners
   ON animals.owner_id = owners.id
   GROUP BY owners.full_name
   ORDER BY COUNT DESC LIMIT 1;
-- Query 1: Who was the last animal seen by William Tatcher?
SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS ve ON v.vet_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- Query 2: How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS unique_animals
FROM visits AS v
JOIN vets AS ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez';

-- Query 3: List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, s.name AS specialty_name
FROM vets AS v
LEFT JOIN specializations AS sp ON v.id = sp.vet_id
LEFT JOIN species AS s ON sp.species_id = s.id;

-- Query 4: List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez'
  AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- Query 5: What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(*) AS visit_count
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

-- Query 6: Who was Maisy Smith's first visit?
SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS ve ON v.vet_id = ve.id
WHERE ve.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

-- Query 7: Details for the most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, v.name AS vet_name, v.visit_date
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS ve ON v.vet_id = ve.id
WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits)
LIMIT 1;

-- Query 8: How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS mismatched_visits
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS ve ON v.vet_id = ve.id
LEFT JOIN specializations AS sp ON ve.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

-- Query 9: What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS specialty_name, COUNT(*) AS visit_count
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS ve ON v.vet_id = ve.id
JOIN specializations AS sp ON ve.id = sp.vet_id
JOIN species AS s ON sp.species_id = s.id
WHERE ve.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visit_count DESC
LIMIT 1;
