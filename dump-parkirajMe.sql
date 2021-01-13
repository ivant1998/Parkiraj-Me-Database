--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.0

-- Started on 2021-01-13 13:31:41

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
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: icfjttdivtiins
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 213 (class 1255 OID 11004749)
-- Name: vehicle_delete(); Type: FUNCTION; Schema: public; Owner: icfjttdivtiins
--

CREATE FUNCTION public.vehicle_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare 
	num int2;
	BEGIN
		select  count(registration_number) into num from vehicle v 
		where v.person_uuid = old.person_uuid
		group by v.person_uuid;
		
			
		if num = 1 then
			raise exception 'Morate imati barem jedno vozilo registrirano';
		end if;
		return old;
	END;
$$;


ALTER FUNCTION public.vehicle_delete() OWNER TO icfjttdivtiins;

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
    free_slots smallint NOT NULL,
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
    person_uuid character varying(32) NOT NULL,
    object_uuid character varying(32) NOT NULL,
    days_in_week bit(7) NOT NULL,
    reservation_uuid character varying(32) NOT NULL,
    start_time timestamp(0) without time zone NOT NULL,
    end_time timestamp(0) without time zone NOT NULL,
    CONSTRAINT reservation_check CHECK (((mod((abs((date_part('minutes'::text, end_time) - date_part('minutes'::text, start_time))))::integer, 30) = 0) AND (mod((date_part('minutes'::text, end_time))::integer, 30) = 0) AND (mod((date_part('minutes'::text, start_time))::integer, 30) = 0)))
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
-- TOC entry 3898 (class 0 OID 8393287)
-- Dependencies: 205
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.administrator (administrator_uuid) FROM stdin;
aaaaaaaaaaaaaaaaaaaad3db02718feb
aaaaaaaaaaaaaa111111111111111111
\.


--
-- TOC entry 3895 (class 0 OID 8392162)
-- Dependencies: 202
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.app_user (email, password_hash, role, oib, user_uuid) FROM stdin;
tvrtka1@gmail.com	$2a$10$7hvXL5Fthune5/xxsgwUIuoKqrEJTWlSCFX4BxqGlcdPDGalXaci.	c	00000000000	5a3aede429154305adf0f240addb856f
tvrtka2@gmail.com	$2a$10$t4SOyX014sluGKAARJMrPe80qE3t7fXtK2vEkbgmEKK3HiIXSSsOa	c	00000000001	34852bf73c354e6b8c3337f9928e26d8
tvrtka3@gmail.com	$2a$10$W1i1CIoHS4ore2ALhCav2e94vwLDa55PjMLMwFUxsGwKOIJlG5uim	c	00000000002	fb87c948210f4a7fad4eca1cb349d979
tvrtka4@gmail.com	$2a$10$C1S2xCFAHMFjJ4EJutp20ewUiiTKc98Y3ZD4oRhNy15GhCldx32TK	c	00000000003	a76d10feccf74fe09897e8092fd246fb
tvrtka6@gmail.com	$2a$10$NJeQqtXC92xP9fOCOyEKqu2FwgG0Ad0QyD/hM9JJxKjDpmasnYdXq	c	00000000005	65a1ea4040de4b6d90e2e0c7344fb5b6
ana.anic@gmail.com	$2a$10$0uKzJ3qiU2zrAb1WAozVl.qhho4FJMrhqJqSAe.h6gLHQPPo4Bzl2	p	00000000007	544df2da00a64823a694d1a0e3a37dd1
luka.lukic@gmail.com	$2a$10$nHC8hj6KfGK29TWpJXMVFuA04S5ogPaPi9Zpxjz8TAXE51lzpcXrG	p	00000000008	35067e78f6c64586b2ee37d04ac5b0b3
petra.petric@gmail.com	$2a$10$TCVObr6bZztn1r4przsy0O6C2v2QWie/Enoitw8aiIBKBy7xb4z0a	p	00000000009	66596491aa40439f8d9e4de3b78167df
karlo.karlic@gmail.com	$2a$10$tdBjr6l9fmZ4hJR61Z/5Huw0/l/k96weuaH64gIW02ZAuz48B.KPy	p	00000000010	8acc4d9a7b43434c970c4fc3a34d18af
ime.prezime@fer.hr	$2a$10$8acPe0BQRisFZQBk7O3IN.kH3LrBDZeg31WOrSQHAWR0hyJQqXGCK	p	12345678998	9e3015acf41e43318c712811789f4608
nekiMail@mail.com	$2a$10$sV/g7lT8dSx08.Inm/0e3OiTwsQnwZL2dIOKO.2zB47VV344YY0uq	c	01234567891	badf45d90c074311bc8d8a9997789a82
abcd@gmail.com	$2a$10$XxtpJQ/FxpvdHEvLiHLcm./uPIvT6.07QoElKipdYQi6LNMxP7PQq	p	22211133369	fbc657671dee42789cc24aef9801f2f5
admin@gmail.com	$2y$10$WSHjN/SsEanz1V4yVLytuOxT1hKOzRUzGLgLRVrsjBt8GxjGw3vcS	a	\N	aaaaaaaaaaaaaaaaaaaad3db02718feb
test_fhdhdfffDffffj@gmail.com	$2a$10$GbJjq4IcPXNf/EQpxFWUPulhvcACEvf809HR5AfINEVXE63BD/5xe	p	56431254684	929b6d082d284741b34ec405557b6165
ivo.ivic@gmail.com	$2y$10$SD4ywk71sx7KWM3ra9l9tevaWRsyIbhEbXqpf240i9tp51WxNPSTC	p	00000000006	dd0cc2ac37134a0fa463421c587ddcfe
teeeeest222@fmail.com	$2a$10$j3dH/NrgLgK8ibITkIwEted/1nBkQcs1/Vpkp/yDinGEqsD/aiu/W	p	27384413678	5ed2a2c9262c4659978c7f253139ca99
testOOO@gmail.com	$2a$10$AIFniZNHSaG1gFYXNo11TeW9xSjJ26xeCYg48TTbhGSBfNX5eV/pW	p	23222222200	15d26a3b7b6e4836ba57f73ca87320fc
onemillion@mil.hr	$2a$10$Ale.sy6Cx3DBn/BbCfIAh.QSXkPJ0Tlo4IIwcp.UXDdWptUp69Y.G	c	25896321478	16c589db51a44fbd9bf7d3db02718feb
tvrtka7@gmail.com	$2a$10$jowaWVCK1N7Lj5WmlQn7iulOwh0KXjVuCull2xv81k/P8Z6PJTao.	c	00000000011	5d2d1f279569443ca627cc0f3320f22f
person1@gmail.com	$2a$10$3OFve4BDFbD1lzmaWgws9OZ8LjFPxaeXe2U5HcuE3UPw2.CwoipAi	p	00000000100	24885c35ebcf44f4ab6f2c8729805bcb
tvrtka5@gmail.com	$2y$10$166GXRc8FC9/g4zK5AO6wuoViyFUCnaxbQa3NYlLj4E9JR86kSEGC	c	25874125896	e66a3e7ed3284c3f8f946edf4033ea99
admin2@gmail.com	$2y$10$WSHjN/SsEanz1V4yVLytuOxT1hKOzRUzGLgLRVrsjBt8GxjGw3vcS	a	\N	aaaaaaaaaaaaaa111111111111111111
test392i5n@g.com	$2a$10$ECM8rCpgT3jmUwfNOBenUOqBWyPY40ufwGN3dClnyqQm3R9.GRLfC	c	23468097451	535c50949bd44f3a9a6970fcb3fb9698
testko.testov@gmail.com	$2a$10$ACwVkg3LWXChHEVdVjoo/O2OZhJBtb1LMy0dFQBnVMgyt69.zLVeS	p	00000123456	63d8f6a7387f4a698ea9bd4be970b703
ivicaivica@ivica.hr	$2a$10$7u8YvcobDsAhychieFZ5geGqFcT1a5vphq1yzOLpLgwKpYFy3e.IS	p	14785236985	080073e052d044c2aa0f2a9aa0af6e18
\.


