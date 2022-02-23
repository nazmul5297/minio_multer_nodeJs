create table user_info (
    id serial primary key,
	name text not null,
	age int not null,
	father_name text not null,
	mother_name text not null,
	mobile_number text not null,
	photo_url text not null,
	user_photo text,
	created_by text not null,
	created_at timestamp default now(),


)