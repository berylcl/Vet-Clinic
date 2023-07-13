/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100),
    date_of_birth  DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2) NOT NULL
);
-- Add the "species" column to the "animals" table
ALTER TABLE animals
ADD COLUMN species VARCHAR(255);
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INTEGER
);
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name TEXT
);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species(id);
ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
    FOREIGN KEY (owner_id)
    REFERENCES owners(id);