--
-- TOC entry 3897 (class 0 OID 8392192)
-- Dependencies: 204
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.company (name, headquarter_address, company_uuid) FROM stdin;
Tvrtka9	neka ulica 9	5d2d1f279569443ca627cc0f3320f22f
tvrtka2	Slatka ulica 2	34852bf73c354e6b8c3337f9928e26d8
tvrtka3	Gornja ulica 24	fb87c948210f4a7fad4eca1cb349d979
tvrtka4	Suha ulica 32	a76d10feccf74fe09897e8092fd246fb
tvrtka6	Ozbilja ulica 17	65a1ea4040de4b6d90e2e0c7344fb5b6
imeTvrtke	Bijela ulica 29	badf45d90c074311bc8d8a9997789a82
ime2	adresa3	5a3aede429154305adf0f240addb856f
imeee2	adresa2	535c50949bd44f3a9a6970fcb3fb9698
one million	one trillion 1	16c589db51a44fbd9bf7d3db02718feb
Tvrtka 199	Nee Znam	e66a3e7ed3284c3f8f946edf4033ea99
\.


--
-- TOC entry 3901 (class 0 OID 9171221)
-- Dependencies: 208
-- Data for Name: parking_object; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.parking_object (object_uuid, company_uuid, "30_minute_price", address, object_name, capacity, latitude, longitude, free_slots) FROM stdin;
c2e9ccdcb9ad4089a6721c31ec4ec4f7	535c50949bd44f3a9a6970fcb3fb9698	200	Ilica 41 Zagreb	ejejjsixiska	20	39.113930	27.175280	1
f0d9badc1ba84ce29aeb5ad1b789af56	16c589db51a44fbd9bf7d3db02718feb	115	Ilirska ulica 11	Novi Coop	200	46.053191	14.515221	61
43f71bb3b4b94cc8a0465feb7c12e39c	badf45d90c074311bc8d8a9997789a82	200	Plava ulica 4	Drugi parking	50	45.991112	15.904798	41
c5357362b2ba48be8c111dd7f5cf2f91	16c589db51a44fbd9bf7d3db02718feb	58	Ilica 11	Novi Novi	362	45.813046	15.971503	63
bd59b1f317204cca9d4bab4904b2bcd5	5a3aede429154305adf0f240addb856f	22	Ilica 22	Parkiraliste Aaa	22	45.813318	15.972885	22
f5d10093a1bc42aaa572866f53c8f015	34852bf73c354e6b8c3337f9928e26d8	300	Sretna ulica 26	PPParking	100	45.810456	15.923678	82
3277984aaf834582a1a07f6ffc0bcc48	65a1ea4040de4b6d90e2e0c7344fb5b6	300	Osma ulica 33	EK parkiralište	30	45.816034	15.995869	10
7f4a90e4cd4c4e26be0d6354cbe57908	65a1ea4040de4b6d90e2e0c7344fb5b6	250	Smeđa ulica 25	Friparking	30	45.834565	16.083960	27
4e66448df6ce45579d5328a179739d17	fb87c948210f4a7fad4eca1cb349d979	350	Modra ulica 3	IF garaža	80	45.834516	15.922487	30
49b6956075fd4a0bb1e99a952c514c25	16c589db51a44fbd9bf7d3db02718feb	68	Ilica 1	Novi Parkin 68	147	45.812778	15.927225	82
5fba2de429154305adf0f240ab3095fd	5a3aede429154305adf0f240addb856f	400	Zelena ulica 1	Parkiralište Z	15	45.754444	16.044331	5
01b0f9b796294181b2d4e6fab67b6330	16c589db51a44fbd9bf7d3db02718feb	50	Ilica 6	Yet Another Parking	100	45.813122	16.139978	100
6ae611adc6964fb5bdcce6a0eb40b3d9	badf45d90c074311bc8d8a9997789a82	300	Vodena ulica 10	Prvi parking	50	45.930002	15.833114	20
39e311af006a4e76a72a6c3a28d2293f	535c50949bd44f3a9a6970fcb3fb9698	200	Ilica 45	jjsjss	20	45.813150	15.968830	19
8834cafa0b904865942a5dea137fa899	65a1ea4040de4b6d90e2e0c7344fb5b6	300	Roza ulica 22	Parking abc	17	45.850023	15.932399	12
1f3c11d061a2484eab748f5e88d7aa4b	a76d10feccf74fe09897e8092fd246fb	500	Plinska ulica 34	OZN parking	55	45.815601	16.098877	21
1ff07001acf64f07a6c29a66f687cd68	fb87c948210f4a7fad4eca1cb349d979	250	Smiješna ulica 12	Garaža oj	10	45.840214	16.131108	8
53388f3866c64db5865ae778d35d5507	34852bf73c354e6b8c3337f9928e26d8	500	Tužna ulica 21	Haha Parking	60	45.802456	15.950213	29
aba49d54ebd141fe99e4ef894cf0affb	34852bf73c354e6b8c3337f9928e26d8	550	Siva ulica 16	123 Parking	22	45.751256	15.964196	17
13637517bff842b4b622680197701aa1	65a1ea4040de4b6d90e2e0c7344fb5b6	250	Kratka ulica 6	FR garaža	55	45.791034	16.064333	27
c4b5cc01c43e423d9e0d7d9c7cbf218d	65a1ea4040de4b6d90e2e0c7344fb5b6	400	Dugačka ulica 10	ZU garaža	100	45.772056	16.041319	68
6cd6ec6fb7a947579496679d62045032	fb87c948210f4a7fad4eca1cb349d979	400	Kriva ulica 8	Žnj parkiralište	77	45.755567	15.864653	15
2640b3c542164f52be8073c1efa59885	16c589db51a44fbd9bf7d3db02718feb	58	Ilica 5	Novi Parkin	123	45.812961	16.046785	120
82bf84edcb614b549d4cd7efdd4d7f51	5a3aede429154305adf0f240addb856f	220	Žuta ulica 2	Parkiralište EEE	2	45.804961	15.894163	0
0daf05c1e5c2454ab92e1e66426944f8	65a1ea4040de4b6d90e2e0c7344fb5b6	450	Crna ulica 15	NN parkiralište	44	45.832052	15.917523	24
f09aec7ab42d449286097ab358e4c82d	fb87c948210f4a7fad4eca1cb349d979	650	Ogromna ulica 51	Helo parking	200	45.818123	15.887158	155
\.


