DROP SCHEMA IF EXISTS temp CASCADE;

CREATE SCHEMA temp;

CREATE TABLE temp.samity_info (
    id SERIAL PRIMARY KEY,
    samity_code TEXT,
    samity_name TEXT NOT NULL,
    samity_level TEXT NOT NULL,
    --p = primary, n=national, c=central
    organizer_id INT NOT NULL,
    project_id INT,
    doptor_id INT NOT NULL,
    office_id INT NOT NULL,
    district_id INT NOT NULL,
    upazila_id INT NOT NULL,
    samity_division_id INT NOT NULL,
    samity_district_id INT NOT NULL,
    -- samity_upazila_id INT,
    -- samity_city_corp_id INT,
    -- samity_union_id INT,
    samity_upa_city_id INTEGER NULL,
    samity_upa_city_type CHARACTER VARYING (5) NULL,
    samity_uni_thana_paw_id INTEGER NULL,
    samity_uni_thana_paw_type CHARACTER VARYING (5) NULL,
    samity_details_address TEXT,
    samity_type_id INT NOT NULL,
    purpose TEXT,
    no_of_share INT NOT NULL,
    share_price INT NOT NULL,
    sold_share INT NOT NULL,
    phone_no TEXT,
    mobile_no TEXT,
    email_id TEXT,
    enterprising_org TEXT,
    website TEXT,
    status TEXT NOT NULL DEFAULT 'i',
    declaration boolean NOT NULL,
    by_law text,
    select_area_type INT NOT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    certificate_get_by TEXT,
    samity_formation_date DATE,
    old_registration_no TEXT,
    samity_registration_date DATE NOT NULL,
    account_type TEXT NOT NULL,
    account_no INT NOT NULL,
    account_title TEXT NOt NULL,
    member_admission_fee INT DEFAULT 0,
    -- FOREIGN KEY (organizer_id) REFERENCES coop.member_info (member_id),
    FOREIGN KEY (samity_division_id) REFERENCES master.division_info (id),
    FOREIGN KEY (samity_district_id) REFERENCES master.district_info (id),
    FOREIGN KEY (project_id) REFERENCES master.project_info(id)
);

CREATE TABLE temp.member_area (
    id SERIAL PRIMARY KEY,
    samity_id INT,
    division_id INT,
    district_id INT,
    upa_city_id INTEGER NULL,
    upa_city_type CHARACTER VARYING (5) NULL,
    uni_thana_paw_id INTEGER NULL,
    uni_thana_paw_type CHARACTER VARYING (5) NULL,
    details_address TEXT,
    status TEXT NOT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES master.division_info (id),
    FOREIGN KEY (district_id) REFERENCES master.district_info (id)
);

CREATE TABLE temp.working_area (
    id SERIAL PRIMARY KEY,
    samity_id INT,
    division_id INT,
    district_id INT,
    upa_city_id INTEGER NULL,
    upa_city_type CHARACTER VARYING (5) NULL,
    uni_thana_paw_id INTEGER NULL,
    uni_thana_paw_type CHARACTER VARYING (5) NULL,
    details_address TEXT,
    status TEXT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES master.division_info (id),
    FOREIGN KEY (district_id) REFERENCES master.district_info (id)
);

CREATE TABLE temp.member_info(
    id SERIAL PRIMARY KEY,
    member_code TEXT,
    occupation_id INT NOT NULL,
    samity_id INT NOT NULL,
    education_level_id INT,
    marital_status_id INT,
    gender_id INT,
    nid TEXT NOT NULL,
    dob TEXT NOT NULL,
    member_name TEXT NOT NULL,
    member_name_bangla TEXT NOT NULL,
    father_name TEXT NOT NULL,
    mother_name TEXT NOT NULL,
    spouse_name TEXT,
    -- m=male,f=female,o=others
    mobile_no TEXT NOT NULL,
    email_id TEXT,
    -- committee_designation TEXT, 
    committee_organizer TEXT DEFAULT 'N',
    --No(N),Yes(Y)
    committee_contact_person TEXT DEFAULT 'N',
    --No(N),Yes(Y)
    committee_signatory_person TEXT DEFAULT 'N',
    --No(N),Yes(Y)
    member_photo TEXT,
    member_sign TEXT,
    member_testimonial TEXT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (occupation_id) REFERENCES master.code_master (id),
    FOREIGN KEY (education_level_id) REFERENCES master.code_master(id),
    FOREIGN KEY (marital_status_id) REFERENCES master.code_master(id),
    FOREIGN KEY (gender_id) REFERENCES master.code_master(id),
    UNIQUE(member_code)
);

CREATE TABLE temp.member_address_info (
    id SERIAL PRIMARY KEY,
    samity_id INT NOT NULL,
    member_id INT NOT NULL,
    address_type TEXT NOT NULL,
    district_id INT NOT NULL,
    upa_city_id INTEGER NULL,
    upa_city_type CHARACTER VARYING (5) NULL,
    uni_thana_paw_id INTEGER NULL,
    uni_thana_paw_type CHARACTER VARYING (5) NULL,
    details_address TEXT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES temp.member_info (id) ON DELETE CASCADE,
    FOREIGN KEY (district_id) REFERENCES master.district_info (id),
    UNIQUE(address_type, member_id)
);

CREATE TABLE temp.member_financial_info(
    id SERIAL PRIMARY KEY,
    member_id INT NOT NULL,
    samity_id INT NOT NULL,
    no_of_share INT NOT NULL,
    share_amount INT NOT NULL,
    savings_amount INT NOT NULL,
    loan_outstanding INT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES temp.member_info (id) ON DELETE CASCADE
);

CREATE TABLE temp.committee_info(
    id SERIAL PRIMARY KEY,
    samity_id INT NOT NULL,
    committee_type TEXT NOT NULL,
    --Selected (2years)/Elected (3Years)/Intermediate(120 days)  S/E/I
    election_date DATE,
    effect_date DATE,
    duration INT NOT NULL,
    no_of_member INT NOT NULL,
    expire_date DATE,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE
);

CREATE TABLE temp.committee_member(
    id SERIAL PRIMARY KEY,
    committee_id INT NOT NULL,
    samity_id INT NOT NULL,
    member_type TEXT NOT NULL,
    --Samitee Member(S)/ Govt Officer (G)
    nid TEXT,
    member_id INT,
    name TEXT,
    organization TEXT,
    designation TEXT,
    mobile_no INT,
    committee_role_id INT NOT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES temp.member_info (id) ON DELETE CASCADE,
    FOREIGN KEY (committee_id) REFERENCES temp.committee_info (id) ON DELETE CASCADE
);

CREATE TABLE temp.samity_gl_trans (
    id SERIAL PRIMARY KEY,
    is_ie_budget TEXT NOT NULL,
    --IE(E) / Budget(B)
    financial_year TEXT NOT NULL,
    --IE() / Budget(2021-2022),
    samity_id INT NOT NULL,
    glac_id INT NOT NULL,
    orp_code TEXT NOT NULL,
    tran_date Date NOT NULL,
    inc_amt INT NOT NULL,
    exp_amt INT NOT NULL,
    remarks TEXT,
    status TEXT NOT NULL DEFAULT 'N',
    budget_role TEXT,
    --New(N) / Approved(A)
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE
);

CREATE TABLE temp.samity_document(
    id SERIAL PRIMARY KEY,
    samity_id INT NOT NULL,
    document_id INT NOT NULL,
    document_name text NOT NULL,
    document_no TEXT,
    effect_date date,
    expire_date date,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES temp.samity_info (id) ON DELETE CASCADE
);