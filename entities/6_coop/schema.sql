DROP SCHEMA IF EXISTS coop CASCADE;

CREATE SCHEMA coop;

CREATE TABLE coop.samity_type (
    id SERIAL PRIMARY KEY NOT NULL,
    type_name TEXT UNIQUE NOT NULL,
    description TEXT,
    operation_date DATE,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL
);

CREATE TABLE coop.samity_doc_mapping (
    id SERIAL PRIMARY KEY,
    --foreign key start
    doc_type_id INT,
    samity_type_id INT NOT NULL,
    --foreign key end
    is_mandatory TEXT NOT NULL,
    mandatory_instruction TEXT,
    instruction_value JSONB,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    instruction_value JSONB,
    type TEXT NOT NULL,
    --S = Samity, M = Member
    FOREIGN KEY (samity_type_id) REFERENCES coop.samity_type(id) ON DELETE CASCADE,
    FOREIGN KEY (doc_type_id) REFERENCES master.document_type(id) ON DELETE CASCADE
);

COMMENT ON COLUMN coop.samity_doc_mapping.type IS 'S = Samity, M = Member';

CREATE TABLE coop.samity_info (
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

CREATE TABLE coop.samity_authorized_person(
    id SERIAL PRIMARY KEY,
    --foreign key start
    citizen_id INT NOT NULL,
    samity_id INT NOT NULL,
    --foreign key end
    effect_date DATE NOT NULL,
    expire_date DATE,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (citizen_id) REFERENCES citizen.citizen_info (id) ON DELETE CASCADE
);

CREATE TABLE coop.member_area (
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
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES master.division_info (id),
    FOREIGN KEY (district_id) REFERENCES master.district_info (id)
);

CREATE TABLE coop.working_area (
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
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (division_id) REFERENCES master.division_info (id),
    FOREIGN KEY (district_id) REFERENCES master.district_info (id)
);

CREATE TABLE coop.member_info(
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
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (occupation_id) REFERENCES master.code_master (id),
    FOREIGN KEY (education_level_id) REFERENCES master.code_master(id),
    FOREIGN KEY (marital_status_id) REFERENCES master.code_master(id),
    FOREIGN KEY (gender_id) REFERENCES master.code_master(id),
    UNIQUE(member_code)
);

CREATE TABLE coop.member_address_info (
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
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES coop.member_info (id) ON DELETE CASCADE,
    FOREIGN KEY (district_id) REFERENCES master.district_info (id),
    UNIQUE(address_type, member_id)
);

CREATE TABLE coop.member_financial_info(
    id SERIAL PRIMARY KEY,
    --foreign key start
    member_id INT NOT NULL,
    samity_id INT NOT NULL,
    --foreign key end
    no_of_share INT NOT NULL,
    share_amount INT NOT NULL,
    savings_amount INT NOT NULL,
    loan_outstanding INT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES coop.member_info (id) ON DELETE CASCADE
);

CREATE TABLE coop.committee_role(
    id SERIAL PRIMARY KEY,
    role_name TEXT NOT NULL,
    no_of_member INT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    UNIQUE(role_name)
);

CREATE TABLE coop.committee_info(
    id SERIAL PRIMARY KEY,
    --foreign key start
    samity_id INT NOT NULL,
    --foreign key end
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
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info(id) ON DELETE CASCADE
);

CREATE TABLE coop.committee_member(
    id SERIAL PRIMARY KEY,
    --foreign key start
    samity_id INT NOT NULL,
    committee_id INT NOT NULL,
    committee_role_id INT NOT NULL,
    member_id INT,
    --foreign key end
    member_type TEXT NOT NULL,
    --Samitee Member(S)/ Govt Officer (G)
    name TEXT,
    organization TEXT,
    designation TEXT,
    nid TEXT,
    mobile_no INT,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info(id) ON DELETE CASCADE,
    FOREIGN KEY (committee_id) REFERENCES coop.committee_info(id) ON DELETE CASCADE,
    FOREIGN KEY (committee_role_id) REFERENCES coop.committee_role(id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES coop.member_info(id) ON DELETE CASCADE
);

COMMENT ON COLUMN coop.committee_member.member_type IS 'Samitee Member(S)/ Govt Officer (G)';

CREATE TABLE coop.service_info(
    id SERIAL PRIMARY KEY NOT NULL,
    service_name TEXT NOT NULL,
    project_app_rules JSONB,
    primary_app_rules JSONB,
    kendrio_app_rules JSONB,
    jatio_app_rules JSONB,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL
);

CREATE TABLE coop.application(
    id SERIAL PRIMARY KEY,
    --foreign key start
    samity_id INT NULL,
    service_id INT NOT NULL,
    next_app_designation_id INT,
    final_approve TEXT,
    status TEXT NOT NULL DEFAULT 'P',
    --foreign key end
    data JSONB NOT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES coop.service_info(id)
);

COMMENT ON COLUMN coop.application.status IS 'P - Pending, A -  Approved, C - Correction, R - Rejected';

CREATE TABLE coop.application_approval (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    application_id INT NOT NULL,
    remarks text,
    action_date date NOT NULL,
    service_action_id INT NOT NULL,
    origin_unit_id INT  NULL,
    office_id INT NOT NULL,
    designation_id INT NULL,
    employee_id INT NULL,
    attachment JSONB,
    created_by VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by VARCHAR(50),
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (office_id) REFERENCES master.office_info (id) ON DELETE CASCADE,
    FOREIGN KEY (origin_unit_id) REFERENCES master.office_origin_unit (id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES master.employee_record (id) ON DELETE CASCADE,
    FOREIGN KEY (application_id) REFERENCES coop.application (id) ON DELETE CASCADE
);

CREATE TABLE coop.glac_mst(
    id SERIAL PRIMARY KEY,
    glac_code VARCHAR(30) NOT NULL,
    glac_name VARCHAR(200) NOT NULL,
    parent_child VARCHAR(1) NOT NULL,
    parent_id integer,
    glac_type VARCHAR(1) NOT NULL,
    level_code integer,
    gl_nature VARCHAR(1) NOT NULL,
    allow_manual_dr VARCHAR(1) NOT NULL,
    allow_manual_cr VARCHAR(1) NOT NULL,
    status VARCHAR(1) NOT NULL DEFAULT 'N',
    auth_by VARCHAR(50),
    auth_date date,
    created_by VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by VARCHAR(50),
    updated_at TIMESTAMPTZ NULL
);

CREATE TABLE coop.samity_gl_trans(
    id SERIAL PRIMARY KEY,
    --foreign key start
    samity_id INT NOT NULL,
    glac_id INT NOT NULL,
    --foreign key end
    is_ie_budget TEXT NOT NULL,
    --IE(E) / Budget(B)
    financial_year TEXT NOT NULL,
    --IE() / Budget(2021-2022),
    orp_code TEXT NOT NULL,
    tran_date Date NOT NULL,
    inc_Amt int NOT NULL,
    exp_Amt int NOT NULL,
    remarks TEXT,
    status TEXT NOT NULL DEFAULT 'N',
    budget_role TEXT,
    --New(N) / Approved(A)
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info(id) ON DELETE CASCADE,
    FOREIGN KEY (glac_id) REFERENCES coop.glac_mst(id) ON DELETE CASCADE
);

CREATE TABLE coop.financial_year (
    id SERIAL PRIMARY KEY,
    financial_year TEXT NOT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL
);

CREATE TABLE coop.document_info(
    id SERIAL PRIMARY KEY,
    --foreign key start
    doc_type_id INT NOT NULL,
    --foreign key end
    ref_type TEXT NOT NULL,
    ref_id INT NOT NULL,
    document_name text NOT NULL,
    document_no TEXT,
    effect_date date,
    expire_date date,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (doc_type_id) REFERENCES master.document_type(id) ON DELETE CASCADE
);

CREATE TABLE coop.samity_document(
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
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info (id) ON DELETE CASCADE
);

CREATE TABLE coop.name_clearance(
    id SERIAL PRIMARY KEY,
    samity_name TEXT NOT NULL,
    --foreign key start
    samity_type_id INT NOT NULL,
    citizen_id INT NOT NULL,
    division_id INT NOT NULL,
    district_id INT NOT NULL,
    office_id INT NOT NULL,
    --foreign key end
    status TEXT DEFAULT 'N',
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    UNIQUE(samity_name, samity_type_id),
    FOREIGN KEY (division_id) REFERENCES master.division_info (id) ON DELETE CASCADE,
    FOREIGN KEY (district_id) REFERENCES master.district_info (id) ON DELETE CASCADE,
    FOREIGN KEY (office_id) REFERENCES master.office_info (id) ON DELETE CASCADE,
    FOREIGN KEY (samity_type_id) REFERENCES coop.samity_type (id) ON DELETE CASCADE,
    FOREIGN KEY (citizen_id) REFERENCES citizen.citizen_info (id) ON DELETE CASCADE
);

;

COMMENT ON COLUMN coop.document_info.doc_type_id IS 'Document Type';

COMMENT ON COLUMN coop.document_info.ref_type IS 'Reference Type, S = Samity, M = Member';

COMMENT ON COLUMN coop.document_info.ref_id IS 'Reference ID, Samity ID or Member ID';

/* Samity Registration */
CREATE TABLE coop.audit_assign(
    id SERIAL PRIMARY KEY,
    audit_id INT NOT NULL,
    audit_assign_per_id INT NOT NULL,
    samity_id INT NOT NULL,
    assign_date DATE NOT NULL,
    created_by TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_by TEXT NULL,
    updated_at TIMESTAMPTZ NULL,
    FOREIGN KEY (samity_id) REFERENCES coop.samity_info(id),
    UNIQUE(audit_id)
);

CREATE TABLE coop.audit(
    id SERIAL PRIMARY KEY,
    audit_date DATE NOT NULL,
    samity_id INT NOT NULL,
    comitee_type_id TEXT NOT NULL,
    co_last_meeting TEXT NOT NULL,
    co_remarks TEXT NOT NULL,
    co_m_member INT NOT NULL,
    co_f_member INT NOT NULL,
    co_t_member INT NOT NULL,
    co_ao_member_flag TEXT NOT NULL,
    co_s0_member_flag TEXT NOT NULL,
    co_samity_remarks TEXT NOT NULL,
    co_app_sharer_amt INT NOT NULL,
    co_paid_share_amt INT NOT NULL,
    co_dep_amt INT NOT NULL,
    co_dep_int_amt INT NOT NULL,
    co_liqudity_flag TEXT NOT NULL,
    co_without_shr_dep_amt INT NOT NULL,
    co_dep_remarks TEXT NOT NULL,
    co_reg_dep_amt INT NOT NULL,
    co_reg_dep_int_amt INT NOT NULL,
    co_reg_liqudity_flag TEXT NOT NULL,
    co_reg_dep_remarks TEXT NOT NULL,
    co_loan_int_per INT NOT NULL,
    co_without_samity_mem_flag_loan TEXT NOT NULL,
    co_loan_2004_rule_flag TEXT NOT NULL,
    co_yearly_budget_year DATE,
    co_audit_date DATE NOT NULL,
    co_yearly_meeting_date DATE,
    co_mem_amt INT NOT NULL,
    meeting_atten_amt INT NOT NULL,
    co_meeting_forum_flag TEXT NOT NULL,
    co_meering_res_send_date DATE NOT NULL,
    co_budget_flag TEXT NOT NULL,
    depriciation_flag TEXT NOT NULL,
    co_emp_rule_flag TEXT NOT NULL,
    co_per_emp_amt INT NOT NULL,
    co_temp_emp_amt INT NOT NULL,
    co_pro_emp_amt INT NOT NULL,
    co_mem_reg_flag TEXT NOT NULL,
    co_emp_req_rule_flag TEXT NOT NULL,
    co_bank_name TEXT NOT NULL,
    co_bank_branch_name TEXT NOT NULL,
    co_bank_ac_no TEXT NOT NULL,
    co_bank_ac_type TEXT NOT NULL,
    co_mem_book_flag TEXT NOT NULL,
    co_shr_book_flag TEXT NOT NULL,
    co_dep_book_flag TEXT NOT NULL,
    co_loan_book_flag TEXT NOT NULL,
    co_nor_reg_book_flag TEXT NOT NULL,
    co_inventory_book_flag TEXT NOT NULL,
    co_visit_date_book_flag TEXT NOT NULL,
    co_cashinhiand_amt INT NOT NULL,
    co_cashinhand_mem_id INT NOT NULL,
    co_profit_amt INT NOT NULL,
    co_unloccated_profit_amt INT NOT NULL,
    co_profit_distri_flag TEXT NOT NULL,
    co_audit_fee_flag TEXT NOT NULL,
    co_imp_fund_amt INT NOT NULL,
    co_profit_remarks TEXT NOT NULL,
    co_training_remarks TEXT NOT NULL,
    co_audit_mem_feedback_1 TEXT NOT NULL,
    co_audit_mem_feedback_2 TEXT NOT NULL,
    co_audit_mem_feedback_3 TEXT NOT NULL
);

-- alters
ALTER TABLE
    coop.samity_info
ADD
    CONSTRAINT FK_authorized_person_id FOREIGN KEY (authorized_person_id) REFERENCES coop.member_info (id);