--
-- TOC entry 3896 (class 0 OID 8392177)
-- Dependencies: 203
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.person (first_name, last_name, credit_card_number, person_uuid, credit_card_expiration_date) FROM stdin;
Fran	Franić	1111222233334444	24885c35ebcf44f4ab6f2c8729805bcb	2024-07-01
Ivo	Ivić	1111222233334444	dd0cc2ac37134a0fa463421c587ddcfe	2025-01-01
Karlo	Karlić	3320443205834538	8acc4d9a7b43434c970c4fc3a34d18af	2021-12-01
testOOO	OOO	2389078456235145	15d26a3b7b6e4836ba57f73ca87320fc	2022-08-01
test4444429	teste73782	5316521345689745	929b6d082d284741b34ec405557b6165	2022-02-01
Ana	Anić	0011001122223333	544df2da00a64823a694d1a0e3a37dd1	2021-07-14
Luka	Lukić	2222222222222222	35067e78f6c64586b2ee37d04ac5b0b3	2021-01-06
Petra	Petrić	9090909090909090	66596491aa40439f8d9e4de3b78167df	2022-06-22
Ivica	Ivica	0725748965874512	080073e052d044c2aa0f2a9aa0af6e18	2025-07-01
Marko	Markić	1231231231235555	fbc657671dee42789cc24aef9801f2f5	2021-10-10
Ime	Prezime	1234567897777777	9e3015acf41e43318c712811789f4608	2023-02-15
Testko	Testov	1234567887654321	63d8f6a7387f4a698ea9bd4be970b703	2023-08-01
test213132123	test_21332132	2844556600223456	5ed2a2c9262c4659978c7f253139ca99	2021-02-01
\.


