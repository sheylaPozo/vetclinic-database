/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Agumon', 'Feb 3, 2020', 10.23, true, 0 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Gabumon', 'Nov 15, 2018', 8, true, 2 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Pikachu', 'Jan 7, 2021', 15.04, false, 1 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Devimon', 'May 12, 2017', 11, true, 5 );

-- TASK 2 - Insert data

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Charmander', 'Feb 8, 2020', -11, false, 0 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Plantmon', 'Nov 15, 2022', -5.7, true, 2 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Squirtle', 'Apr 2, 1993', -12.13, false, 3 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Angemon', 'Jun 12, 2005', -45, true, 1 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Boarmon', 'Jun 7, 2005', 20.4, true, 7 );
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts ) VALUES ('Blossom', 'Oct 13, 1998', 17, true, 3 );

-- TASK 3 - Insert data

INSERT INTO owners ( full_name, age ) VALUES ('Sam Smith', 34);
INSERT INTO owners ( full_name, age ) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners ( full_name, age ) VALUES ('Bob', 45);
INSERT INTO owners ( full_name, age ) VALUES ('Melody Pond', 77);
INSERT INTO owners ( full_name, age ) VALUES ('Dean Winchester', 14);
INSERT INTO owners ( full_name, age ) VALUES ('Jodie Whittaker', 38);


INSERT INTO species ( name ) VALUES ('Pokemon');
INSERT INTO species ( name ) VALUES ('Digimon');

BEGIN TRANSACTION;
UPDATE animals SET species_id = 1 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 2 WHERE species_id IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
UPDATE animals SET owner_id = 1 WHERE name LIKE 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');
COMMIT TRANSACTION;

-- TASK 4 - Add "join table" for visits

INSERT INTO vets ( name, age, date_of_graduation ) VALUES ( 'Vet William Tatcher', 45, 'Apr 23, 2000' );
INSERT INTO vets ( name, age, date_of_graduation ) VALUES ( 'Vet Maisy Smith', 26, 'Jan 17, 2019' );
INSERT INTO vets ( name, age, date_of_graduation ) VALUES ( 'Vet Stephanie Mendez', 64, 'May 4, 1981' );
INSERT INTO vets ( name, age, date_of_graduation ) VALUES ( 'Vet Jack Harkness', 38, 'Jun 8, 2008' );

BEGIN TRANSACTION;
INSERT INTO specializations (vets_id, species_id) VALUES (1, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vets_id, species_id) VALUES (4, 2);
COMMIT TRANSACTION;

BEGIN TRANSACTION;
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 1, 'May 24, 2021');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 3, 'Jul 22, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (2, 4, 'Feb 2, 2021');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, 'Jan 5, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, 'Mar 8, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (3, 2, 'May 14, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (4, 3, 'May 4, 2021');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (5, 4, 'Feb 24, 2021');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, 'Dec 21, 2019');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 1, 'Aug 10, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (6, 2, 'Apr 7, 2021');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (7, 3, 'Sep 29, 2019');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, 'Oct 3, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (8, 4, 'Nov 4, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, 'Jan 24, 2019');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, 'May 15, 2019');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, 'Feb 27, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (9, 2, 'Aug 3, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10, 3, 'May 24, 2020');
INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (10, 1, 'Jan 11, 2021');
COMMIT TRANSACTION;
