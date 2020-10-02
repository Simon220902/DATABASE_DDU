--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)
-- Dumped by pg_dump version 11.5 (Ubuntu 11.5-3.pgdg18.04+1)

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
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: dict_int; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;


--
-- Name: EXTENSION dict_int; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';


--
-- Name: dict_xsyn; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;


--
-- Name: EXTENSION dict_xsyn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgrowlocks; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;


--
-- Name: EXTENSION pgrowlocks; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';


--
-- Name: pgstattuple; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;


--
-- Name: EXTENSION pgstattuple; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: xml2; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;


--
-- Name: EXTENSION xml2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: chats; Type: TABLE; Schema: public; Owner: kgbjldox
--

CREATE TABLE public.chats (
    chatid integer NOT NULL,
    chattablename text NOT NULL,
    encryptionkey text NOT NULL,
    userid1 integer NOT NULL,
    userid2 integer NOT NULL
);


ALTER TABLE public.chats OWNER TO kgbjldox;

--
-- Name: chats_chatid_seq; Type: SEQUENCE; Schema: public; Owner: kgbjldox
--

CREATE SEQUENCE public.chats_chatid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chats_chatid_seq OWNER TO kgbjldox;

--
-- Name: chats_chatid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kgbjldox
--

ALTER SEQUENCE public.chats_chatid_seq OWNED BY public.chats.chatid;


--
-- Name: msimon; Type: TABLE; Schema: public; Owner: kgbjldox
--

CREATE TABLE public.msimon (
    messageid integer NOT NULL,
    message text NOT NULL,
    "time" text,
    userid integer NOT NULL
);


ALTER TABLE public.msimon OWNER TO kgbjldox;

--
-- Name: msimon_messageid_seq; Type: SEQUENCE; Schema: public; Owner: kgbjldox
--

CREATE SEQUENCE public.msimon_messageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.msimon_messageid_seq OWNER TO kgbjldox;

--
-- Name: msimon_messageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kgbjldox
--

ALTER SEQUENCE public.msimon_messageid_seq OWNED BY public.msimon.messageid;


--
-- Name: simonfilip1; Type: TABLE; Schema: public; Owner: kgbjldox
--

CREATE TABLE public.simonfilip1 (
    messageid integer NOT NULL,
    message text NOT NULL,
    "time" text,
    userid integer NOT NULL
);


ALTER TABLE public.simonfilip1 OWNER TO kgbjldox;

--
-- Name: simonfilip1_messageid_seq; Type: SEQUENCE; Schema: public; Owner: kgbjldox
--

CREATE SEQUENCE public.simonfilip1_messageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simonfilip1_messageid_seq OWNER TO kgbjldox;

--
-- Name: simonfilip1_messageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kgbjldox
--

ALTER SEQUENCE public.simonfilip1_messageid_seq OWNED BY public.simonfilip1.messageid;


--
-- Name: simonnull; Type: TABLE; Schema: public; Owner: kgbjldox
--

CREATE TABLE public.simonnull (
    messageid integer NOT NULL,
    message text NOT NULL,
    "time" text,
    userid integer NOT NULL
);


ALTER TABLE public.simonnull OWNER TO kgbjldox;

--
-- Name: simonnull_messageid_seq; Type: SEQUENCE; Schema: public; Owner: kgbjldox
--

CREATE SEQUENCE public.simonnull_messageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.simonnull_messageid_seq OWNER TO kgbjldox;

--
-- Name: simonnull_messageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kgbjldox
--

ALTER SEQUENCE public.simonnull_messageid_seq OWNED BY public.simonnull.messageid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: kgbjldox
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO kgbjldox;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: kgbjldox
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_userid_seq OWNER TO kgbjldox;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kgbjldox
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: chats chatid; Type: DEFAULT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.chats ALTER COLUMN chatid SET DEFAULT nextval('public.chats_chatid_seq'::regclass);


--
-- Name: msimon messageid; Type: DEFAULT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.msimon ALTER COLUMN messageid SET DEFAULT nextval('public.msimon_messageid_seq'::regclass);


--
-- Name: simonfilip1 messageid; Type: DEFAULT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.simonfilip1 ALTER COLUMN messageid SET DEFAULT nextval('public.simonfilip1_messageid_seq'::regclass);