--
-- TOC entry 3900 (class 0 OID 9171207)
-- Dependencies: 207
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.reservation (person_uuid, object_uuid, days_in_week, reservation_uuid, start_time, end_time) FROM stdin;
fbc657671dee42789cc24aef9801f2f5	f5d10093a1bc42aaa572866f53c8f015	0000100	8c3fa79b4121422eb6a81d337f04b4f5	2021-11-10 09:00:00	2020-04-17 15:00:00
080073e052d044c2aa0f2a9aa0af6e18	f5d10093a1bc42aaa572866f53c8f015	0000010	cdec95a251f144d3aa0c00a133dc7f77	2020-09-08 03:00:00	2021-03-25 16:00:00
35067e78f6c64586b2ee37d04ac5b0b3	f5d10093a1bc42aaa572866f53c8f015	0101101	1fb86cb920d2453ab018472f00a011ac	2021-12-10 08:00:00	2020-02-16 13:00:00
929b6d082d284741b34ec405557b6165	53388f3866c64db5865ae778d35d5507	0110111	5c9ec520d724441e9d4e474f33148256	2021-08-21 04:00:00	2020-04-21 19:00:00
63d8f6a7387f4a698ea9bd4be970b703	53388f3866c64db5865ae778d35d5507	1110111	4d66c87f451a43d78ae76f08914d08cb	2020-09-26 09:00:00	2020-05-22 20:00:00
9e3015acf41e43318c712811789f4608	53388f3866c64db5865ae778d35d5507	1010010	84469ef76c6944d79ec752b18713bc59	2021-07-23 00:00:00	2020-04-09 20:00:00
544df2da00a64823a694d1a0e3a37dd1	53388f3866c64db5865ae778d35d5507	1100001	63e67c38f8c14eabb76db4a38329d2cd	2021-11-14 07:00:00	2020-04-28 16:00:00
8acc4d9a7b43434c970c4fc3a34d18af	53388f3866c64db5865ae778d35d5507	0010110	69326dc2f0bb429fa8aaa0e11bd5e7c0	2020-09-28 04:00:00	2020-05-02 14:00:00
dd0cc2ac37134a0fa463421c587ddcfe	aba49d54ebd141fe99e4ef894cf0affb	0000101	afb948e159f24ba1885aeaa15ec2e222	2021-11-13 00:00:00	2021-02-28 12:00:00
fbc657671dee42789cc24aef9801f2f5	aba49d54ebd141fe99e4ef894cf0affb	1010010	288495fe0bbd4ea1bf3a1ecdf7bdd8b9	2020-09-03 01:00:00	2020-04-26 13:00:00
63d8f6a7387f4a698ea9bd4be970b703	aba49d54ebd141fe99e4ef894cf0affb	1110101	ddc066864db2451fb1aa2d361c7cdf50	2020-08-11 00:00:00	2020-03-06 15:00:00
66596491aa40439f8d9e4de3b78167df	aba49d54ebd141fe99e4ef894cf0affb	1100011	89ce173688844f758a2b66ff5d4dd972	2021-10-04 00:00:00	2021-02-02 12:00:00
544df2da00a64823a694d1a0e3a37dd1	aba49d54ebd141fe99e4ef894cf0affb	0011110	a5978474a8184bb582ea193ea86375f7	2020-12-06 03:00:00	2021-03-16 17:00:00
080073e052d044c2aa0f2a9aa0af6e18	aba49d54ebd141fe99e4ef894cf0affb	0111001	135833178c5e4a6695d219fabbaa7fb1	2021-11-25 09:00:00	2020-01-17 19:00:00
66596491aa40439f8d9e4de3b78167df	1f3c11d061a2484eab748f5e88d7aa4b	1110001	20ee67761ae847c2a8294c69caa6570c	2021-07-16 03:00:00	2020-03-12 15:00:00
544df2da00a64823a694d1a0e3a37dd1	1f3c11d061a2484eab748f5e88d7aa4b	1000000	a5a281c6b50c4af88988ecc8e1d79fc6	2020-09-21 04:00:00	2021-02-13 12:00:00
63d8f6a7387f4a698ea9bd4be970b703	1f3c11d061a2484eab748f5e88d7aa4b	0001011	92ec5f3985024df7a0eb7d7ffc869bbd	2020-09-24 03:00:00	2021-04-12 14:00:00
fbc657671dee42789cc24aef9801f2f5	1f3c11d061a2484eab748f5e88d7aa4b	1101011	9688291396654006b4876cffa20d19db	2020-08-02 09:00:00	2020-04-18 11:00:00
929b6d082d284741b34ec405557b6165	1f3c11d061a2484eab748f5e88d7aa4b	0110100	8123875ec07040b8b23c4c5019980d1d	2021-11-19 09:00:00	2021-04-21 16:00:00
544df2da00a64823a694d1a0e3a37dd1	6ae611adc6964fb5bdcce6a0eb40b3d9	0111010	3a485d7988af4d528371a525fb0fdfb0	2021-09-11 02:00:00	2021-05-06 12:00:00
dd0cc2ac37134a0fa463421c587ddcfe	6ae611adc6964fb5bdcce6a0eb40b3d9	0000000	6346168b87664022ab4e2b47e24cb358	2021-11-15 03:00:00	2021-04-20 18:00:00
63d8f6a7387f4a698ea9bd4be970b703	6ae611adc6964fb5bdcce6a0eb40b3d9	1001010	3fda963d307f4291b9af4673e866a2ad	2020-12-07 04:00:00	2020-05-12 18:00:00
5ed2a2c9262c4659978c7f253139ca99	43f71bb3b4b94cc8a0465feb7c12e39c	1000110	13b8929c8bb54db9a32512416debe826	2020-10-01 05:00:00	2021-02-14 12:00:00
66596491aa40439f8d9e4de3b78167df	43f71bb3b4b94cc8a0465feb7c12e39c	0111011	4942ef5c79554e548a12f0de33cbcc63	2020-07-14 07:00:00	2021-06-01 13:00:00
544df2da00a64823a694d1a0e3a37dd1	43f71bb3b4b94cc8a0465feb7c12e39c	1000001	fed53dc979644b5f95a81f9177e8ab5c	2020-10-07 08:00:00	2021-03-05 15:00:00
35067e78f6c64586b2ee37d04ac5b0b3	43f71bb3b4b94cc8a0465feb7c12e39c	1001110	22632000d1944ceda08f40a0ab1cad72	2021-08-07 06:00:00	2021-02-21 14:00:00
544df2da00a64823a694d1a0e3a37dd1	6cd6ec6fb7a947579496679d62045032	0010010	da31e69f856f43dfbb5680eb4ae82ba2	2020-11-21 07:00:00	2020-04-04 19:00:00
929b6d082d284741b34ec405557b6165	6cd6ec6fb7a947579496679d62045032	1110000	3215992af7e74630b869b96e33601017	2020-07-19 06:00:00	2021-02-10 13:00:00
66596491aa40439f8d9e4de3b78167df	6cd6ec6fb7a947579496679d62045032	0100010	952a04a49f5343c59f9e8d7452a45832	2021-10-19 04:00:00	2021-06-20 16:00:00
35067e78f6c64586b2ee37d04ac5b0b3	6cd6ec6fb7a947579496679d62045032	1011000	188eee6fb77b406d87f6f8eedf6e54a6	2021-11-21 07:00:00	2020-01-28 16:00:00
5ed2a2c9262c4659978c7f253139ca99	7f4a90e4cd4c4e26be0d6354cbe57908	1101011	c17be62db92d4501ab6cc90e9c2d43d4	2021-09-08 06:00:00	2020-01-18 16:00:00
929b6d082d284741b34ec405557b6165	7f4a90e4cd4c4e26be0d6354cbe57908	1000000	b5801801891b44c4a98d348a2de33388	2021-09-05 09:00:00	2021-04-13 16:00:00
544df2da00a64823a694d1a0e3a37dd1	7f4a90e4cd4c4e26be0d6354cbe57908	1000010	a1ddca7271744a63a7cb1179df19663e	2021-07-08 01:00:00	2020-05-20 13:00:00
fbc657671dee42789cc24aef9801f2f5	7f4a90e4cd4c4e26be0d6354cbe57908	0010011	0177ad079c5145ac9babf5d973576357	2020-12-21 05:00:00	2021-04-28 11:00:00
544df2da00a64823a694d1a0e3a37dd1	f09aec7ab42d449286097ab358e4c82d	1100001	75b24c2a27e4485e8cdda24c30e8bc82	2021-11-23 04:00:00	2021-02-13 13:00:00
66596491aa40439f8d9e4de3b78167df	f5d10093a1bc42aaa572866f53c8f015	1111111	b26fc2d3d294477d88a24329997634bf	2020-09-05 08:00:00	2021-06-20 13:00:00
080073e052d044c2aa0f2a9aa0af6e18	f09aec7ab42d449286097ab358e4c82d	0001001	78a00dfecdb44e5488fc0018c6916bf0	2021-07-17 07:00:00	2020-06-23 20:00:00
5ed2a2c9262c4659978c7f253139ca99	f09aec7ab42d449286097ab358e4c82d	0000011	2e43f17d1baa4fd78a75c8e737e49d13	2020-09-21 00:00:00	2021-05-09 11:00:00
dd0cc2ac37134a0fa463421c587ddcfe	1ff07001acf64f07a6c29a66f687cd68	0111101	68eb21e936454e66b711c91307d53ce2	2021-07-24 03:00:00	2021-06-16 20:00:00
929b6d082d284741b34ec405557b6165	1ff07001acf64f07a6c29a66f687cd68	0000100	55506b03c5004dd2a2225d28901be8a3	2020-07-12 07:00:00	2021-02-15 13:00:00
66596491aa40439f8d9e4de3b78167df	1ff07001acf64f07a6c29a66f687cd68	1110100	fbe32fb869154a4a93bc97875ef8d7fa	2021-11-25 07:00:00	2021-02-04 18:00:00
9e3015acf41e43318c712811789f4608	1ff07001acf64f07a6c29a66f687cd68	0101010	0454a3665de248f39013d076c859eb2a	2021-10-05 09:00:00	2021-02-11 19:00:00
544df2da00a64823a694d1a0e3a37dd1	1ff07001acf64f07a6c29a66f687cd68	0111011	b85fe8379d034e9babc34f40c707f66b	2021-07-12 08:00:00	2020-03-18 13:00:00
8acc4d9a7b43434c970c4fc3a34d18af	4e66448df6ce45579d5328a179739d17	1100100	2a0230afe43b4e638f7628a8ee41fef6	2020-08-24 02:00:00	2021-05-18 15:00:00
9e3015acf41e43318c712811789f4608	4e66448df6ce45579d5328a179739d17	0000011	9899fb39d6944f67b30f3da7fb415811	2020-10-28 02:00:00	2020-06-24 15:00:00
544df2da00a64823a694d1a0e3a37dd1	4e66448df6ce45579d5328a179739d17	0010011	c47635cc0ae044ffb6bf0777d974d726	2020-10-25 05:00:00	2020-06-18 18:00:00
929b6d082d284741b34ec405557b6165	4e66448df6ce45579d5328a179739d17	0011010	6d209db0b9c542b2b81b01f081784351	2020-09-18 05:00:00	2020-03-04 14:00:00
080073e052d044c2aa0f2a9aa0af6e18	4e66448df6ce45579d5328a179739d17	0111010	3735556c92b5449793e8440efd419a02	2020-12-27 08:00:00	2021-01-27 19:00:00
080073e052d044c2aa0f2a9aa0af6e18	c4b5cc01c43e423d9e0d7d9c7cbf218d	0000001	fa4ca1baca904433b02737961ee89a96	2021-09-07 08:00:00	2020-02-26 18:00:00
929b6d082d284741b34ec405557b6165	c4b5cc01c43e423d9e0d7d9c7cbf218d	1001001	4a1578f3ba9949dba7f992f04e1bb477	2021-07-02 04:00:00	2021-04-28 14:00:00
66596491aa40439f8d9e4de3b78167df	c4b5cc01c43e423d9e0d7d9c7cbf218d	1011110	5bf2b20a39ac4f249b38a74fbdfa5674	2021-12-11 02:00:00	2020-06-24 17:00:00
544df2da00a64823a694d1a0e3a37dd1	c4b5cc01c43e423d9e0d7d9c7cbf218d	0111000	3c36f6879ac040ad8d8e7d5c51f8044b	2021-09-06 06:00:00	2020-06-12 14:00:00
5ed2a2c9262c4659978c7f253139ca99	2640b3c542164f52be8073c1efa59885	1000011	687449acfbfc42ea8c6f358569ba33a3	2021-11-06 04:00:00	2020-02-06 17:00:00
63d8f6a7387f4a698ea9bd4be970b703	2640b3c542164f52be8073c1efa59885	0010101	f3110385175b4fe4a2d0d15d5935d344	2020-10-21 09:00:00	2020-01-25 18:00:00
080073e052d044c2aa0f2a9aa0af6e18	2640b3c542164f52be8073c1efa59885	0111101	ec7d16bc401144a1bb4e9e5342b34b7d	2021-12-19 01:00:00	2020-02-18 13:00:00
fbc657671dee42789cc24aef9801f2f5	13637517bff842b4b622680197701aa1	1101011	5124cdd42a3d49e88f75bf435b4abbd9	2020-11-07 02:00:00	2020-06-05 17:00:00
35067e78f6c64586b2ee37d04ac5b0b3	13637517bff842b4b622680197701aa1	1000000	8cf2c43a2bd6407ca9fed63b75f941c0	2021-11-15 01:00:00	2020-03-19 17:00:00
8acc4d9a7b43434c970c4fc3a34d18af	13637517bff842b4b622680197701aa1	0101011	ec7f3212d7ff416cbaa1cf3ac50b8ce8	2021-12-04 08:00:00	2021-04-09 14:00:00
9e3015acf41e43318c712811789f4608	0daf05c1e5c2454ab92e1e66426944f8	0100011	2522328fb1394954aeb980128bbf642d	2020-09-19 08:00:00	2020-02-28 13:00:00
8acc4d9a7b43434c970c4fc3a34d18af	0daf05c1e5c2454ab92e1e66426944f8	0001111	ecfeafda9c3444a594606466fa7e190a	2021-07-09 03:00:00	2021-06-13 15:00:00
dd0cc2ac37134a0fa463421c587ddcfe	0daf05c1e5c2454ab92e1e66426944f8	0010001	8f059a91b7f24c83a17e33931f4e4e79	2020-11-24 05:00:00	2020-06-17 15:00:00
929b6d082d284741b34ec405557b6165	f0d9badc1ba84ce29aeb5ad1b789af56	1010000	ab008ca4bf6f454f9c6f05b4dd0c3495	2021-08-13 03:00:00	2021-06-12 12:00:00
fbc657671dee42789cc24aef9801f2f5	f0d9badc1ba84ce29aeb5ad1b789af56	1100010	c506ffdfff464354b96c7869bbddd5ce	2020-08-24 08:00:00	2021-04-25 16:00:00
dd0cc2ac37134a0fa463421c587ddcfe	f0d9badc1ba84ce29aeb5ad1b789af56	1110001	37fac90b15984ec29c3277ee88cf0881	2021-11-17 05:00:00	2021-03-14 11:00:00
080073e052d044c2aa0f2a9aa0af6e18	f0d9badc1ba84ce29aeb5ad1b789af56	0111111	8620140ecc3f43b3a83df7dc87a72046	2020-12-09 03:00:00	2021-02-27 11:00:00
544df2da00a64823a694d1a0e3a37dd1	01b0f9b796294181b2d4e6fab67b6330	0111100	1b4f9903f9364eb58ac2a3ae757d2344	2021-12-28 04:00:00	2021-01-07 13:00:00
5ed2a2c9262c4659978c7f253139ca99	01b0f9b796294181b2d4e6fab67b6330	0100111	da41b65374094c76bafbb83f6ff82948	2021-08-08 02:00:00	2020-02-21 17:00:00
080073e052d044c2aa0f2a9aa0af6e18	01b0f9b796294181b2d4e6fab67b6330	0110101	d8ff48b847144d9cb3b7357066cc23b6	2020-10-04 04:00:00	2021-02-27 17:00:00
66596491aa40439f8d9e4de3b78167df	01b0f9b796294181b2d4e6fab67b6330	1011000	71b09f62b71a492288ee42940368b7a8	2021-07-02 03:00:00	2021-03-06 12:00:00
35067e78f6c64586b2ee37d04ac5b0b3	3277984aaf834582a1a07f6ffc0bcc48	1011010	6a84f535d2b1476a88b554335d1bce92	2021-10-12 04:00:00	2021-05-17 16:00:00
080073e052d044c2aa0f2a9aa0af6e18	3277984aaf834582a1a07f6ffc0bcc48	0101111	b7d7fe3012e54e26aeb03f542fdf109f	2020-09-05 04:00:00	2021-04-28 12:00:00
8acc4d9a7b43434c970c4fc3a34d18af	3277984aaf834582a1a07f6ffc0bcc48	0000100	7a9c703fdea2429e852c0ff7d1d1eca5	2020-09-15 05:00:00	2021-02-26 13:00:00
9e3015acf41e43318c712811789f4608	49b6956075fd4a0bb1e99a952c514c25	0000110	2962c4720b1841a5a49d78d677b3db73	2020-08-15 01:00:00	2020-04-14 12:00:00
5ed2a2c9262c4659978c7f253139ca99	49b6956075fd4a0bb1e99a952c514c25	1110101	342c6c1b1e5a4d2689cda99dc23a8ef2	2021-11-06 06:00:00	2020-03-16 13:00:00
66596491aa40439f8d9e4de3b78167df	49b6956075fd4a0bb1e99a952c514c25	1100010	372ae2c210c04a3db87b48c124e83773	2020-09-09 05:00:00	2021-03-25 18:00:00
080073e052d044c2aa0f2a9aa0af6e18	49b6956075fd4a0bb1e99a952c514c25	1101101	081602ce500f4b41b510660610ca8fea	2021-09-03 06:00:00	2020-03-08 11:00:00
929b6d082d284741b34ec405557b6165	5fba2de429154305adf0f240ab3095fd	1101101	f235896f2b754e00bf2beb4217e1acaa	2020-09-23 03:00:00	2021-04-03 16:00:00
5ed2a2c9262c4659978c7f253139ca99	5fba2de429154305adf0f240ab3095fd	1110011	294238091d9c450fbcbfcc986390e767	2021-10-15 01:00:00	2021-01-22 12:00:00
9e3015acf41e43318c712811789f4608	5fba2de429154305adf0f240ab3095fd	1010011	6e4b03af37f748bc8140b80559b5426e	2021-09-18 00:00:00	2021-06-07 17:00:00
35067e78f6c64586b2ee37d04ac5b0b3	5fba2de429154305adf0f240ab3095fd	0000000	646194550df94ed7a7823027fab71470	2021-10-12 01:00:00	2021-03-14 15:00:00
66596491aa40439f8d9e4de3b78167df	c5357362b2ba48be8c111dd7f5cf2f91	1100010	e169c64ee2d6409a9b7b824ef6a076a2	2020-09-14 01:00:00	2020-02-21 12:00:00
dd0cc2ac37134a0fa463421c587ddcfe	c5357362b2ba48be8c111dd7f5cf2f91	0111000	12f2ae5839e84b40a133b66033a6e9af	2020-10-25 02:00:00	2021-04-01 11:00:00
080073e052d044c2aa0f2a9aa0af6e18	c5357362b2ba48be8c111dd7f5cf2f91	0110000	ab8ba519db89417eaef5eb687ebad4a4	2021-07-26 03:00:00	2020-06-11 20:00:00
929b6d082d284741b34ec405557b6165	c5357362b2ba48be8c111dd7f5cf2f91	1001111	a908908f62dc43b085ce22e22c310568	2020-09-13 02:00:00	2020-02-02 19:00:00
929b6d082d284741b34ec405557b6165	82bf84edcb614b549d4cd7efdd4d7f51	1001010	a55b9cae4abf4966856e675806ce58c3	2020-10-28 07:00:00	2020-05-11 17:00:00
fbc657671dee42789cc24aef9801f2f5	82bf84edcb614b549d4cd7efdd4d7f51	1011111	068e97cc38d7422cb432b4b2c2da333e	2020-12-03 07:00:00	2021-01-24 13:00:00
dd0cc2ac37134a0fa463421c587ddcfe	82bf84edcb614b549d4cd7efdd4d7f51	0111110	43f0f2d8dcd84021b1d9d84f6de870e9	2020-09-13 01:00:00	2020-05-13 19:00:00
9e3015acf41e43318c712811789f4608	8834cafa0b904865942a5dea137fa899	1011010	a14d272f849840bebb6d6df4678a78de	2020-10-10 04:00:00	2020-05-18 17:00:00
66596491aa40439f8d9e4de3b78167df	8834cafa0b904865942a5dea137fa899	1100010	2d0b72ee98bb4bb484b225b85499f90e	2021-09-14 09:00:00	2020-03-14 15:00:00
fbc657671dee42789cc24aef9801f2f5	8834cafa0b904865942a5dea137fa899	1000110	5d9660922b7b487281ad7eec9d44bc35	2020-12-17 00:00:00	2021-06-11 20:00:00
8acc4d9a7b43434c970c4fc3a34d18af	8834cafa0b904865942a5dea137fa899	0001001	4e26f3121b9b49398bb881e640fca016	2021-08-09 07:00:00	2021-02-18 18:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	1111111	f0591b2990f94ddf9cadfa6d1bd76139	2020-07-06 01:00:00	2021-03-04 20:00:00
dd0cc2ac37134a0fa463421c587ddcfe	f5d10093a1bc42aaa572866f53c8f015	1111111	be556335b4a4494480193de53ed81152	2021-12-04 03:00:00	2020-05-10 14:00:00
5ed2a2c9262c4659978c7f253139ca99	6ae611adc6964fb5bdcce6a0eb40b3d9	1111111	e1e91f7517f44d5a8b629b21966da0f9	2021-08-04 07:00:00	2021-03-24 15:00:00
63d8f6a7387f4a698ea9bd4be970b703	6cd6ec6fb7a947579496679d62045032	1111111	9e0fe873250a43c3be59f72b094fac51	2021-11-07 03:00:00	2020-01-22 13:00:00
9e3015acf41e43318c712811789f4608	7f4a90e4cd4c4e26be0d6354cbe57908	1111111	a2b93d23d56949ef859cf49c295a2bd7	2020-11-06 02:00:00	2020-03-23 13:00:00
dd0cc2ac37134a0fa463421c587ddcfe	7f4a90e4cd4c4e26be0d6354cbe57908	1111111	6476c92a530148898d763ba61d512cab	2021-09-15 00:00:00	2021-05-02 17:00:00
35067e78f6c64586b2ee37d04ac5b0b3	f09aec7ab42d449286097ab358e4c82d	1111111	0150b5ac613246d0a80fb70e67285a3e	2021-10-25 03:00:00	2021-06-05 13:00:00
63d8f6a7387f4a698ea9bd4be970b703	4e66448df6ce45579d5328a179739d17	0000000	69a9bc804a684b7885607119a74fcddc	2020-09-18 05:00:00	2021-06-22 12:00:00
5ed2a2c9262c4659978c7f253139ca99	c4b5cc01c43e423d9e0d7d9c7cbf218d	0000000	ae0dd39059fe4ee890309688d1f96b6d	2021-09-16 03:00:00	2020-03-01 17:00:00
dd0cc2ac37134a0fa463421c587ddcfe	c4b5cc01c43e423d9e0d7d9c7cbf218d	0000000	a52e261f5977443a90be08868761d740	2020-10-08 03:00:00	2021-01-28 11:00:00
9e3015acf41e43318c712811789f4608	2640b3c542164f52be8073c1efa59885	0000000	0f24946f65a94234abd57a6a8ce8512d	2021-09-22 07:00:00	2021-05-14 14:00:00
5ed2a2c9262c4659978c7f253139ca99	13637517bff842b4b622680197701aa1	0000000	cc321eb0ce8b40859b0682424827c32a	2021-12-01 02:00:00	2020-02-02 18:00:00
dd0cc2ac37134a0fa463421c587ddcfe	13637517bff842b4b622680197701aa1	0000000	b772d477a61144f6a797078140ab1b11	2021-11-12 04:00:00	2020-06-19 16:00:00
66596491aa40439f8d9e4de3b78167df	13637517bff842b4b622680197701aa1	0000000	24ef6fd339d244999bbc6c7e15e8a77f	2021-07-13 08:00:00	2020-02-23 13:00:00
fbc657671dee42789cc24aef9801f2f5	0daf05c1e5c2454ab92e1e66426944f8	0000000	15b0de74438d44bb8973e50937892ef2	2021-12-10 09:00:00	2021-01-26 19:00:00
35067e78f6c64586b2ee37d04ac5b0b3	0daf05c1e5c2454ab92e1e66426944f8	0000000	68505cf7b6c0423bb92aa0fb1e47b5d4	2021-07-27 06:00:00	2021-01-04 18:00:00
544df2da00a64823a694d1a0e3a37dd1	f0d9badc1ba84ce29aeb5ad1b789af56	0000000	2165ef0118254a07a368084084f7530a	2020-09-24 06:00:00	2020-04-04 20:00:00
9e3015acf41e43318c712811789f4608	01b0f9b796294181b2d4e6fab67b6330	0000000	88d0499151f84ebf9e370b50bc8bdb80	2021-12-17 09:00:00	2021-01-07 19:00:00
63d8f6a7387f4a698ea9bd4be970b703	3277984aaf834582a1a07f6ffc0bcc48	0000000	560e269e961b47e2a34171ae00eb8667	2020-08-09 05:00:00	2020-03-15 17:00:00
dd0cc2ac37134a0fa463421c587ddcfe	49b6956075fd4a0bb1e99a952c514c25	0000000	8bde91bb83e340248de8f2867e9418e3	2021-07-28 00:00:00	2020-04-09 12:00:00
8acc4d9a7b43434c970c4fc3a34d18af	5fba2de429154305adf0f240ab3095fd	0000000	ddf23813a7114e3a8446cc2ca681528c	2020-07-02 09:00:00	2020-05-12 12:00:00
63d8f6a7387f4a698ea9bd4be970b703	c5357362b2ba48be8c111dd7f5cf2f91	0000000	6e9048dcc30f4f73b6c87bcba450b1d6	2020-11-24 00:00:00	2020-06-01 12:00:00
35067e78f6c64586b2ee37d04ac5b0b3	c5357362b2ba48be8c111dd7f5cf2f91	0000000	b32902f1f49f4413af30c29775f86d0b	2021-08-16 09:00:00	2020-01-08 19:00:00
8acc4d9a7b43434c970c4fc3a34d18af	82bf84edcb614b549d4cd7efdd4d7f51	0000000	fcbdf2046a9844f5a4fc40b1068aca7a	2021-12-18 09:00:00	2020-05-12 20:00:00
080073e052d044c2aa0f2a9aa0af6e18	8834cafa0b904865942a5dea137fa899	0000000	57713fe723e249a9a975a75f09c94f67	2021-12-15 04:00:00	2021-01-21 14:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	557a8d7effa4403b9476c65e28d5a895	2020-09-26 09:00:00	2020-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	ade6ed5ad35e40519717b137d8524f32	2020-09-26 09:00:00	2020-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	f8767ae90b414c96b5db6da433cff052	2021-09-26 09:00:00	2021-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	936920635ce34c01a285c527ee597ab6	2022-09-26 09:00:00	2022-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	bccd6f9c3b8349bd8f30f449d213b045	2025-09-26 09:00:00	2025-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	cf04018aab5e41129a3159ccaef41129	2022-09-26 09:00:00	2022-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	4a03428f8f924add9f24ebe3a57cc97c	2022-09-26 09:00:00	2022-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	6593baf1f7e245f594451afc59d4cc2e	2022-09-26 09:00:00	2022-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	8ec977556e9d4cc4b01d95f7fdc4bdc1	2025-09-26 09:00:00	2025-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	4d49bed8a75445d0bd1d49092203825c	2025-09-26 09:00:00	2025-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	5b91d2e340f14482bb117ed49e567994	2025-09-26 09:00:00	2025-05-22 20:00:00
63d8f6a7387f4a698ea9bd4be970b703	f5d10093a1bc42aaa572866f53c8f015	0000000	b8b122a8c9b449e48a2ddcf437436dc6	2025-09-26 09:00:00	2025-05-22 20:00:00
dd0cc2ac37134a0fa463421c587ddcfe	49b6956075fd4a0bb1e99a952c514c25	0000000	1d9c350fb813430fb113f4684ae1a28b	2021-01-13 02:00:00	2021-01-13 03:30:00
\.


