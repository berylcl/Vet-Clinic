/*Queries that provide answers to the questions from all projects.*/

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