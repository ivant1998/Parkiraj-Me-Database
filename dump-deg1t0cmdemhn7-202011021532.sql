--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.0

-- Started on 2020-11-02 15:32:26

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
-- TOC entry 3879 (class 0 OID 0)
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
    user_id integer NOT NULL
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
    user_id integer NOT NULL,
    oib character varying(11),
    CONSTRAINT app_user_email_check CHECK (((email)::text ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'::text)),
    CONSTRAINT app_user_oib_check CHECK (((oib)::text ~ '^[0-9]{11}$'::text)),
    CONSTRAINT app_user_role_check CHECK ((((role)::text = 'administrator'::text) OR ((role)::text = 'company'::text) OR ((role)::text = 'person'::text)))
);


ALTER TABLE public.app_user OWNER TO icfjttdivtiins;

--
-- TOC entry 207 (class 1259 OID 8442035)
-- Name: app_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE public.app_user ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.app_user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 204 (class 1259 OID 8392192)
-- Name: company; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.company (
    name character varying(127) NOT NULL,
    headquarter_adress character varying(127),
    user_id integer NOT NULL
);


ALTER TABLE public.company OWNER TO icfjttdivtiins;

--
-- TOC entry 203 (class 1259 OID 8392177)
-- Name: person; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.person (
    first_name character varying(35) NOT NULL,
    last_name character varying(35) NOT NULL,
    user_id integer NOT NULL,
    credit_card_number character varying(16)
);


ALTER TABLE public.person OWNER TO icfjttdivtiins;

--
-- TOC entry 206 (class 1259 OID 8393307)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.vehicle (
    registration_number character varying(8) NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT vehicle_registration_number_check CHECK ((((registration_number)::text ~ '^[a-zA-Z\u0100-\u017F]{2}[0-9]{3,4}[a-zA-Z]{1,2}$'::text) OR ((registration_number)::text ~ '^[0-9]{6}$'::text)))
);


ALTER TABLE public.vehicle OWNER TO icfjttdivtiins;

--
-- TOC entry 3871 (class 0 OID 8393287)
-- Dependencies: 205
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.administrator (user_id) FROM stdin;
\.


--
-- TOC entry 3868 (class 0 OID 8392162)
-- Dependencies: 202
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.app_user (email, password_hash, role, user_id, oib) FROM stdin;
ivo.ivic@email.com	123ab44d2	person	55	12312312322
ana.anic@email.com	123312321	person	60	00234225892
\.


--
-- TOC entry 3870 (class 0 OID 8392192)
-- Dependencies: 204
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.company (name, headquarter_adress, user_id) FROM stdin;
\.


--
-- TOC entry 3869 (class 0 OID 8392177)
-- Dependencies: 203
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.person (first_name, last_name, user_id, credit_card_number) FROM stdin;
Ivo	Ivić	55	\N
\.


--
-- TOC entry 3872 (class 0 OID 8393307)
-- Dependencies: 206
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.vehicle (registration_number, user_id) FROM stdin;
ČK123OS	55
ZG2234A	55
ŠI121P	55
\.


--
-- TOC entry 3882 (class 0 OID 0)
-- Dependencies: 207
-- Name: app_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: icfjttdivtiins
--

SELECT pg_catalog.setval('public.app_user_user_id_seq', 87, true);


--
-- TOC entry 3735 (class 2606 OID 8442111)
-- Name: administrator administrator_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_un UNIQUE (user_id);


--
-- TOC entry 3725 (class 2606 OID 8442194)
-- Name: app_user app_user_email_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_un UNIQUE (email);


--
-- TOC entry 3727 (class 2606 OID 8442950)
-- Name: app_user app_user_oib_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_oib_un UNIQUE (oib);


--
-- TOC entry 3729 (class 2606 OID 8442051)
-- Name: app_user app_user_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pk PRIMARY KEY (user_id);


--
-- TOC entry 3733 (class 2606 OID 8442063)
-- Name: company company_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_un UNIQUE (user_id);


--
-- TOC entry 3731 (class 2606 OID 8442072)
-- Name: person person_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_un UNIQUE (user_id);


--
-- TOC entry 3737 (class 2606 OID 8443026)
-- Name: vehicle vehicle_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_un UNIQUE (registration_number);


--
-- TOC entry 3740 (class 2606 OID 8442112)
-- Name: administrator administrator_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_fk FOREIGN KEY (user_id) REFERENCES public.app_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3739 (class 2606 OID 8442066)
-- Name: company company_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_fk FOREIGN KEY (user_id) REFERENCES public.app_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3738 (class 2606 OID 8442073)
-- Name: person person_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_fk FOREIGN KEY (user_id) REFERENCES public.app_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3741 (class 2606 OID 8442098)
-- Name: vehicle vehicle_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_fk FOREIGN KEY (user_id) REFERENCES public.person(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3880 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: icfjttdivtiins
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO icfjttdivtiins;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3881 (class 0 OID 0)
-- Dependencies: 643
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO icfjttdivtiins;


-- Completed on 2020-11-02 15:32:31

--
-- PostgreSQL database dump complete
--