--
-- TOC entry 3899 (class 0 OID 8393307)
-- Dependencies: 206
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: icfjttdivtiins
--

COPY public.vehicle (registration_number, person_uuid) FROM stdin;
ZG1236AA	dd0cc2ac37134a0fa463421c587ddcfe
xx443xx	15d26a3b7b6e4836ba57f73ca87320fc
ČK123CC	544df2da00a64823a694d1a0e3a37dd1
ST365AC	35067e78f6c64586b2ee37d04ac5b0b3
DU222TZ	35067e78f6c64586b2ee37d04ac5b0b3
ZD824JK	66596491aa40439f8d9e4de3b78167df
RI221UL	8acc4d9a7b43434c970c4fc3a34d18af
RI1282CC	8acc4d9a7b43434c970c4fc3a34d18af
ZD2222RT	8acc4d9a7b43434c970c4fc3a34d18af
ZG098ZZ	9e3015acf41e43318c712811789f4608
Zd444Ac	fbc657671dee42789cc24aef9801f2f5
PU1234AB	63d8f6a7387f4a698ea9bd4be970b703
RI4562ZZ	63d8f6a7387f4a698ea9bd4be970b703
fa150tt	929b6d082d284741b34ec405557b6165
ZG1245BG	080073e052d044c2aa0f2a9aa0af6e18
aa497aa	5ed2a2c9262c4659978c7f253139ca99
aa213gg	5ed2a2c9262c4659978c7f253139ca99
PU1234AB	24885c35ebcf44f4ab6f2c8729805bcb
RI4562ZZ	24885c35ebcf44f4ab6f2c8729805bcb
\.


