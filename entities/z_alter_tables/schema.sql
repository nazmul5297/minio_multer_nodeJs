--samity authorized person
ALTER TABLE
    coop.samity_authorized_person
ADD
    CONSTRAINT FK_samity_id FOREIGN KEY (samity_id) REFERENCES coop.samity_reg(samity_id) ON DELETE CASCADE;

ALTER TABLE
    coop.samity_authorized_person
ADD
    CONSTRAINT FK_citizen_id FOREIGN KEY (citizen_id) REFERENCES citizen.citizen_info(id) ON DELETE CASCADE;

-- temp
ALTER TABLE
    temp.committee_member
ADD
    CONSTRAINT FK_committee_role_id FOREIGN KEY (committee_role_id) REFERENCES coop.committee_role(id) ON DELETE CASCADE;