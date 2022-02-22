DROP SCHEMA IF EXISTS master CASCADE;

CREATE SCHEMA master;

CREATE TABLE master.office_info (
   id SERIAL PRIMARY KEY NOT NULL,
   office_name TEXT UNIQUE NOT NULL,
   doptor_office_id INT UNIQUE NOT NULL,
   ministry_id INT NOT NULL,
   -- Field will be added here
   created_by TEXT NOT NULL,
   create_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by TEXT,
   update_date TIMESTAMPTZ
);

-- / Formatted on 11/3/2021 3:04:32 PM (QP5 v5.360) /
CREATE TABLE master.division_info (
   id INT PRIMARY KEY NOT NULL,
   division_code VARCHAR (2),
   division_name VARCHAR (50),
   division_name_bangla VARCHAR (100),
   created_by VARCHAR (50),
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.district_info (
   id INT PRIMARY KEY NOT NULL,
   division_id INT,
   district_code VARCHAR (2),
   district_name VARCHAR (50),
   district_name_bangla VARCHAR (100),
   created_by VARCHAR (50),
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.upazila_info (
   id INT PRIMARY KEY NOT NULL,
   division_id INT,
   district_id INT,
   upazila_code VARCHAR (10),
   upazila_name VARCHAR (50),
   upazila_name_bangla VARCHAR (100),
   created_by VARCHAR (50),
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.union_info (
   id INT PRIMARY KEY NOT NULL,
   division_id INT,
   district_id INT,
   upazila_id INT,
   union_code VARCHAR (2),
   union_name VARCHAR (50),
   union_name_bangla VARCHAR (100),
   created_by VARCHAR (50),
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.city_corp_info (
   id INT PRIMARY KEY NOT NULL,
   division_id INT,
   district_id INT,
   upazila_id INT,
   city_corp_code VARCHAR (2),
   city_corp_name VARCHAR (100),
   city_corp_name_bangla VARCHAR (100),
   created_by VARCHAR (50),
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.thana_info (
   id INTEGER NOT NULL,
   division_id INTEGER NULL,
   district_id INTEGER NULL,
   thana_code CHARACTER VARYING (2) NULL,
   thana_name CHARACTER VARYING (50) NULL,
   thana_name_bangla CHARACTER VARYING (100) NULL,
   created_by CHARACTER VARYING (50) NULL,
   created_at TIMESTAMP (6) WITH TIME ZONE NOT NULL DEFAULT now (),
   updated_by CHARACTER VARYING (50) NULL,
   updated_at TIMESTAMP (6) WITH TIME ZONE NULL,
   CONSTRAINT thana_info_pkey PRIMARY KEY (id) NOT DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE master.paurasabha_info (
   id INTEGER NOT NULL,
   division_id INTEGER NULL,
   district_id INTEGER NULL,
   upazila_id INTEGER NULL,
   paurasabha_code CHARACTER VARYING (2) NULL,
   paurasabha_name CHARACTER VARYING (50) NULL,
   paurasabha_name_bangla CHARACTER VARYING (100) NULL,
   created_by CHARACTER VARYING (50) NULL,
   created_at TIMESTAMP (6) WITH TIME ZONE NOT NULL DEFAULT now (),
   updated_by CHARACTER VARYING (50) NULL,
   updated_at TIMESTAMP (6) WITH TIME ZONE NULL,
   CONSTRAINT paurasabha_info_pkey PRIMARY KEY (id) NOT DEFERRABLE INITIALLY IMMEDIATE
);

CREATE TABLE master.code_master (
   id SERIAL PRIMARY KEY NOT NULL,
   code_type VARCHAR (3) NOT NULL,
   return_value VARCHAR (3) NOT NULL,
   display_value VARCHAR (100) NOT NULL,
   is_active BOOLEAN NOT NULL DEFAULT TRUE,
   created_by VARCHAR (50) NOT NULL DEFAULT 'SYSTEM',
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.doptor_info (
   id SERIAL PRIMARY KEY NOT NULL,
   doptor_office_id INT NOT NULL,
   doptor_name VARCHAR (200) UNIQUE NOT NULL,
   doptor_name_bangla VARCHAR (200) UNIQUE NOT NULL,
   is_active BOOLEAN NOT NULL DEFAULT true,
   created_by VARCHAR (50) NOT NULL,
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ
);

CREATE TABLE master.project_info (
   id SERIAL PRIMARY KEY NOT NULL,
   project_name TEXT UNIQUE NOT NULL,
   project_name_bangla TEXT UNIQUE NOT NULL,
   project_code VARCHAR (50),
   project_director VARCHAR (150) NULL,
   doptor_id INT NOT NULL,
   initiate_date DATE NOT NULL,
   project_duration INT NOT NULL,
   estimated_exp INT NOT NULL,
   fund_source TEXT,
   expire_date DATE,
   -- Prokolpo = P, Kormosuchi = K
   project_phase VARCHAR (1) NOT NULL,
   description TEXT NOT NULL,
   is_active BOOLEAN NOT NULL DEFAULT TRUE,
   created_by VARCHAR (50) NOT NULL,
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ,
   FOREIGN KEY (doptor_id) REFERENCES master.doptor_info (id)
);

CREATE TABLE master.zone (
   id BIGSERIAL PRIMARY KEY NOT NULL,
   doptor_id INT NOT NULL,
   project_id INT NOT NULL,
   division_id INT NOT NULL,
   district_id INT NOT NULL,
   city_corp_id INT,
   upazila_id INT NOT NULL,
   is_active BOOLEAN NOT NULL DEFAULT TRUE,
   created_by VARCHAR (50) NOT NULL,
   created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
   updated_by VARCHAR (50),
   updated_at TIMESTAMPTZ,
   FOREIGN KEY (project_id) REFERENCES master.project_info(id),
   FOREIGN KEY (doptor_id) REFERENCES master.doptor_info(id),
   FOREIGN KEY (division_id) REFERENCES master.division_info(id),
   FOREIGN KEY (district_id) REFERENCES master.district_info(id),
   FOREIGN KEY (city_corp_id) REFERENCES master.city_corp_info(id),
   FOREIGN KEY (upazila_id) REFERENCES master.upazila_info(id)
);