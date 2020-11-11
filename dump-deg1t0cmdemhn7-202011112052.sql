--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.0

-- Started on 2020-11-11 20:52:53

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: icfjttdivtiins
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO icfjttdivtiins;

--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: icfjttdivtiins
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 205 (class 1259 OID 8393287)
-- Name: administrator; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.administrator (
    administrator_uuid character varying(32) NOT NULL
);


ALTER TABLE public.administrator OWNER TO icfjttdivtiins;

--
-- TOC entry 202 (class 1259 OID 8392162)
-- Name: app_user; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.app_user (
    email character varying(255) NOT NULL,
    password_hash character varying(128) NOT NULL,
    role character(1) NOT NULL,
    oib character varying(11),
    user_uuid character varying(32) NOT NULL,
    CONSTRAINT app_user_check_uuid CHECK (((user_uuid)::text ~ '^[a-f0-9]{32}$'::text)),
    CONSTRAINT app_user_email_check CHECK (((email)::text ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'::text)),
    CONSTRAINT app_user_oib_and_role_check CHECK ((((((role)::text = 'p'::text) OR ((role)::text = 'c'::text)) AND ((oib)::text ~ '^[0-9]{11}$'::text)) OR (((role)::text = 'a'::text) AND (oib IS NULL))))
);


ALTER TABLE public.app_user OWNER TO icfjttdivtiins;

--
-- TOC entry 204 (class 1259 OID 8392192)
-- Name: company; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.company (
    name character varying(127) NOT NULL,
    headquarter_address character varying(127) NOT NULL,
    company_uuid character varying(32) NOT NULL
);


ALTER TABLE public.company OWNER TO icfjttdivtiins;

--
-- TOC entry 208 (class 1259 OID 9171221)
-- Name: parking_object; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.parking_object (
    object_uuid character varying(32) NOT NULL,
    company_uuid character varying(32) NOT NULL,
    free_slots smallint NOT NULL,
    "30_minute_price" smallint NOT NULL,
    address character varying(127) NOT NULL,
    object_name character varying(127) NOT NULL,
    CONSTRAINT parking_object_check CHECK (((object_uuid)::text ~ '^[a-f0-9]{32}$'::text))
);


ALTER TABLE public.parking_object OWNER TO icfjttdivtiins;

--
-- TOC entry 203 (class 1259 OID 8392177)
-- Name: person; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.person (
    first_name character varying(35) NOT NULL,
    last_name character varying(35) NOT NULL,
    credit_card_number character varying(16) NOT NULL,
    person_uuid character varying(32) NOT NULL
);


ALTER TABLE public.person OWNER TO icfjttdivtiins;

--
-- TOC entry 207 (class 1259 OID 9171207)
-- Name: reservation; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.reservation (
    start_time timestamp(0) without time zone NOT NULL,
    registration_number character varying(8) NOT NULL,
    person_uuid character varying(32) NOT NULL,
    object_uuid character varying(32) NOT NULL,
    end_time timestamp(0) without time zone NOT NULL,
    days_in_week bit(7) NOT NULL,
    expiration_date date,
    CONSTRAINT reservation_check CHECK ((((date_part('epoch'::text, ((end_time - start_time) / (60)::double precision)))::integer % 30) = 0))
);


ALTER TABLE public.reservation OWNER TO icfjttdivtiins;

--
-- TOC entry 206 (class 1259 OID 8393307)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.vehicle (
    registration_number character varying(8) NOT NULL,
    person_uuid character varying(32) NOT NULL,
    CONSTRAINT vehicle_registration_number_check CHECK ((((registration_number)::text ~ '^[a-zA-Z\u0100-\u017F]{2}[0-9]{3,4}[a-zA-Z]{1,2}$'::text) OR ((registration_number)::text ~ '^[0-9]{6}$'::text)))
);


ALTER TABLE public.vehicle OWNER TO icfjttdivtiins;

--
-- TOC entry 3887 (class 0 OID 8393287)
-- Dependencies: 205
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.administrator (administrator_uuid) FROM stdin;
44444444444444444444444444444444
77777777777777777777777777777777
88888888888888888888888888888888
\.


--
-- TOC entry 3884 (class 0 OID 8392162)
-- Dependencies: 202
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.app_user (email, password_hash, role, oib, user_uuid) FROM stdin;
ana.anic@fer.hr	12312312322	p	00000000002	11111111111111111111111111111111
ivo.ivic@fer.hr	12321233232	p	00000000001	22222222222222222222222222222222
firma1@gmail.com	5454454	c	00000000003	33333333333333333333333333333333
admin.adminic@fer.hr	5455444134	a	\N	44444444444444444444444444444444
tin.tinic@fer.hr	12332132131213	p	00000000004	55555555555555555555555555555555
stipe.stipic@fer.hr	4545565654	p	00000000005	66666666666666666666666666666666
admin2@fer.hr	35t55555443	a	\N	77777777777777777777777777777777
admin4@fer.hr	12323	a	\N	88888888888888888888888888888888
firma2@gmail.com	45742446462	c	00000000006	99999999999999999999999999999999
firma3@fer.hr	343434232	c	12312312322	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
\.


--
-- TOC entry 3886 (class 0 OID 8392192)
-- Dependencies: 204
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.company (name, headquarter_address, company_uuid) FROM stdin;
firma1	adresa1	33333333333333333333333333333333
firma2	adresa2	99999999999999999999999999999999
firma3	adresa3	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
\.


--
-- TOC entry 3890 (class 0 OID 9171221)
-- Dependencies: 208
-- Data for Name: parking_object; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.parking_object (object_uuid, company_uuid, free_slots, "30_minute_price", address, object_name) FROM stdin;
cacb24560123dcab8912ffe6789eeff5	33333333333333333333333333333333	12	400	Deveta Ulica 4	Parkiralište D23
fff3efabcdefabcdefaaaaafabcdef22	33333333333333333333333333333333	75	600	Osma Ulica 22	Parkiralište AAA
aaaa56789123dcab8912ffe6789eeff5	99999999999999999999999999999999	20	300	Treća Ulica 8	Parkiralište CCC
bbb45aa8912345678912ffe6789eeff5	99999999999999999999999999999999	30	400	Prva Ulica 2 	Parkliralište ABC
0035fbacd323dcab8912ffe6789eeff5	33333333333333333333333333333333	25	700	Prva Ulica 33	Parkiralište DDD
\.


--
-- TOC entry 3885 (class 0 OID 8392177)
-- Dependencies: 203
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.person (first_name, last_name, credit_card_number, person_uuid) FROM stdin;
Ana	Anić	2222333344445555	11111111111111111111111111111111
Ivo	Ivić	1111222233334444	22222222222222222222222222222222
Tin	Tinić	1212333332323232	55555555555555555555555555555555
Stipe	Stipić	3333222211110000	66666666666666666666666666666666
\.


--
-- TOC entry 3889 (class 0 OID 9171207)
-- Dependencies: 207
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.reservation (start_time, registration_number, person_uuid, object_uuid, end_time, days_in_week, expiration_date) FROM stdin;
2020-09-03 20:11:00	ČK123CC	11111111111111111111111111111111	bbb45aa8912345678912ffe6789eeff5	2020-09-03 22:11:00	0000000	\N
2020-10-11 10:10:00	ČK123CC	11111111111111111111111111111111	fff3efabcdefabcdefaaaaafabcdef22	2020-10-11 10:40:00	1110001	\N
2020-10-11 10:10:00	ČK123CC	22222222222222222222222222222222	fff3efabcdefabcdefaaaaafabcdef22	2020-10-11 10:40:00	1111111	\N
2020-10-11 10:10:00	ČK123CC	22222222222222222222222222222222	aaaa56789123dcab8912ffe6789eeff5	2020-10-11 10:40:00	0101011	\N
2020-10-11 10:10:00	ČK123CC	22222222222222222222222222222222	bbb45aa8912345678912ffe6789eeff5	2020-10-11 10:40:00	0000000	\N
2020-10-11 10:10:00	ZG1111AZ	22222222222222222222222222222222	bbb45aa8912345678912ffe6789eeff5	2020-10-11 10:40:00	1111111	\N
2020-10-11 10:10:00	ZG1111AZ	22222222222222222222222222222222	aaaa56789123dcab8912ffe6789eeff5	2020-10-11 10:40:00	1111000	\N
2020-10-11 10:10:00	ČK123CC	11111111111111111111111111111111	aaaa56789123dcab8912ffe6789eeff5	2020-10-11 10:40:00	0101011	\N
\.


--
-- TOC entry 3888 (class 0 OID 8393307)
-- Dependencies: 206
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.vehicle (registration_number, person_uuid) FROM stdin;
ČK123CC	11111111111111111111111111111111
ZG1111AZ	11111111111111111111111111111111
ČK123CC	22222222222222222222222222222222
ZG1111AZ	22222222222222222222222222222222
\.


--
-- TOC entry 3743 (class 2606 OID 9124588)
-- Name: administrator administrator_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_pk PRIMARY KEY (administrator_uuid);


--
-- TOC entry 3733 (class 2606 OID 8442194)
-- Name: app_user app_user_email_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_un UNIQUE (email);


--
-- TOC entry 3735 (class 2606 OID 8442950)
-- Name: app_user app_user_oib_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_oib_un UNIQUE (oib);


--
-- TOC entry 3737 (class 2606 OID 8787660)
-- Name: app_user app_user_uuid_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_uuid_pk PRIMARY KEY (user_uuid);


--
-- TOC entry 3741 (class 2606 OID 9124586)
-- Name: company company_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pk PRIMARY KEY (company_uuid);


--
-- TOC entry 3750 (class 2606 OID 9171225)
-- Name: parking_object parking_object_pkey; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_pkey PRIMARY KEY (object_uuid);


--
-- TOC entry 3739 (class 2606 OID 9124584)
-- Name: person person_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pk PRIMARY KEY (person_uuid);


--
-- TOC entry 3748 (class 2606 OID 9171211)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (person_uuid, object_uuid, registration_number);


--
-- TOC entry 3746 (class 2606 OID 9124395)
-- Name: vehicle vehicle_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pk PRIMARY KEY (registration_number, person_uuid);


--
-- TOC entry 3744 (class 1259 OID 9124444)
-- Name: vehicle_owner_uuid_idx; Type: INDEX; Schema: public; Owner: icfjttdivtiins
--

CREATE INDEX vehicle_owner_uuid_idx ON public.vehicle USING btree (person_uuid);


--
-- TOC entry 3753 (class 2606 OID 9171299)
-- Name: administrator fk_administrator_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT fk_administrator_app_user FOREIGN KEY (administrator_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3752 (class 2606 OID 9171294)
-- Name: company fk_company_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT fk_company_app_user FOREIGN KEY (company_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3757 (class 2606 OID 9171275)
-- Name: parking_object fk_parking_object_company; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT fk_parking_object_company FOREIGN KEY (company_uuid) REFERENCES public.company(company_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3751 (class 2606 OID 9171289)
-- Name: person fk_person_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT fk_person_app_user FOREIGN KEY (person_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3755 (class 2606 OID 9171265)
-- Name: reservation fk_reservation_parking_object; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservation_parking_object FOREIGN KEY (object_uuid) REFERENCES public.parking_object(object_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3756 (class 2606 OID 9171270)
-- Name: reservation fk_reservation_vehicle; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservation_vehicle FOREIGN KEY (registration_number, person_uuid) REFERENCES public.vehicle(registration_number, person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3754 (class 2606 OID 9171281)
-- Name: vehicle fk_vehicle_person; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle_person FOREIGN KEY (person_uuid) REFERENCES public.person(person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3897 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: icfjttdivtiins
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO icfjttdivtiins;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3898 (class 0 OID 0)
-- Dependencies: 649
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO icfjttdivtiins;


-- Completed on 2020-11-11 20:53:03

--
-- PostgreSQL database dump complete
--

