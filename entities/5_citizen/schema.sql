DROP SCHEMA IF EXISTS citizen CASCADE;

CREATE SCHEMA citizen;

CREATE TABLE citizen.citizen_info(
    id SERIAL PRIMARY KEY NOT NULL,
    my_gov_id VARCHAR(50) NOT NULL,
    mobile_no VARCHAR(11) NOT NULL,
    email_id VARCHAR(50) NOT NULL,
    nid VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    name_bangla VARCHAR(120) NOT NULL,
    mother_name VARCHAR(100),
    mother_name_bangla VARCHAR(120),
    father_name VARCHAR(100),
    father_name_bangla VARCHAR(120),
    spouse_name VARCHAR(100),
    spouse_name_bangla VARCHAR(120),
    gender VARCHAR(1) NOT NULL,
    dob VARCHAR(10) NOT NULL,
    occupation VARCHAR(30),
    religion VARCHAR(15),
    present_address TEXT,
    permanent_address TEXT,
    photo TEXT,
    type VARCHAR(20) NOT NULL,
    brn VARCHAR(20),
    passport VARCHAR(20),
    tin VARCHAR(20),
    bin VARCHAR(20),
    email_verify VARCHAR(2) DEFAULT NULL,
    nid_verify VARCHAR(2) DEFAULT NULL,
    brn_verify VARCHAR(2) DEFAULT NULL,
    passport_verify VARCHAR(2) DEFAULT NULL,
    tin_verify VARCHAR(2) DEFAULT NULL,
    bin_verify VARCHAR(2) DEFAULT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    CONSTRAINT citizen_info_unique_my_gov_id UNIQUE(my_gov_id)
);

CREATE TABLE citizen.citizen_role(
    id SERIAL PRIMARY KEY NOT NULL,
    role_name TEXT NOT NULL,
    description TEXT NOT NULL,
    -- Is operational or not
    is_active BOOLEAN NOT NULL,
    created_by TEXT NOT NULL,
    created_at timestamptz NOT NULL,
    updated_by TEXT,
    updated_at timestamptz,
    unique(role_name)
);

CREATE TABLE citizen.citizen_role_feature (
    id SERIAL PRIMARY KEY NOT NULL,
    citizen_role_id INT NOT NULL,
    feature_id INT NOT NULL,
    FOREIGN KEY(citizen_role_id) REFERENCES citizen.citizen_role(id),
    FOREIGN KEY(feature_id) REFERENCES role.feature(id),
    UNIQUE(citizen_role_id, feature_id)
);