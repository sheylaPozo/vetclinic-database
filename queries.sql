/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".

SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.

SELECT name from animals WHERE date_part('year', date_of_birth) BETWEEN 2016 AND 2019;
--  OR USE THIS :
SELECT name from animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name from animals WHERE neutered = true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth from animals WHERE name IN ('Agumon','Pikachu');

-- List name and escape attempts of animals that weight more than 10.5kg

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT * from animals WHERE neutered = true;

-- Find all animals not named Gabumon.

SELECT * from animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg.

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;



/* TASK 2 - Query and Update animal table */

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK TRANSACTION;


BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE from animals;
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
DELETE from animals WHERE date_of_birth > 'Jan 1, 2022';
SAVEPOINT DELETE_DATE;
UPDATE animals SET weight_kg = (weight_kg * -1);
ROLLBACK TO DELETE_DATE;
UPDATE animals SET weight_kg = (weight_kg * -1) WHERE weight_kg < 0;
COMMIT TRANSACTION;


-- How many animals are there?

SELECT COUNT (*) FROM animals;

-- How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts > 0;

-- What is the average weight of animals?

SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?

SELECT neutered, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY neutered;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT neutered, AVG(escape_attempts) FROM animals WHERE date_part('year', date_of_birth) BETWEEN 1990 AND 2000 GROUP BY neutered;

-- TASK 3 --

SELECT animals.name, owners.full_name FROM animals INNER JOIN owners ON owners.id = animals.owner_id AND owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals INNER JOIN species ON species.id = animals.species_id AND species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) FROM animals FULL OUTER JOIN species ON species.id = animals.species_id GROUP BY species.id;

SELECT animals.name, species.name FROM animals INNER JOIN owners ON owners.id = animals.owner_id INNER JOIN species ON species.id = animals.species_id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.owner_id) FROM animals FULL OUTER JOIN owners ON animals.owner_id = owners.id GROUP BY owners.id;


-- TASK 4 Add "join table" for visits


-- Who was the last animal seen by William Tatcher?

SELECT animals.name, visits.date_of_visit AS last_visit FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'William Tatcher'
GROUP BY animals.name, visits.date_of_visit
ORDER BY last_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT visits.animals_id) FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name, species.name FROM vets
LEFT JOIN specialization ON specialization.vets_id = vets.id
LEFT JOIN species ON species.id = specialization.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name, visits.date_of_visit FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_visit BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020';

-- What animal has the most visits to vets?

SELECT animals.name, COUNT(visits.animals_id) AS visit_count FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
GROUP BY animals.name, visits.animals_id
ORDER BY visit_count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, visits.date_of_visit AS first_visit FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, visits.date_of_visit
ORDER BY first_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT * FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(visits.animals_id) FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
INNER JOIN specialization ON specialization.vets_id = vets.id
WHERE specialization.species_id <> animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name, COUNT(visits.animals_id) AS species_count FROM visits
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN animals ON animals.id = visits.animals_id
INNER JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY species_count DESC LIMIT 1;