--
-- TOC entry 3749 (class 2606 OID 9124588)
-- Name: administrator administrator_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_pk PRIMARY KEY (administrator_uuid);


--
-- TOC entry 3735 (class 2606 OID 8442194)
-- Name: app_user app_user_email_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_un UNIQUE (email);


--
-- TOC entry 3737 (class 2606 OID 8442950)
-- Name: app_user app_user_oib_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_oib_un UNIQUE (oib);


--
-- TOC entry 3739 (class 2606 OID 8787660)
-- Name: app_user app_user_uuid_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_uuid_pk PRIMARY KEY (user_uuid);


--
-- TOC entry 3743 (class 2606 OID 10476504)
-- Name: company company_name_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_name_un UNIQUE (name);


--
-- TOC entry 3745 (class 2606 OID 9124586)
-- Name: company company_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pk PRIMARY KEY (company_uuid);


--
-- TOC entry 3747 (class 2606 OID 10475751)
-- Name: company company_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_un UNIQUE (headquarter_address);


--
-- TOC entry 3756 (class 2606 OID 10477176)
-- Name: parking_object parking_object_address_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_address_un UNIQUE (address);


--
-- TOC entry 3758 (class 2606 OID 10477178)
-- Name: parking_object parking_object_name_un; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_name_un UNIQUE (object_name);


