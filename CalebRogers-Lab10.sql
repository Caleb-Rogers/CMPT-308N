-- Caleb Rogers -- November 30th, 2020 -- Lab 10: Stored Procedures --

--
-- Write two functions (stored procedures) that take an integer course number as their only parameter:
-- 1. function PreReqsFor(courseNum) - Returns the immediate prerequisites for the passed-in course number.
-- 2. function IsPreReqFor(courseNum) - Returns the courses for which the passed-in course number is an immediate pre-requisite.
--

-- (1)
create or replace function pre_reqs_for(integer, REFCURSOR) 
returns refcursor as $$
declare
	course_num	integer		:= $1;
	pre_reqs	REFCURSOR	:= $2;
begin
	open pre_reqs for
		select num as prerequisites, name as className, credits
		from courses
		where num in (select preReqNum
			      from Prerequisites
	  		      where courseNum = course_num);
	return pre_reqs;
end;
$$
language plpgsql;

-- example query --
select pre_reqs_for(499, 'results');
Fetch all from results;
--

-- (2)
create or replace function is_pre_req_for(integer, REFCURSOR) 
returns refcursor as $$
declare
	course_num	integer		:= $1;
	pre_reqs	REFCURSOR	:= $2;
begin
	open pre_reqs for
		select num as is_prerequisite_for, name as className, credits
		from courses
		where num in (select courseNum
			      from Prerequisites
			      where preReqNum = course_num);
	return pre_reqs;
end;
$$
language plpgsql;

-- example query
select is_pre_req_for(220, 'results');
Fetch all from results;
--
