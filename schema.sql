/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(100), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg FLOAT, PRIMARY KEY(id));



-- TASK 2 - Add a column species of type string to your animals --

ALTER TABLE animals ADD COLUMN species VARCHAR(100);