--
-- TOC entry 3760 (class 2606 OID 9171225)
-- Name: parking_object parking_object_pkey; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT parking_object_pkey PRIMARY KEY (object_uuid);


--
-- TOC entry 3741 (class 2606 OID 9124584)
-- Name: person person_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pk PRIMARY KEY (person_uuid);


--
-- TOC entry 3754 (class 2606 OID 10847113)
-- Name: reservation reservation_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pk PRIMARY KEY (reservation_uuid);


--
-- TOC entry 3752 (class 2606 OID 9124395)
-- Name: vehicle vehicle_pk; Type: CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pk PRIMARY KEY (registration_number, person_uuid);


--
-- TOC entry 3750 (class 1259 OID 9124444)
-- Name: vehicle_owner_uuid_idx; Type: INDEX; Schema: public; Owner: icfjttdivtiins
--

CREATE INDEX vehicle_owner_uuid_idx ON public.vehicle USING btree (person_uuid);


--
-- TOC entry 3768 (class 2620 OID 11005092)
-- Name: vehicle vehicle_delete; Type: TRIGGER; Schema: public; Owner: icfjttdivtiins
--

CREATE TRIGGER vehicle_delete BEFORE DELETE ON public.vehicle FOR EACH ROW EXECUTE FUNCTION public.vehicle_delete();


