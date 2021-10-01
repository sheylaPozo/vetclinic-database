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