--
-- Name: simonnull messageid; Type: DEFAULT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.simonnull ALTER COLUMN messageid SET DEFAULT nextval('public.simonnull_messageid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: chats; Type: TABLE DATA; Schema: public; Owner: kgbjldox
--

COPY public.chats (chatid, chattablename, encryptionkey, userid1, userid2) FROM stdin;
5	simonnull	-0.0363.1042668.0934277.05176-566.37391023.17092230.1284-813.77421311.79593472.146	1	3
6	simonfilip1	0.0138.70581254.55139840.1983500.63794939.228641679.19561864.70423037.9292-189.75078	1	2
7	Msimon	0.0266.1135513.5673416.58554-363.12924-436.98931260.3035-1195.0479203.645512595.9094	4	1
\.


--
-- Data for Name: msimon; Type: TABLE DATA; Schema: public; Owner: kgbjldox
--

COPY public.msimon (messageid, message, "time", userid) FROM stdin;
1	wFhw5KoW974zyKdn/NAajQ==	Fri Oct 02 14:06:39.753577 2020 CEST	4
\.


--
-- Data for Name: simonfilip1; Type: TABLE DATA; Schema: public; Owner: kgbjldox
--

COPY public.simonfilip1 (messageid, message, "time", userid) FROM stdin;
1	xv5GuUAxX/XwPLKwI38Qxg==	Fri Oct 02 14:06:04.142990 2020 CEST	1
2	h93puc6P2hwlgpWPupJQQA==	Fri Oct 02 14:09:27.005601 2020 CEST	1
\.


--
-- Data for Name: simonnull; Type: TABLE DATA; Schema: public; Owner: kgbjldox
--

COPY public.simonnull (messageid, message, "time", userid) FROM stdin;
1	U4ji79Simoys/FOtIGK/dw==	Fri Oct 02 14:05:52.906715 2020 CEST	1
2	w5IccqpOD0a1hJVYU+OVkQ==	Fri Oct 02 14:10:17.364337 2020 CEST	1
3	XLhhpmBprZb9/kc6AehGpw==	Fri Oct 02 14:10:27.812839 2020 CEST	3
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: kgbjldox
--

COPY public.users (userid, username, password) FROM stdin;
1	simon	46A7876649A7AEDC887C0CA5E4F8FF49E2CF6B91F776B860A819211DFE953D14
2	filip	B8C484170E9DAD90586A5E3B248AF8EB2FC9CCB2D6EB619BAFE70134791C951E
3	filip1	89A30736D8A5779666D82670EDE8A02D9342B3FD1CAE6F504E06DBC7A3F7D022
4	M	08F271887CE94707DA822D5263BAE19D5519CB3614E0DAEDC4C7CE5DAB7473F1
5	simon1	4B16E7E231BD44DF8675066552A00F25DCB2D65D9AA46AC4C8DFD8F18F93B89D
\.


--
-- Name: chats_chatid_seq; Type: SEQUENCE SET; Schema: public; Owner: kgbjldox
--

SELECT pg_catalog.setval('public.chats_chatid_seq', 7, true);


--
-- Name: msimon_messageid_seq; Type: SEQUENCE SET; Schema: public; Owner: kgbjldox
--

SELECT pg_catalog.setval('public.msimon_messageid_seq', 1, true);


--
-- Name: simonfilip1_messageid_seq; Type: SEQUENCE SET; Schema: public; Owner: kgbjldox
--

SELECT pg_catalog.setval('public.simonfilip1_messageid_seq', 2, true);


--
-- Name: simonnull_messageid_seq; Type: SEQUENCE SET; Schema: public; Owner: kgbjldox
--

SELECT pg_catalog.setval('public.simonnull_messageid_seq', 3, true);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: kgbjldox
--

SELECT pg_catalog.setval('public.users_userid_seq', 5, true);


--
-- Name: chats chats_pkey; Type: CONSTRAINT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (chatid);


--
-- Name: msimon msimon_pkey; Type: CONSTRAINT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.msimon
    ADD CONSTRAINT msimon_pkey PRIMARY KEY (messageid);


--
-- Name: simonfilip1 simonfilip1_pkey; Type: CONSTRAINT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.simonfilip1
    ADD CONSTRAINT simonfilip1_pkey PRIMARY KEY (messageid);


--
-- Name: simonnull simonnull_pkey; Type: CONSTRAINT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.simonnull
    ADD CONSTRAINT simonnull_pkey PRIMARY KEY (messageid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: kgbjldox
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- PostgreSQL database dump complete
--