--
-- TOC entry 3763 (class 2606 OID 9171299)
-- Name: administrator fk_administrator_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT fk_administrator_app_user FOREIGN KEY (administrator_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3762 (class 2606 OID 9171294)
-- Name: company fk_company_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT fk_company_app_user FOREIGN KEY (company_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3767 (class 2606 OID 9171275)
-- Name: parking_object fk_parking_object_company; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.parking_object
    ADD CONSTRAINT fk_parking_object_company FOREIGN KEY (company_uuid) REFERENCES public.company(company_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3761 (class 2606 OID 9171289)
-- Name: person fk_person_app_user; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT fk_person_app_user FOREIGN KEY (person_uuid) REFERENCES public.app_user(user_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3765 (class 2606 OID 9171265)
-- Name: reservation fk_reservation_parking_object; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT fk_reservation_parking_object FOREIGN KEY (object_uuid) REFERENCES public.parking_object(object_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3764 (class 2606 OID 9171281)
-- Name: vehicle fk_vehicle_person; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle_person FOREIGN KEY (person_uuid) REFERENCES public.person(person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3766 (class 2606 OID 10847252)
-- Name: reservation reservation_fk; Type: FK CONSTRAINT; Schema: public; Owner: icfjttdivtiins
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_fk FOREIGN KEY (person_uuid) REFERENCES public.person(person_uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3908 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: icfjttdivtiins
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO icfjttdivtiins;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3909 (class 0 OID 0)
-- Dependencies: 650
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO icfjttdivtiins;


-- Completed on 2021-01-13 13:31:51

--
-- PostgreSQL database dump complete
--

