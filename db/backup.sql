--
-- PostgreSQL database dump
--

\restrict ZOFT8ZWiqK14c4XTZvpT9TIdqncfpMcAhXKRlfhlLmQVT6eWAvcQLMfUlVmnMFN

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
--SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_manager_id_fkey;
ALTER TABLE IF EXISTS ONLY public.timbrature DROP CONSTRAINT IF EXISTS timbrature_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.requests DROP CONSTRAINT IF EXISTS requests_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.leave_balance DROP CONSTRAINT IF EXISTS leave_balance_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.auth_login_attempts DROP CONSTRAINT IF EXISTS auth_login_attempts_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.auth_credentials DROP CONSTRAINT IF EXISTS auth_credentials_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approvals DROP CONSTRAINT IF EXISTS approvals_request_id_fkey;
ALTER TABLE IF EXISTS ONLY public.approvals DROP CONSTRAINT IF EXISTS approvals_approver_id_fkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.timbrature DROP CONSTRAINT IF EXISTS timbrature_pkey;
ALTER TABLE IF EXISTS ONLY public.requests DROP CONSTRAINT IF EXISTS requests_pkey;
ALTER TABLE IF EXISTS ONLY public.leave_balance DROP CONSTRAINT IF EXISTS leave_balance_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_login_attempts DROP CONSTRAINT IF EXISTS auth_login_attempts_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_credentials DROP CONSTRAINT IF EXISTS auth_credentials_pkey;
ALTER TABLE IF EXISTS ONLY public.approvals DROP CONSTRAINT IF EXISTS approvals_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.timbrature ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.requests ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.leave_balance ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.auth_login_attempts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.auth_credentials ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.approvals ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.user_roles_id_seq;
DROP TABLE IF EXISTS public.user_roles;
DROP SEQUENCE IF EXISTS public.timbrature_id_seq;
DROP TABLE IF EXISTS public.timbrature;
DROP SEQUENCE IF EXISTS public.requests_id_seq;
DROP TABLE IF EXISTS public.requests;
DROP SEQUENCE IF EXISTS public.leave_balance_id_seq;
DROP TABLE IF EXISTS public.leave_balance;
DROP SEQUENCE IF EXISTS public.auth_login_attempts_id_seq;
DROP TABLE IF EXISTS public.auth_login_attempts;
DROP SEQUENCE IF EXISTS public.auth_credentials_id_seq;
DROP TABLE IF EXISTS public.auth_credentials;
DROP SEQUENCE IF EXISTS public.approvals_id_seq;
DROP TABLE IF EXISTS public.approvals;
DROP TYPE IF EXISTS public.request_type;
DROP TYPE IF EXISTS public.login_result;
DROP TYPE IF EXISTS public.location_type;
DROP TYPE IF EXISTS public.approval_status;
DROP TYPE IF EXISTS public.action_type;
--
-- Name: action_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.action_type AS ENUM (
    'ENTRATA',
    'USCITA'
);


ALTER TYPE public.action_type OWNER TO postgres;

--
-- Name: approval_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.approval_status AS ENUM (
    'APPROVED',
    'REJECTED',
    'REVOKED'
);


ALTER TYPE public.approval_status OWNER TO postgres;

--
-- Name: location_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.location_type AS ENUM (
    'UFFICIO',
    'SMART'
);


ALTER TYPE public.location_type OWNER TO postgres;

--
-- Name: login_result; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.login_result AS ENUM (
    'SUCCESS',
    'FAILURE'
);


ALTER TYPE public.login_result OWNER TO postgres;

--
-- Name: request_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.request_type AS ENUM (
    'FERIE',
    'PERMESSO'
);


