--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.0

-- Started on 2020-12-30 01:25:22

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
-- TOC entry 3905 (class 0 OID 0)
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
    password_hash character varying(60) NOT NULL,
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
    "30_minute_price" smallint NOT NULL,
    address character varying(127) NOT NULL,
    object_name character varying(127) NOT NULL,
    capacity smallint NOT NULL,
    latitude numeric(8,6) NOT NULL,
    longitude numeric(9,6) NOT NULL,
    free_slots integer NOT NULL,
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
    person_uuid character varying(32) NOT NULL,
    credit_card_expiration_date date NOT NULL,
    CONSTRAINT person_check_cc CHECK (((credit_card_number)::text ~ '^[0-9]{16}$'::text))
);


ALTER TABLE public.person OWNER TO icfjttdivtiins;

--
-- TOC entry 207 (class 1259 OID 9171207)
-- Name: reservation; Type: TABLE; Schema: public; Owner: icfjttdivtiins
--

CREATE TABLE public.reservation (
    registration_number character varying(8) NOT NULL,
    person_uuid character varying(32) NOT NULL,
    object_uuid character varying(32) NOT NULL,
    days_in_week bit(7) NOT NULL,
    expiration_date date,
    start_time time(0) without time zone NOT NULL,
    end_time time(0) without time zone NOT NULL,
    CONSTRAINT reservation_check CHECK ((mod((abs((date_part('minutes'::text, end_time) - date_part('minutes'::text, start_time))))::integer, 30) = 0))
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
-- TOC entry 3896 (class 0 OID 8393287)
-- Dependencies: 205
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.administrator (administrator_uuid) FROM stdin;
aaaaaaaaaaaaaaaaaaaad3db02718feb
\.


--
-- TOC entry 3893 (class 0 OID 8392162)
-- Dependencies: 202
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.app_user (email, password_hash, role, oib, user_uuid) FROM stdin;
tvrtka1@gmail.com	$2a$10$7hvXL5Fthune5/xxsgwUIuoKqrEJTWlSCFX4BxqGlcdPDGalXaci.	c	00000000000	5a3aede429154305adf0f240addb856f
tvrtka2@gmail.com	$2a$10$t4SOyX014sluGKAARJMrPe80qE3t7fXtK2vEkbgmEKK3HiIXSSsOa	c	00000000001	34852bf73c354e6b8c3337f9928e26d8
tvrtka3@gmail.com	$2a$10$W1i1CIoHS4ore2ALhCav2e94vwLDa55PjMLMwFUxsGwKOIJlG5uim	c	00000000002	fb87c948210f4a7fad4eca1cb349d979
tvrtka4@gmail.com	$2a$10$C1S2xCFAHMFjJ4EJutp20ewUiiTKc98Y3ZD4oRhNy15GhCldx32TK	c	00000000003	a76d10feccf74fe09897e8092fd246fb
tvrtka5@gmail.com	$2a$10$sBfJgLEIekh/kpk/rbL5auAc5uL.gqWQaEo0tQlxPcza4H601ks1K	c	00000000004	27ecb174118d4a9299fab0bb46c636da
tvrtka6@gmail.com	$2a$10$NJeQqtXC92xP9fOCOyEKqu2FwgG0Ad0QyD/hM9JJxKjDpmasnYdXq	c	00000000005	65a1ea4040de4b6d90e2e0c7344fb5b6
ivo.ivic@gmail.com	$2a$10$BoN2U4aqoa.1ZZUAxBPJn.AXaNjhKR1D.Rglae9RVC0ztT.00Anw2	p	00000000006	dd0cc2ac37134a0fa463421c587ddcfe
ana.anic@gmail.com	$2a$10$0uKzJ3qiU2zrAb1WAozVl.qhho4FJMrhqJqSAe.h6gLHQPPo4Bzl2	p	00000000007	544df2da00a64823a694d1a0e3a37dd1
luka.lukic@gmail.com	$2a$10$nHC8hj6KfGK29TWpJXMVFuA04S5ogPaPi9Zpxjz8TAXE51lzpcXrG	p	00000000008	35067e78f6c64586b2ee37d04ac5b0b3
petra.petric@gmail.com	$2a$10$TCVObr6bZztn1r4przsy0O6C2v2QWie/Enoitw8aiIBKBy7xb4z0a	p	00000000009	66596491aa40439f8d9e4de3b78167df
karlo.karlic@gmail.com	$2a$10$tdBjr6l9fmZ4hJR61Z/5Huw0/l/k96weuaH64gIW02ZAuz48B.KPy	p	00000000010	8acc4d9a7b43434c970c4fc3a34d18af
ftest1@test.com	$2a$10$7o3xj8vBgk8qhisA24k.LO/RVisDost7jcPoSfEnRJGRch2HVUlL6	p	11112222001	835660db75f24a3aa8533e10c4497329
ftest2@test.com	$2a$10$J4qa9N.x8aP8boo8mkCAbuBR9RFHfNWbbT6Tu0Q8mWIHuEdpc66F2	c	11112222002	7ced8f43994d405194775affb6f49c75
ime.prezime@fer.hr	$2a$10$8acPe0BQRisFZQBk7O3IN.kH3LrBDZeg31WOrSQHAWR0hyJQqXGCK	p	12345678998	9e3015acf41e43318c712811789f4608
nekiMail@mail.com	$2a$10$sV/g7lT8dSx08.Inm/0e3OiTwsQnwZL2dIOKO.2zB47VV344YY0uq	c	01234567891	badf45d90c074311bc8d8a9997789a82
abcd@gmail.com	$2a$10$XxtpJQ/FxpvdHEvLiHLcm./uPIvT6.07QoElKipdYQi6LNMxP7PQq	p	22211133369	fbc657671dee42789cc24aef9801f2f5
testkompanija6@outlook.com	$2a$10$pyx0DIM7iCXgzcQ5DTGd5e5bbPZQa8xvLzxqaEqk3Y42yYgMNWsEG	c	33336617539	8b35abe5033247b98ea026a416e738e0
expiry.date.test1@mail.com	$2a$10$mT6ZhVtb58llh9zGTya7lehbGIF2f4jF.ftuCXQdMeO05Q4pY/NFm	p	12345678912	86cb67d5b3ba4f9e971c539e7dc2e683
expiry.date.test2@mail.com	$2a$10$.6n55QCYpEctp83TtOVIKe5hXg2wfRf/td0WiTuV1ZpyI9ZcB1xni	p	11223344556	ef2f6b3412594ed2b0af9758a10e1355
dummy@dummy.hr	$2a$10$VAzKE5SgaimrfPPp6XhOGuTeHx.l1BarcDMdLsG9/xteXOp37dCae	c	25875558975	b75a54549dfe41b8b172b54bff7fe4ba
tvrtka7@gmail.com	$2a$10$2KrO7alqLV6m//zNnUHApOahaedlB6TMQMqJFxCuW5g6mGms076YC	c	00000000011	f8f8c306a47249c8b3e2cc537af51607
tvrtka8@gmail.com	$2a$10$vjN7.CZAvjBQmwgM22RYV.6lmiG0PNC0adH7V1BNTPJ/0Yl9cZWEC	c	00000000012	22ad7e31355e4b74bdc5e137bbecf5a0
onemillion@mil.hr	$2a$10$Ale.sy6Cx3DBn/BbCfIAh.QSXkPJ0Tlo4IIwcp.UXDdWptUp69Y.G	c	25896321478	16c589db51a44fbd9bf7d3db02718feb
testy.test@gmail.com	$2a$10$QXjDeHoRatMu7PuLU7qOHeCf5kEFo07uyMKdLTZrWJk4ns2H6QBDu	c	32132132199	e75ec8e270b449fd96a8f3b92fd84081
tvrtka9@gmail.com	$2a$10$IqL9jrQPXiYag3UES8PcgO4YbCq.GSz30XYQ/tTN0N.2J8tqZ6QeW	c	00000000013	1ad464b06ef54b63b567de88ee9e182b
bilokojimail@gmail.com	$2a$10$LTjyHukfAp8JgBkuKLFeRegvFjKrvOTLsdCj38G6RvZ6pfI23rdb2	c	10808080808	9466979b9f75439099a038feff98876e
onemilone@mil.hr	$2a$10$5fS/UgNHAgYcEEkeTpW1aun2MsxBtw5PXhsFtpjS/6CtOpjwE2Mdy	c	10808080801	6146b773bc3d4ea8b9fa0ff44bbd928e
tvrtka10@gmail.com	$2a$10$BJcYd3XfhYMIjhLSmGVD.eU0g6CtaXKNn.r6.SeL10fxC14nw.73C	c	00000000014	4296fd4a191441ac8e5fb4efbfb0924d
admin@gmail.com	$2a$10$TzdnwUwp3KSmb32Rn2IKm.zE6FZiGMGcq.txIXTZOuQoP9ewcPFDS	a	\N	aaaaaaaaaaaaaaaaaaaad3db02718feb
tvrtka11@gmail.com	$2a$10$nyEH3LB8nNt4ofuJeVSCOu9fHzQRbPWfQ9gol7TSZufFBBsRr0s96	c	00000000015	0457d576c8244500ae820f3e8dabc087
tvrtka12@gmail.com	$2a$10$iVjXMytmGBruMU/ZQ.GiHeMgiwPU4J9GN3Yx1deZ05jC0XA2t9jJS	c	00000000016	4c5ddd1b8eae4e098655f13fa1fe4733
testy.test5@gmail.com	$2a$10$GK3L3hIcwY59CqheIiVJ1uBidvdj.tIeYvADG/nP7RNqPw4qXBg1q	c	99555995551	946d18d889a94e6d9b99ab3e806ee655
\.


--
-- TOC entry 3895 (class 0 OID 8392192)
-- Dependencies: 204
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.company (name, headquarter_address, company_uuid) FROM stdin;
tvrtka1	Lijeva ulica 13	5a3aede429154305adf0f240addb856f
tvrtka2	Slatka ulica 2	34852bf73c354e6b8c3337f9928e26d8
tvrtka3	Gornja ulica 24	fb87c948210f4a7fad4eca1cb349d979
tvrtka4	Suha ulica 32	a76d10feccf74fe09897e8092fd246fb
tvrtka5	Drvena ulica 21	27ecb174118d4a9299fab0bb46c636da
tvrtka6	Ozbilja ulica 17	65a1ea4040de4b6d90e2e0c7344fb5b6
Test	Žuta ulica 7	7ced8f43994d405194775affb6f49c75
imeTvrtke	Bijela ulica 29	badf45d90c074311bc8d8a9997789a82
Dumm	Dumm 4	b75a54549dfe41b8b172b54bff7fe4ba
Tvrtka7	neka adresa 19	f8f8c306a47249c8b3e2cc537af51607
Tvrtka8	neka adresa 20	22ad7e31355e4b74bdc5e137bbecf5a0
Try One Million	One Million 1	16c589db51a44fbd9bf7d3db02718feb
HerokuTest	Testovska 123	e75ec8e270b449fd96a8f3b92fd84081
Tvrtka9	neka adresa 21	1ad464b06ef54b63b567de88ee9e182b
bilokoje ime	bilokoja adresa	9466979b9f75439099a038feff98876e
One Million One	One Million 1 1	6146b773bc3d4ea8b9fa0ff44bbd928e
Tvrtka10	neka adresa 22	4296fd4a191441ac8e5fb4efbfb0924d
Tvrtka11	neka adresa 23	0457d576c8244500ae820f3e8dabc087
Tvrtka12	neka adresa 24	4c5ddd1b8eae4e098655f13fa1fe4733
testitesti	ajojska 3	946d18d889a94e6d9b99ab3e806ee655
TESTKOMPANIJA6	TESTADRESA6	8b35abe5033247b98ea026a416e738e0
\.


--
-- TOC entry 3899 (class 0 OID 9171221)
-- Dependencies: 208
-- Data for Name: parking_object; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.parking_object (object_uuid, company_uuid, "30_minute_price", address, object_name, capacity, latitude, longitude, free_slots) FROM stdin;
c4b5cc01c43e423d9e0d7d9c7cbf218d	65a1ea4040de4b6d90e2e0c7344fb5b6	400	Dugačka ulica 10	ZU garaža	100	45.772056	15.993456	66
13637517bff842b4b622680197701aa1	65a1ea4040de4b6d90e2e0c7344fb5b6	250	Kratka ulica 6	FR garaža	55	45.791034	16.046313	43
0daf05c1e5c2454ab92e1e66426944f8	65a1ea4040de4b6d90e2e0c7344fb5b6	450	Crna ulica 15	NN parkiralište	44	45.832052	15.990134	12
8834cafa0b904865942a5dea137fa899	65a1ea4040de4b6d90e2e0c7344fb5b6	300	Roza ulica 22	Parking abc	17	45.850023	16.102456	2
f5d10093a1bc42aaa572866f53c8f015	34852bf73c354e6b8c3337f9928e26d8	300	Sretna ulica 26	PPParking	100	45.810456	16.124505	2
53388f3866c64db5865ae778d35d5507	34852bf73c354e6b8c3337f9928e26d8	500	Tužna ulica 21	Haha Parking	60	45.802456	16.078572	1
aba49d54ebd141fe99e4ef894cf0affb	34852bf73c354e6b8c3337f9928e26d8	550	Siva ulica 16	123 Parking	37	45.751256	16.012469	22
1f3c11d061a2484eab748f5e88d7aa4b	a76d10feccf74fe09897e8092fd246fb	500	Plinska ulica 34	OZN parking	55	45.815601	15.998402	13
6ae611adc6964fb5bdcce6a0eb40b3d9	badf45d90c074311bc8d8a9997789a82	300	Vodena ulica 10	Prvi parking	50	45.930002	16.140022	10
43f71bb3b4b94cc8a0465feb7c12e39c	badf45d90c074311bc8d8a9997789a82	200	Plava ulica 4	Drugi parking	50	45.991112	16.130000	0
7f4a90e4cd4c4e26be0d6354cbe57908	65a1ea4040de4b6d90e2e0c7344fb5b6	250	Smeđa ulica 25	Friparking	30	45.834565	15.913256	2
f09aec7ab42d449286097ab358e4c82d	fb87c948210f4a7fad4eca1cb349d979	650	Ogromna ulica 51	Helo parking	200	45.818123	16.002456	50
1ff07001acf64f07a6c29a66f687cd68	fb87c948210f4a7fad4eca1cb349d979	250	Smiješna ulica 12	Garaža oj	10	45.840214	16.093472	4
4e66448df6ce45579d5328a179739d17	fb87c948210f4a7fad4eca1cb349d979	350	Modra ulica 3	IF garaža	80	45.834516	15.836923	14
6cd6ec6fb7a947579496679d62045032	fb87c948210f4a7fad4eca1cb349d979	400	Kriva ulica 8	Žnj parkiralište	77	45.755567	15.950345	0
5fba2de429154305adf0f240ab3095fd	5a3aede429154305adf0f240addb856f	400	Zelena ulica 1	Parkiralište Z	15	45.754444	15.820000	12
ae7ddbbd18e04c63844595bbd710ae61	5a3aede429154305adf0f240addb856f	300	Plava ulica 13	Parkiralište Ooo	45	45.763443	16.140000	15
82bf84edcb614b549d4cd7efdd4d7f51	5a3aede429154305adf0f240addb856f	350	Žuta ulica 2	Parkiralište EEE	28	45.804961	15.834569	0
3277984aaf834582a1a07f6ffc0bcc48	65a1ea4040de4b6d90e2e0c7344fb5b6	300	Osma ulica 33	EK parkiralište	30	45.816034	15.880531	0
f1e0cfce32464a0c829de9d8e8b29092	65a1ea4040de4b6d90e2e0c7344fb5b6	400	Neka ulica 3	Parking doo	150	45.874653	15.921111	15
c41ef8f1eb524f349b518d0d87eb63cb	4c5ddd1b8eae4e098655f13fa1fe4733	350	Neka ulica 5	Parking3 doo	450	45.411290	15.455590	50
e92a715e22b0406aa7c9067b049c23d3	4c5ddd1b8eae4e098655f13fa1fe4733	351	Neka ulica 4	Parking2 doo	451	45.411250	15.455550	51
3572428507ec4e5591b5f646255f3db9	e75ec8e270b449fd96a8f3b92fd84081	60	Neka ulica 6	Parking4 doo	700	45.411488	15.455113	20
4d7715d267d44440b2319e528a02da15	e75ec8e270b449fd96a8f3b92fd84081	20	Hvarska 3	Parkoo	30	45.000000	52.000000	10
e5b097adb5cf41509753f1c93550ddb7	5a3aede429154305adf0f240addb856f	400	Dugačka ulica 101	123 parking	100	45.600000	10.100000	10
\.


--
-- TOC entry 3894 (class 0 OID 8392177)
-- Dependencies: 203
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.person (first_name, last_name, credit_card_number, person_uuid, credit_card_expiration_date) FROM stdin;
Ivo	Ivić	1234123412341234	dd0cc2ac37134a0fa463421c587ddcfe	2021-06-15
Ana	Anić	0011001122223333	544df2da00a64823a694d1a0e3a37dd1	2021-07-14
Luka	Lukić	2222222222222222	35067e78f6c64586b2ee37d04ac5b0b3	2021-01-06
Petra	Petrić	9090909090909090	66596491aa40439f8d9e4de3b78167df	2022-06-22
Karlo	Karlić	6666666666666666	8acc4d9a7b43434c970c4fc3a34d18af	2023-11-20
Test	Test	1234123412341234	835660db75f24a3aa8533e10c4497329	2023-04-14
Ivan	Ivanić	1111222233334444	86cb67d5b3ba4f9e971c539e7dc2e683	2021-05-01
Dora 	Dorić	1111222233334444	ef2f6b3412594ed2b0af9758a10e1355	2021-05-01
Marko	Markić	1231231231235555	fbc657671dee42789cc24aef9801f2f5	2021-10-10
Ime	Prezime	1234567897777777	9e3015acf41e43318c712811789f4608	2023-02-15
\.


--
-- TOC entry 3898 (class 0 OID 9171207)
-- Dependencies: 207
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.reservation (registration_number, person_uuid, object_uuid, days_in_week, expiration_date, start_time, end_time) FROM stdin;
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af	f09aec7ab42d449286097ab358e4c82d	0001101	2020-01-18	06:00:00	16:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	f09aec7ab42d449286097ab358e4c82d	1111100	2020-05-09	06:00:00	13:00:00
ZG098ZZ	9e3015acf41e43318c712811789f4608	f09aec7ab42d449286097ab358e4c82d	0000100	2020-05-18	03:00:00	14:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	f09aec7ab42d449286097ab358e4c82d	0110100	2021-12-05	09:00:00	16:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	f09aec7ab42d449286097ab358e4c82d	1101100	2021-06-23	02:00:00	19:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	4e66448df6ce45579d5328a179739d17	1010001	2020-01-24	06:00:00	14:00:00
ZG098ZZ	9e3015acf41e43318c712811789f4608	4e66448df6ce45579d5328a179739d17	0000111	2020-06-17	06:00:00	13:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	4e66448df6ce45579d5328a179739d17	0101111	2020-05-16	09:00:00	15:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	4e66448df6ce45579d5328a179739d17	1110001	2021-01-11	09:00:00	19:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	4e66448df6ce45579d5328a179739d17	0001011	2020-04-19	00:00:00	15:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	6cd6ec6fb7a947579496679d62045032	0110101	2020-03-18	06:00:00	17:00:00
ZG098ZZ	9e3015acf41e43318c712811789f4608	6cd6ec6fb7a947579496679d62045032	1010110	2021-05-15	07:00:00	20:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	6cd6ec6fb7a947579496679d62045032	1111100	2020-08-11	02:00:00	12:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	6cd6ec6fb7a947579496679d62045032	1011010	2021-09-26	04:00:00	15:00:00
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af	6cd6ec6fb7a947579496679d62045032	1001110	2021-01-10	01:00:00	20:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	5fba2de429154305adf0f240ab3095fd	0111101	2020-07-28	06:00:00	12:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	5fba2de429154305adf0f240ab3095fd	1010000	2020-09-05	08:00:00	14:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	5fba2de429154305adf0f240ab3095fd	0001010	2021-02-01	06:00:00	16:00:00
ZG098ZZ	9e3015acf41e43318c712811789f4608	5fba2de429154305adf0f240ab3095fd	1100001	2021-12-04	00:00:00	15:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	ae7ddbbd18e04c63844595bbd710ae61	0001000	2021-02-26	08:00:00	18:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	ae7ddbbd18e04c63844595bbd710ae61	1111110	2021-02-14	04:00:00	17:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	ae7ddbbd18e04c63844595bbd710ae61	1010111	2020-05-07	03:00:00	15:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	ae7ddbbd18e04c63844595bbd710ae61	1100010	2021-11-05	07:00:00	19:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	82bf84edcb614b549d4cd7efdd4d7f51	1010011	2020-09-01	01:00:00	20:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	82bf84edcb614b549d4cd7efdd4d7f51	0101111	2021-07-06	09:00:00	19:00:00
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af	82bf84edcb614b549d4cd7efdd4d7f51	1011011	2020-05-08	04:00:00	15:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	82bf84edcb614b549d4cd7efdd4d7f51	1110110	2020-01-28	09:00:00	15:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	82bf84edcb614b549d4cd7efdd4d7f51	1010001	2021-06-12	01:00:00	16:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	82bf84edcb614b549d4cd7efdd4d7f51	0010011	2021-09-23	08:00:00	14:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	3277984aaf834582a1a07f6ffc0bcc48	1010100	2020-04-20	03:00:00	11:00:00
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af	3277984aaf834582a1a07f6ffc0bcc48	0110011	2020-05-27	07:00:00	14:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	3277984aaf834582a1a07f6ffc0bcc48	0001101	2020-04-16	06:00:00	17:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	3277984aaf834582a1a07f6ffc0bcc48	1000001	2020-01-08	02:00:00	16:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	3277984aaf834582a1a07f6ffc0bcc48	0100011	2020-06-02	07:00:00	16:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	3277984aaf834582a1a07f6ffc0bcc48	0101101	2021-04-09	03:00:00	21:00:00
ZG098ZZ	9e3015acf41e43318c712811789f4608	c4b5cc01c43e423d9e0d7d9c7cbf218d	0001010	2021-04-06	07:00:00	12:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	c4b5cc01c43e423d9e0d7d9c7cbf218d	0101001	2021-05-15	07:00:00	14:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	c4b5cc01c43e423d9e0d7d9c7cbf218d	0011010	2021-11-14	03:00:00	16:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	c4b5cc01c43e423d9e0d7d9c7cbf218d	0101100	2021-10-06	05:00:00	14:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	c4b5cc01c43e423d9e0d7d9c7cbf218d	1101000	2021-05-23	01:00:00	19:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	c4b5cc01c43e423d9e0d7d9c7cbf218d	0000011	2020-03-01	03:00:00	14:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	13637517bff842b4b622680197701aa1	0010111	2021-07-20	00:00:00	11:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	13637517bff842b4b622680197701aa1	0100011	2020-02-23	08:00:00	11:00:00
ZG098ZZ	9e3015acf41e43318c712811789f4608	13637517bff842b4b622680197701aa1	0001110	2021-08-26	03:00:00	17:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	13637517bff842b4b622680197701aa1	0011110	2020-05-09	02:00:00	19:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	13637517bff842b4b622680197701aa1	0010100	2020-10-02	05:00:00	16:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	13637517bff842b4b622680197701aa1	0011111	2021-02-06	08:00:00	21:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	0daf05c1e5c2454ab92e1e66426944f8	1101110	2021-10-26	00:00:00	20:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	0daf05c1e5c2454ab92e1e66426944f8	0101111	2020-10-24	02:00:00	17:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	0daf05c1e5c2454ab92e1e66426944f8	1101111	2020-11-13	05:00:00	14:00:00
ČK123CC	544df2da00a64823a694d1a0e3a37dd1	0daf05c1e5c2454ab92e1e66426944f8	1001011	2021-11-14	03:00:00	18:00:00
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af	0daf05c1e5c2454ab92e1e66426944f8	1101110	2021-12-23	00:00:00	17:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	8834cafa0b904865942a5dea137fa899	0000010	2021-03-24	07:00:00	13:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	8834cafa0b904865942a5dea137fa899	0011100	2021-03-22	08:00:00	21:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	8834cafa0b904865942a5dea137fa899	0100010	2021-05-12	03:00:00	21:00:00
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af	8834cafa0b904865942a5dea137fa899	0000000	2020-11-17	06:00:00	20:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	f5d10093a1bc42aaa572866f53c8f015	1101000	2021-02-28	03:00:00	12:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	f5d10093a1bc42aaa572866f53c8f015	0010001	2021-05-12	04:00:00	11:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	f5d10093a1bc42aaa572866f53c8f015	0101101	2020-03-28	00:00:00	15:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	f5d10093a1bc42aaa572866f53c8f015	1000101	2020-11-26	03:00:00	15:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	f5d10093a1bc42aaa572866f53c8f015	0011101	2020-08-09	06:00:00	20:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	53388f3866c64db5865ae778d35d5507	0111101	2021-07-24	01:00:00	19:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	53388f3866c64db5865ae778d35d5507	0100010	2021-07-23	07:00:00	11:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	53388f3866c64db5865ae778d35d5507	1100111	2021-02-23	03:00:00	21:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	53388f3866c64db5865ae778d35d5507	1111000	2020-06-16	05:00:00	11:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	53388f3866c64db5865ae778d35d5507	0010100	2020-04-16	04:00:00	11:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	aba49d54ebd141fe99e4ef894cf0affb	0011101	2021-09-21	01:00:00	11:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	aba49d54ebd141fe99e4ef894cf0affb	0010101	2021-05-11	05:00:00	12:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	aba49d54ebd141fe99e4ef894cf0affb	1010000	2020-03-02	04:00:00	18:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	aba49d54ebd141fe99e4ef894cf0affb	0110000	2021-03-09	05:00:00	21:00:00
ČK123CC	544df2da00a64823a694d1a0e3a37dd1	aba49d54ebd141fe99e4ef894cf0affb	1110000	2021-07-06	00:00:00	19:00:00
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3	1f3c11d061a2484eab748f5e88d7aa4b	0001010	2021-04-16	06:00:00	17:00:00
ZG1111AA	835660db75f24a3aa8533e10c4497329	1f3c11d061a2484eab748f5e88d7aa4b	1000101	2021-08-11	02:00:00	15:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	1f3c11d061a2484eab748f5e88d7aa4b	1001010	2021-07-27	04:00:00	15:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	1f3c11d061a2484eab748f5e88d7aa4b	1000101	2021-06-04	01:00:00	12:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	1f3c11d061a2484eab748f5e88d7aa4b	1111000	2020-11-10	04:00:00	11:00:00
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355	6ae611adc6964fb5bdcce6a0eb40b3d9	1110110	2021-02-16	08:00:00	20:00:00
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe	6ae611adc6964fb5bdcce6a0eb40b3d9	0110000	2021-04-24	06:00:00	11:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	6ae611adc6964fb5bdcce6a0eb40b3d9	1111000	2021-08-11	02:00:00	16:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	6ae611adc6964fb5bdcce6a0eb40b3d9	0001111	2021-11-05	05:00:00	11:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	6ae611adc6964fb5bdcce6a0eb40b3d9	0111111	2020-06-20	06:00:00	14:00:00
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af	43f71bb3b4b94cc8a0465feb7c12e39c	1011110	2021-01-15	02:00:00	17:00:00
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe	43f71bb3b4b94cc8a0465feb7c12e39c	0111000	2021-12-26	03:00:00	21:00:00
ČK123CC	544df2da00a64823a694d1a0e3a37dd1	43f71bb3b4b94cc8a0465feb7c12e39c	1010111	2020-03-08	06:00:00	17:00:00
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af	43f71bb3b4b94cc8a0465feb7c12e39c	0011011	2020-11-09	08:00:00	20:00:00
Zd444Ac	fbc657671dee42789cc24aef9801f2f5	43f71bb3b4b94cc8a0465feb7c12e39c	1101100	2021-01-03	08:00:00	18:00:00
\.


--
-- TOC entry 3897 (class 0 OID 8393307)
-- Dependencies: 206
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.vehicle (registration_number, person_uuid) FROM stdin;
ČK123CC	dd0cc2ac37134a0fa463421c587ddcfe
ZG1234OE	dd0cc2ac37134a0fa463421c587ddcfe
ČK123CC	544df2da00a64823a694d1a0e3a37dd1
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3
DU222TZ	35067e78f6c64586b2ee37d04ac5b0b3
ZD824JK	66596491aa40439f8d9e4de3b78167df
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af
ZG1111AA	835660db75f24a3aa8533e10c4497329
ZG098ZZ	9e3015acf41e43318c712811789f4608
Zd444Ac	fbc657671dee42789cc24aef9801f2f5
ZG1234AB	86cb67d5b3ba4f9e971c539e7dc2e683
ZG1234AB	ef2f6b3412594ed2b0af9758a10e1355
\.


--
-- TOC entry 3748 (class 2606 OID 9124588)
-- Name: administrator administrator_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_pk PRIMARY KEY (administrator_uuid);


--
-- TOC entry 3734 (class 2606 OID 8442194)
-- Name: app_user app_user_email_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_un UNIQUE (email);


--
-- TOC entry 3736 (class 2606 OID 8442950)
-- Name: app_user app_user_oib_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_oib_un UNIQUE (oib);


--
-- TOC entry 3738 (class 2606 OID 8787660)
-- Name: app_user app_user_uuid_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_uuid_pk PRIMARY KEY (user_uuid);


--
-- TOC entry 3742 (class 2606 OID 10476504)
-- Name: company company_name_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_name_un UNIQUE (name);


--
-- TOC entry 3744 (class 2606 OID 9124586)
-- Name: company company_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pk PRIMARY KEY (company_uuid);


--
-- TOC entry 3746 (class 2606 OID 10475751)
-- Name: company company_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_un UNIQUE (headquarter_address);


--
-- TOC entry 3755 (class 2606 OID 10477176)
-- Name: parking_object parking_object_address_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_address_un UNIQUE (address);


--
-- TOC entry 3757 (class 2606 OID 10477178)
-- Name: parking_object parking_object_name_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_name_un UNIQUE (object_name);


--
-- TOC entry 3759 (class 2606 OID 9171225)
-- Name: parking_object parking_object_pkey; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_pkey PRIMARY KEY (object_uuid);


--
-- TOC entry 3740 (class 2606 OID 9124584)
-- Name: person person_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pk PRIMARY KEY (person_uuid);


--
-- TOC entry 3753 (class 2606 OID 9171211)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (person_uuid, object_uuid, registration_number);


--
-- TOC entry 3751 (class 2606 OID 9124395)
-- Name: vehicle vehicle_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pk PRIMARY KEY (registration_number, person_uuid);


--
-- TOC entry 3749 (class 1259 OID 9124444)
-- Name: vehicle_owner_uuid_idx; Type: INDEX; Schema: public; Owner: icfjttdivtiins
--

CREATE INDEX vehicle_owner_uuid_idx ON public.vehicle USING btree (person_uuid);


--
-- TOC entry 3762 (class 2606 OID 9171299)
-- Name: administrator fk_administrator_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT fk_administrator_app_user FOREIGN KEY (administrator_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3761 (class 2606 OID 9171294)
-- Name: company fk_company_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT fk_company_app_user FOREIGN KEY (company_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3766 (class 2606 OID 9171275)
-- Name: parking_object fk_parking_object_company; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT fk_parking_object_company FOREIGN KEY (company_uuid) REFERENCES public.company(company_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3760 (class 2606 OID 9171289)
-- Name: person fk_person_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT fk_person_app_user FOREIGN KEY (person_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3764 (class 2606 OID 9171265)
-- Name: reservation fk_reservation_parking_object; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservation_parking_object FOREIGN KEY (object_uuid) REFERENCES public.parking_object(object_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3765 (class 2606 OID 9171270)
-- Name: reservation fk_reservation_vehicle; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservation_vehicle FOREIGN KEY (registration_number, person_uuid) REFERENCES public.vehicle(registration_number, person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3763 (class 2606 OID 9171281)
-- Name: vehicle fk_vehicle_person; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle_person FOREIGN KEY (person_uuid) REFERENCES public.person(person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3906 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: icfjttdivtiins
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO icfjttdivtiins;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 649
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO icfjttdivtiins;


-- Completed on 2020-12-30 01:25:32

--
-- PostgreSQL database dump complete
--

