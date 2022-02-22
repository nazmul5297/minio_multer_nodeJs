DROP SCHEMA IF EXISTS users CASCADE;

CREATE SCHEMA users;

-- user kyc central information table
CREATE TABLE users.person_info (
    id SERIAL PRIMARY KEY NOT NULL,
    name_en TEXT,
    name_bn TEXT,
    nid TEXT,
    -- birth registration number
    brn TEXT,
    passport TEXT,
    nid_front_url TEXT,
    nid_back_url TEXT,
    dob DATE,
    mobile TEXT,
    email TEXT,
    father_name_en TEXT,
    father_name_bn TEXT,
    mother_name_en TEXT,
    mother_name_bn TEXT,
    spouse_name TEXT,
    gender TEXT,
    religion TEXT,
    photo_url TEXT,
    -- system generated
    created_by TEXT NOT NULL,
    create_date timestamptz NOT NULL DEFAULT NOW(),
    updated_by TEXT,
    update_date timestamptz
);

-- operational users
CREATE TABLE users.user (
    id SERIAL PRIMARY KEY NOT NULL,
    -- username will be used in app and will be fetched from doptor
    username TEXT NOT NULL,
    password TEXT,
    -- doptor informations
    designation_bn TEXT NOT NULL,
    designation_en TEXT NOT NULL,
    employee_id INT NOT NULL,
    doptor_office_id INT NOT NULL,
    office_unit_id INT NOT NULL,
    incharge_label TEXT NOT NULL,
    office_unit_organogram_id INT NOT NULL,
    office_name_en TEXT NOT NULL,
    office_name_bn TEXT NOT NULL,
    --office_ministry_id INT NOT NULL,
    --office_ministry_name_en TEXT NOT NULL,
    --office_ministry_name_bn TEXT NOT NULL,
    unit_name_en TEXT NOT NULL,
    unit_name_bn TEXT NOT NULL,
    -- nullable
    is_cadre INT,
    employee_grade TEXT,
    joining_date TEXT,
    designation_level INT,
    designation_sequence INT,
    office_head INT,
    last_office_date TEXT,
    -- app specific information
    -- Active = A, Pending = P, Rejected = R
    approve_status TEXT DEFAULT 'P' NOT NULL,
    -- Is operational or not
    is_active BOOLEAN NOT NULL,
    office_id INT NOT NULL REFERENCES master.office_info(id) ON DELETE CASCADE,
    person_id INT REFERENCES users.person_info(id) ON DELETE CASCADE,
    role_id INT REFERENCES role.role(id) ON DELETE
    SET
        NULL,
        -- system generated
        approved_by TEXT,
        approve_date timestamptz,
        created_by TEXT NOT NULL,
        create_date timestamptz NOT NULL DEFAULT NOW(),
        updated_by TEXT,
        update_date timestamptz,
        -- composit unique username
        CONSTRAINT user_unique_name UNIQUE(username, office_id)
);