ALTER TYPE public.request_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: approvals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.approvals (
    id integer NOT NULL,
    request_id integer NOT NULL,
    approver_id integer NOT NULL,
    status public.approval_status NOT NULL,
    comments text,
    approved_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.approvals OWNER TO postgres;

--
-- Name: approvals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.approvals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.approvals_id_seq OWNER TO postgres;

--
-- Name: approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.approvals_id_seq OWNED BY public.approvals.id;


--
-- Name: auth_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_credentials (
    id integer NOT NULL,
    user_id integer NOT NULL,
    password_hash character varying(255) NOT NULL,
    salt character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.auth_credentials OWNER TO postgres;

--
-- Name: auth_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_credentials_id_seq OWNER TO postgres;

--
-- Name: auth_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_credentials_id_seq OWNED BY public.auth_credentials.id;


--
-- Name: auth_login_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_login_attempts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    result public.login_result NOT NULL
);


ALTER TABLE public.auth_login_attempts OWNER TO postgres;

--
-- Name: auth_login_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_login_attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_login_attempts_id_seq OWNER TO postgres;

--
-- Name: auth_login_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_login_attempts_id_seq OWNED BY public.auth_login_attempts.id;


--
-- Name: leave_balance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leave_balance (
    id integer NOT NULL,
    user_id integer NOT NULL,
    accumulated_holidays numeric(5,1) DEFAULT 0 NOT NULL,
    accumulated_permits numeric(5,1) DEFAULT 0 NOT NULL,
    modified_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.leave_balance OWNER TO postgres;

--
-- Name: leave_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leave_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leave_balance_id_seq OWNER TO postgres;

--
-- Name: leave_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leave_balance_id_seq OWNED BY public.leave_balance.id;


--
-- Name: requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requests (
    id integer NOT NULL,
    user_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    request_type public.request_type NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.requests OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.requests_id_seq OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requests_id_seq OWNED BY public.requests.id;


--
-- Name: timbrature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timbrature (
    id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    action_type public.action_type NOT NULL,
    location public.location_type NOT NULL,
    geolocation character varying(100)
);


ALTER TABLE public.timbrature OWNER TO postgres;

--
-- Name: timbrature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.timbrature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.timbrature_id_seq OWNER TO postgres;

--
-- Name: timbrature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.timbrature_id_seq OWNED BY public.timbrature.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    hierarchy_level integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_id_seq OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    role_id integer,
    manager_id integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: approvals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvals ALTER COLUMN id SET DEFAULT nextval('public.approvals_id_seq'::regclass);


--
-- Name: auth_credentials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_credentials ALTER COLUMN id SET DEFAULT nextval('public.auth_credentials_id_seq'::regclass);


--
-- Name: auth_login_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_login_attempts ALTER COLUMN id SET DEFAULT nextval('public.auth_login_attempts_id_seq'::regclass);


--
-- Name: leave_balance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balance ALTER COLUMN id SET DEFAULT nextval('public.leave_balance_id_seq'::regclass);


--
-- Name: requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests ALTER COLUMN id SET DEFAULT nextval('public.requests_id_seq'::regclass);


--
-- Name: timbrature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timbrature ALTER COLUMN id SET DEFAULT nextval('public.timbrature_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: approvals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.approvals (id, request_id, approver_id, status, comments, approved_at) FROM stdin;
\.


--
-- Data for Name: auth_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_credentials (id, user_id, password_hash, salt, created_at, modified_at) FROM stdin;
1	5	$2a$12$Tr/pxsX09sd4dcZOc02DWei9t4yFNgnGuCwPfAn3fNM0VpAsL968O	66f1f672c7429a3b28592f61f9548f81	2025-09-01 21:25:33.852672	2025-09-01 22:10:42.531114
2	7	$2a$12$2JYhASW5L42j0PONV80hV.ka9QzwIrRNguryZ8VpNcnlT/F6ZkNuS	0c6ca7b03e4d74ebbe77d6e42e503aa9	2025-09-03 01:11:40.148202	2025-09-03 01:11:40.148202
\.


--
-- Data for Name: auth_login_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_login_attempts (id, user_id, "timestamp", result) FROM stdin;
1	5	2025-09-01 21:25:34.093791	SUCCESS
2	5	2025-09-01 21:25:53.020016	SUCCESS
3	5	2025-09-01 21:25:56.147273	SUCCESS
4	5	2025-09-01 21:27:56.985095	SUCCESS
5	5	2025-09-01 21:30:49.858928	SUCCESS
6	5	2025-09-01 21:31:33.338159	SUCCESS
7	5	2025-09-01 21:31:38.983358	SUCCESS
8	5	2025-09-01 21:31:40.440614	SUCCESS
9	5	2025-09-01 21:36:01.370753	SUCCESS
10	5	2025-09-01 21:40:19.272744	FAILURE
11	5	2025-09-01 21:40:31.086818	SUCCESS
12	5	2025-09-01 21:40:36.293839	FAILURE
13	5	2025-09-01 21:40:39.796434	SUCCESS
14	5	2025-09-01 22:09:30.454089	FAILURE
15	5	2025-09-01 22:09:35.709571	FAILURE
16	5	2025-09-01 22:09:46.948507	FAILURE
17	5	2025-09-01 22:10:11.586644	FAILURE
18	5	2025-09-01 22:10:32.52855	SUCCESS
19	5	2025-09-01 22:10:45.912311	FAILURE
20	5	2025-09-01 22:10:48.158516	FAILURE
21	5	2025-09-01 22:10:50.653517	FAILURE
22	5	2025-09-01 22:13:24.751659	FAILURE
23	5	2025-09-01 22:13:37.962074	SUCCESS
24	5	2025-09-01 22:16:55.092805	SUCCESS
25	5	2025-09-02 00:11:00.903931	SUCCESS
26	5	2025-09-02 00:15:08.453211	SUCCESS
27	5	2025-09-02 00:15:13.864514	SUCCESS
28	5	2025-09-02 00:24:21.420886	SUCCESS
29	5	2025-09-02 00:24:24.362652	SUCCESS
30	5	2025-09-02 00:24:25.612454	SUCCESS
31	5	2025-09-02 00:24:26.456313	SUCCESS
32	5	2025-09-02 00:24:27.199696	SUCCESS
33	5	2025-09-02 00:24:27.843289	SUCCESS
34	5	2025-09-02 00:24:28.370381	SUCCESS
35	5	2025-09-02 00:24:29.320234	SUCCESS
36	5	2025-09-02 00:24:29.807711	SUCCESS
37	5	2025-09-02 00:24:30.427194	SUCCESS
38	5	2025-09-02 00:24:31.272306	SUCCESS
39	5	2025-09-02 00:24:42.482883	SUCCESS
40	5	2025-09-02 22:05:56.372548	SUCCESS
41	5	2025-09-02 23:33:21.634095	SUCCESS
42	5	2025-09-02 23:34:43.44327	SUCCESS
43	7	2025-09-03 01:11:40.372113	SUCCESS
44	7	2025-09-03 01:13:25.998623	SUCCESS
45	5	2025-09-03 01:16:39.474595	SUCCESS
\.


--
-- Data for Name: leave_balance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_balance (id, user_id, accumulated_holidays, accumulated_permits, modified_at) FROM stdin;
1	1	240.0	80.0	2025-08-29 19:27:43.693626
2	2	200.0	70.0	2025-08-29 19:27:43.693626
3	3	180.0	60.0	2025-08-29 19:27:43.693626
4	4	160.0	55.0	2025-08-29 19:27:43.693626
\.


--
-- Data for Name: requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requests (id, user_id, start_date, end_date, request_type, notes, created_at) FROM stdin;
\.


--
-- Data for Name: timbrature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timbrature (id, user_id, "timestamp", action_type, location, geolocation) FROM stdin;
1	5	2025-09-03 00:22:21.372723	ENTRATA	SMART	\N
2	5	2025-09-03 00:26:21.303913	USCITA	SMART	\N
3	5	2025-09-03 00:29:05.061679	ENTRATA	SMART	\N
4	5	2025-09-03 00:30:53.794181	USCITA	SMART	\N
5	5	2025-09-03 00:35:35.024895	ENTRATA	UFFICIO	\N
6	5	2025-09-03 00:35:36.490571	USCITA	UFFICIO	\N
7	5	2025-09-03 00:35:58.907247	ENTRATA	UFFICIO	\N
8	5	2025-09-03 00:36:00.359046	USCITA	UFFICIO	\N
9	5	2025-09-03 00:36:02.627291	ENTRATA	SMART	\N
10	5	2025-09-03 00:36:04.366916	USCITA	SMART	\N
11	5	2025-09-03 00:45:25.182714	ENTRATA	SMART	\N
12	5	2025-09-03 00:45:29.753616	USCITA	SMART	\N
13	5	2025-09-03 00:45:31.892699	ENTRATA	UFFICIO	\N
14	5	2025-09-03 00:45:33.775182	USCITA	SMART	\N
15	5	2025-09-03 01:06:53.753881	ENTRATA	UFFICIO	\N
16	5	2025-09-03 01:06:56.307199	USCITA	UFFICIO	\N
17	5	2025-09-03 01:06:59.016863	ENTRATA	UFFICIO	\N
18	5	2025-09-03 01:07:01.288719	USCITA	UFFICIO	\N
19	5	2025-09-03 01:07:03.39384	ENTRATA	UFFICIO	\N
20	5	2025-09-03 01:07:05.472778	USCITA	UFFICIO	\N
21	5	2025-09-03 01:07:07.128153	ENTRATA	UFFICIO	\N
22	5	2025-09-03 01:07:09.695221	USCITA	UFFICIO	\N
23	5	2025-09-03 02:28:14.141928	ENTRATA	UFFICIO	\N
24	5	2025-09-03 02:28:15.448904	USCITA	UFFICIO	\N
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, name, hierarchy_level) FROM stdin;
1	Capo	1
2	Responsabile	2
3	Dipendente	3
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, role_id, manager_id) FROM stdin;
1	Giovanni Rossi	giovanni@merendels.com	1	\N
2	Sara Bianchi	sara@merendels.com	2	1
3	Marco Verdi	marco@merendels.com	3	2
4	Alice Neri	alice@merendels.com	3	2
5	Test User	test@example.com	\N	\N
7	Giacomo Festuccia	giacomo.festuccia@merendels.it	1	\N
\.


--
-- Name: approvals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.approvals_id_seq', 1, false);


--
-- Name: auth_credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_credentials_id_seq', 2, true);


--
-- Name: auth_login_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_login_attempts_id_seq', 45, true);


--
-- Name: leave_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_balance_id_seq', 4, true);


--
-- Name: requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requests_id_seq', 1, false);


--
-- Name: timbrature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timbrature_id_seq', 24, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- Name: approvals approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_pkey PRIMARY KEY (id);


--
-- Name: auth_credentials auth_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_credentials
    ADD CONSTRAINT auth_credentials_pkey PRIMARY KEY (id);


--
-- Name: auth_login_attempts auth_login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_login_attempts
    ADD CONSTRAINT auth_login_attempts_pkey PRIMARY KEY (id);


--
-- Name: leave_balance leave_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balance
    ADD CONSTRAINT leave_balance_pkey PRIMARY KEY (id);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


--
-- Name: timbrature timbrature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timbrature
    ADD CONSTRAINT timbrature_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: approvals approvals_approver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_approver_id_fkey FOREIGN KEY (approver_id) REFERENCES public.users(id);


--
-- Name: approvals approvals_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.requests(id);


--
-- Name: auth_credentials auth_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_credentials
    ADD CONSTRAINT auth_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: auth_login_attempts auth_login_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_login_attempts
    ADD CONSTRAINT auth_login_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: leave_balance leave_balance_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balance
    ADD CONSTRAINT leave_balance_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: requests requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: timbrature timbrature_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timbrature
    ADD CONSTRAINT timbrature_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users users_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.users(id);


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.user_roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict ZOFT8ZWiqK14c4XTZvpT9TIdqncfpMcAhXKRlfhlLmQVT6eWAvcQLMfUlVmnMFN

