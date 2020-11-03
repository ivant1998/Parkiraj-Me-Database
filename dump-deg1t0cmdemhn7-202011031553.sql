--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.0

-- Started on 2020-11-03 15:53:55

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
-- TOC entry 3876 (class 0 OID 0)
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
    role character varying(20) NOT NULL,
    oib character varying(11),
    user_uuid character varying(32) NOT NULL,
    CONSTRAINT app_user_check_uuid CHECK (((user_uuid)::text ~ '^[a-f0-9]{32}$'::text)),
    CONSTRAINT app_user_email_check CHECK (((email)::text ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'::text)),
    CONSTRAINT app_user_oib_and_role_check CHECK ((((((role)::text = 'person'::text) OR ((role)::text = 'company'::text)) AND ((oib)::text ~ '^[0-9]{11}$'::text)) OR (((role)::text = 'administrator'::text) AND (oib IS NULL))))
);


ALTER TABLE public.app_user OWNER TO icfjttdivtiins;

--
-- TOC entry 204 (class 1259 OID 8392192)
-- Name: company; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.company (
    name character varying(127) NOT NULL,
    headquarter_adress character varying(127),
    company_uuid character varying(32) NOT NULL
);


ALTER TABLE public.company OWNER TO icfjttdivtiins;

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
-- TOC entry 206 (class 1259 OID 8393307)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.vehicle (
    registration_number character varying(8) NOT NULL,
    owner_uuid character varying(32) NOT NULL,
    CONSTRAINT vehicle_registration_number_check CHECK ((((registration_number)::text ~ '^[a-zA-Z\u0100-\u017F]{2}[0-9]{3,4}[a-zA-Z]{1,2}$'::text) OR ((registration_number)::text ~ '^[0-9]{6}$'::text)))
);


ALTER TABLE public.vehicle OWNER TO icfjttdivtiins;

--
-- TOC entry 3869 (class 0 OID 8393287)
-- Dependencies: 205
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.administrator (administrator_uuid) FROM stdin;
\.


--
-- TOC entry 3866 (class 0 OID 8392162)
-- Dependencies: 202
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.app_user (email, password_hash, role, oib, user_uuid) FROM stdin;
ana.anic@fer.hr	12312312322	person	00000000002	123456789123456789123456789eeff5
ivo.ivic@fer.hr	12321233232	person	00000000001	abcdefabcdefabcdefabcdefabcdef22
firma1@gmail.com	5454454	company	00000000003	abcdefabcdefabcdefabc4efabcdef22
admin.adminic@fer.hr	5455444134	administrator	\N	12345678912345678912da56789eeff5
tin.tinic@fer.hr	12332132131213	person	00000000004	1234567891234567891fadc6789eeff5
stipe.stipic@fer.hr	4545565654	person	00000000005	123456789123456789123456ff9eeff5
firma@gmail.com	45742446462	company	00000000006	12345678912345678912ffe6789eeff5
admin2@fer.hr	35t55555443	administrator	\N	123eee78912345678912ffe6789eeff5
admin4@fer.hr	12323	administrator	\N	123456789123456789fffff6789eeff5
tvrtka2@fer.hr	343434232	company	12312312322	123456789123456ffffffff6789eeff5
\.


--
-- TOC entry 3868 (class 0 OID 8392192)
-- Dependencies: 204
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.company (name, headquarter_adress, company_uuid) FROM stdin;
\.


--
-- TOC entry 3867 (class 0 OID 8392177)
-- Dependencies: 203
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.person (first_name, last_name, credit_card_number, person_uuid) FROM stdin;
\.


--
-- TOC entry 3870 (class 0 OID 8393307)
-- Dependencies: 206
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.vehicle (registration_number, owner_uuid) FROM stdin;
\.


--
-- TOC entry 3733 (class 2606 OID 8790079)
-- Name: administrator administrator_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_un UNIQUE (administrator_uuid);


--
-- TOC entry 3723 (class 2606 OID 8442194)
-- Name: app_user app_user_email_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_un UNIQUE (email);


--
-- TOC entry 3725 (class 2606 OID 8442950)
-- Name: app_user app_user_oib_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_oib_un UNIQUE (oib);


--
-- TOC entry 3727 (class 2606 OID 8787660)
-- Name: app_user app_user_uuid_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_uuid_pk PRIMARY KEY (user_uuid);


--
-- TOC entry 3731 (class 2606 OID 8790081)
-- Name: company company_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_un UNIQUE (company_uuid);


--
-- TOC entry 3729 (class 2606 OID 8790083)
-- Name: person person_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_un UNIQUE (person_uuid);


--
-- TOC entry 3735 (class 2606 OID 8443026)
-- Name: vehicle vehicle_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_un UNIQUE (registration_number);


--
-- TOC entry 3738 (class 2606 OID 8790069)
-- Name: administrator administrator_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_fk FOREIGN KEY (administrator_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3737 (class 2606 OID 8790064)
-- Name: company company_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_fk FOREIGN KEY (company_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3736 (class 2606 OID 8788589)
-- Name: person person_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_fk FOREIGN KEY (person_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3739 (class 2606 OID 8790084)
-- Name: vehicle vehicle_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_fk FOREIGN KEY (owner_uuid) REFERENCES public.person(person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: icfjttdivtiins
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO icfjttdivtiins;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3878 (class 0 OID 0)
-- Dependencies: 641
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO icfjttdivtiins;


-- Completed on 2020-11-03 15:54:01

--
-- PostgreSQL database dump complete
--

