--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_appuser; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE api_appuser (
    id integer NOT NULL,
    username character varying(24) NOT NULL,
    password character varying(18) NOT NULL
);


ALTER TABLE api_appuser OWNER TO emitech_developer;

--
-- Name: api_appuser_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE api_appuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_appuser_id_seq OWNER TO emitech_developer;

--
-- Name: api_appuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE api_appuser_id_seq OWNED BY api_appuser.id;


--
-- Name: api_cart; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE api_cart (
    id integer NOT NULL,
    total_cost numeric(8,2) NOT NULL,
    purchased boolean NOT NULL,
    appuser_id integer NOT NULL,
    payment character varying(2)
);


ALTER TABLE api_cart OWNER TO emitech_developer;

--
-- Name: api_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE api_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_cart_id_seq OWNER TO emitech_developer;

--
-- Name: api_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE api_cart_id_seq OWNED BY api_cart.id;


--
-- Name: api_product; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE api_product (
    id integer NOT NULL,
    name character varying(18) NOT NULL,
    model character varying(24) NOT NULL,
    code character varying(18) NOT NULL,
    price numeric(7,2) NOT NULL,
    suggested_price numeric(7,2)
);


ALTER TABLE api_product OWNER TO emitech_developer;

--
-- Name: api_product_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE api_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_product_id_seq OWNER TO emitech_developer;

--
-- Name: api_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE api_product_id_seq OWNED BY api_product.id;


--
-- Name: api_productcart; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE api_productcart (
    id uuid NOT NULL,
    quantity integer NOT NULL,
    product_id integer NOT NULL,
    cart_id integer NOT NULL
);


ALTER TABLE api_productcart OWNER TO emitech_developer;

--
-- Name: api_stock; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE api_stock (
    id integer NOT NULL,
    unique_idenfitier character varying(18),
    cost numeric(7,2) NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE api_stock OWNER TO emitech_developer;

--
-- Name: api_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE api_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE api_stock_id_seq OWNER TO emitech_developer;

--
-- Name: api_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE api_stock_id_seq OWNED BY api_stock.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO emitech_developer;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO emitech_developer;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO emitech_developer;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO emitech_developer;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO emitech_developer;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO emitech_developer;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO emitech_developer;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO emitech_developer;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO emitech_developer;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO emitech_developer;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO emitech_developer;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO emitech_developer;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO emitech_developer;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO emitech_developer;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO emitech_developer;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO emitech_developer;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO emitech_developer;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: emitech_developer
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO emitech_developer;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: emitech_developer
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: emitech_developer
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO emitech_developer;

--
-- Name: api_appuser id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_appuser ALTER COLUMN id SET DEFAULT nextval('api_appuser_id_seq'::regclass);


--
-- Name: api_cart id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_cart ALTER COLUMN id SET DEFAULT nextval('api_cart_id_seq'::regclass);


--
-- Name: api_product id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_product ALTER COLUMN id SET DEFAULT nextval('api_product_id_seq'::regclass);


--
-- Name: api_stock id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_stock ALTER COLUMN id SET DEFAULT nextval('api_stock_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Data for Name: api_appuser; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY api_appuser (id, username, password) FROM stdin;
1	ruben	rubenmurga
2	rubenmurga	rubenmurga
\.


--
-- Name: api_appuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('api_appuser_id_seq', 2, true);


--
-- Data for Name: api_cart; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY api_cart (id, total_cost, purchased, appuser_id, payment) FROM stdin;
\.


--
-- Name: api_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('api_cart_id_seq', 1, false);


--
-- Data for Name: api_product; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY api_product (id, name, model, code, price, suggested_price) FROM stdin;
\.


--
-- Name: api_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('api_product_id_seq', 1, false);


--
-- Data for Name: api_productcart; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY api_productcart (id, quantity, product_id, cart_id) FROM stdin;
\.


--
-- Data for Name: api_stock; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY api_stock (id, unique_idenfitier, cost, product_id) FROM stdin;
\.


--
-- Name: api_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('api_stock_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add app user	7	add_appuser
20	Can change app user	7	change_appuser
21	Can delete app user	7	delete_appuser
22	Can add cart	8	add_cart
23	Can change cart	8	change_cart
24	Can delete cart	8	delete_cart
25	Can add product	9	add_product
26	Can change product	9	change_product
27	Can delete product	9	delete_product
28	Can add product cart	10	add_productcart
29	Can change product cart	10	change_productcart
30	Can delete product cart	10	delete_productcart
31	Can add stock	11	add_stock
32	Can change stock	11	change_stock
33	Can delete stock	11	delete_stock
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('auth_permission_id_seq', 33, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$36000$t1mabq1nssF0$VEo9oFbL+4zs8b7s7SIFt0++gh4E4pzTtj+JkkF1LYU=	\N	t	rubmurga			ruben.murga.d@gmail.com	t	t	2017-04-23 22:04:18.335372-05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	appuser
8	api	cart
9	api	product
10	api	productcart
11	api	stock
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('django_content_type_id_seq', 11, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-04-23 21:47:29.475723-05
2	auth	0001_initial	2017-04-23 21:47:29.669362-05
3	admin	0001_initial	2017-04-23 21:47:29.756272-05
4	admin	0002_logentry_remove_auto_add	2017-04-23 21:47:29.772487-05
5	api	0001_initial	2017-04-23 21:47:29.828257-05
6	api	0002_cart_payment	2017-04-23 21:47:29.839123-05
7	contenttypes	0002_remove_content_type_name	2017-04-23 21:47:29.870252-05
8	auth	0002_alter_permission_name_max_length	2017-04-23 21:47:29.882483-05
9	auth	0003_alter_user_email_max_length	2017-04-23 21:47:29.896818-05
10	auth	0004_alter_user_username_opts	2017-04-23 21:47:29.90999-05
11	auth	0005_alter_user_last_login_null	2017-04-23 21:47:29.925748-05
12	auth	0006_require_contenttypes_0002	2017-04-23 21:47:29.928705-05
13	auth	0007_alter_validators_add_error_messages	2017-04-23 21:47:29.942297-05
14	auth	0008_alter_user_username_max_length	2017-04-23 21:47:29.963562-05
15	sessions	0001_initial	2017-04-23 21:47:29.979747-05
16	api	0003_productcart_cart	2017-04-27 21:19:53.961725-05
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: emitech_developer
--

SELECT pg_catalog.setval('django_migrations_id_seq', 16, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: emitech_developer
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Name: api_appuser api_appuser_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_appuser
    ADD CONSTRAINT api_appuser_pkey PRIMARY KEY (id);


--
-- Name: api_cart api_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_cart
    ADD CONSTRAINT api_cart_pkey PRIMARY KEY (id);


--
-- Name: api_product api_product_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_product
    ADD CONSTRAINT api_product_pkey PRIMARY KEY (id);


--
-- Name: api_productcart api_productcart_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_productcart
    ADD CONSTRAINT api_productcart_pkey PRIMARY KEY (id);


--
-- Name: api_stock api_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_stock
    ADD CONSTRAINT api_stock_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_cart_appuser_id_4ba25b5f; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX api_cart_appuser_id_4ba25b5f ON api_cart USING btree (appuser_id);


--
-- Name: api_productcart_cart_id_c7003e82; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX api_productcart_cart_id_c7003e82 ON api_productcart USING btree (cart_id);


--
-- Name: api_productcart_product_id_74b05017; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX api_productcart_product_id_74b05017 ON api_productcart USING btree (product_id);


--
-- Name: api_stock_product_id_69534bd9; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX api_stock_product_id_69534bd9 ON api_stock USING btree (product_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_user_groups_group_id_97559544 ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: emitech_developer
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: api_cart api_cart_appuser_id_4ba25b5f_fk_api_appuser_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_cart
    ADD CONSTRAINT api_cart_appuser_id_4ba25b5f_fk_api_appuser_id FOREIGN KEY (appuser_id) REFERENCES api_appuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_productcart api_productcart_cart_id_c7003e82_fk_api_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_productcart
    ADD CONSTRAINT api_productcart_cart_id_c7003e82_fk_api_cart_id FOREIGN KEY (cart_id) REFERENCES api_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_productcart api_productcart_product_id_74b05017_fk_api_product_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_productcart
    ADD CONSTRAINT api_productcart_product_id_74b05017_fk_api_product_id FOREIGN KEY (product_id) REFERENCES api_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_stock api_stock_product_id_69534bd9_fk_api_product_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY api_stock
    ADD CONSTRAINT api_stock_product_id_69534bd9_fk_api_product_id FOREIGN KEY (product_id) REFERENCES api_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: emitech_developer
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

