--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: admin; Type: SCHEMA; Schema: -; Owner: web-r
--

CREATE SCHEMA admin;


ALTER SCHEMA admin OWNER TO "web-r";

--
-- Name: apbd; Type: SCHEMA; Schema: -; Owner: web-r
--

CREATE SCHEMA apbd;


ALTER SCHEMA apbd OWNER TO "web-r";

--
-- Name: aset; Type: SCHEMA; Schema: -; Owner: web-r
--

CREATE SCHEMA aset;


ALTER SCHEMA aset OWNER TO "web-r";

--
-- Name: efiling; Type: SCHEMA; Schema: -; Owner: web-r
--

CREATE SCHEMA efiling;


ALTER SCHEMA efiling OWNER TO "web-r";

--
-- Name: eis; Type: SCHEMA; Schema: -; Owner: web-r
--

CREATE SCHEMA eis;


ALTER SCHEMA eis OWNER TO "web-r";

--
-- Name: gaji; Type: SCHEMA; Schema: -; Owner: web-r
--

CREATE SCHEMA gaji;


ALTER SCHEMA gaji OWNER TO "web-r";

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
-- Name: alembic_ziggurat_foundations_version; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE alembic_ziggurat_foundations_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_ziggurat_foundations_version OWNER TO "web-r";

--
-- Name: arinvoices; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE arinvoices (
    id integer NOT NULL,
    tahun_id integer,
    unit_id integer,
    no_id integer,
    subjek_pajak_id integer,
    objek_pajak_id integer,
    kode character varying(32),
    unit_kode character varying(32),
    unit_nama character varying(128),
    rekening_id integer,
    rek_kode character varying(16),
    rek_nama character varying(64),
    wp_kode character varying(16),
    wp_nama character varying(64),
    wp_alamat_1 character varying(128),
    wp_alamat_2 character varying(128),
    op_kode character varying(16),
    op_nama character varying(64),
    op_alamat_1 character varying(128),
    op_alamat_2 character varying(128),
    dasar bigint,
    tarif double precision,
    pokok bigint,
    denda bigint,
    bunga bigint,
    jumlah bigint,
    periode_1 date,
    periode_2 date,
    tgl_tetap date,
    jatuh_tempo date,
    status_bayar smallint NOT NULL,
    owner_id integer,
    create_uid integer,
    update_uid integer,
    create_date timestamp with time zone,
    update_date timestamp with time zone,
    status_grid smallint,
    wilayah_id integer
);


ALTER TABLE public.arinvoices OWNER TO "web-r";

--
-- Name: arinvoices_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE arinvoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arinvoices_id_seq OWNER TO "web-r";

--
-- Name: arinvoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE arinvoices_id_seq OWNED BY arinvoices.id;


--
-- Name: arsspds; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE arsspds (
    id integer NOT NULL,
    tahun_id integer,
    unit_id integer,
    arinvoice_id integer,
    pembayaran_ke integer,
    bunga bigint,
    bayar bigint,
    tgl_bayar timestamp without time zone,
    create_uid integer,
    update_uid integer,
    create_date timestamp with time zone,
    update_date timestamp with time zone,
    posted smallint NOT NULL,
    ntb character varying(20),
    ntp character varying(20),
    bank_id integer,
    channel_id integer
);


ALTER TABLE public.arsspds OWNER TO "web-r";

--
-- Name: arsspds_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE arsspds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arsspds_id_seq OWNER TO "web-r";

--
-- Name: arsspds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE arsspds_id_seq OWNED BY arsspds.id;


--
-- Name: arsts; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE arsts (
    id integer NOT NULL,
    kode character varying(64),
    nama character varying(128),
    tahun_id integer,
    unit_id integer,
    tgl_sts timestamp with time zone,
    unit_kode character varying(32),
    unit_nama character varying(128),
    no_id integer,
    virified smallint NOT NULL,
    posted smallint NOT NULL,
    create_uid integer,
    update_uid integer,
    create_date timestamp with time zone,
    update_date timestamp with time zone,
    status_bayar smallint,
    jumlah bigint NOT NULL
);


ALTER TABLE public.arsts OWNER TO "web-r";

--
-- Name: arsts_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE arsts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arsts_id_seq OWNER TO "web-r";

--
-- Name: arsts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE arsts_id_seq OWNED BY arsts.id;


--
-- Name: arsts_item; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE arsts_item (
    sts_id integer NOT NULL,
    sspd_id integer NOT NULL,
    rekening_id integer NOT NULL,
    jumlah bigint NOT NULL
);


ALTER TABLE public.arsts_item OWNER TO "web-r";

--
-- Name: arsts_item_sts_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE arsts_item_sts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arsts_item_sts_id_seq OWNER TO "web-r";

--
-- Name: arsts_item_sts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE arsts_item_sts_id_seq OWNED BY arsts_item.sts_id;


--
-- Name: beaker_cache; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE beaker_cache (
    id integer NOT NULL,
    namespace character varying(255) NOT NULL,
    accessed timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public.beaker_cache OWNER TO "web-r";

--
-- Name: beaker_cache_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE beaker_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beaker_cache_id_seq OWNER TO "web-r";

--
-- Name: beaker_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE beaker_cache_id_seq OWNED BY beaker_cache.id;


--
-- Name: external_identities; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE external_identities (
    external_id character varying(255) NOT NULL,
    external_user_name character varying(255),
    local_user_name character varying(50) NOT NULL,
    provider_name character varying(50) NOT NULL,
    access_token character varying(255),
    alt_token character varying(255),
    token_secret character varying(255)
);


ALTER TABLE public.external_identities OWNER TO "web-r";

--
-- Name: groups; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE groups (
    group_name character varying(128) NOT NULL,
    description text,
    member_count integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.groups OWNER TO "web-r";

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO "web-r";

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: groups_permissions; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE groups_permissions (
    perm_name character varying(30) NOT NULL,
    group_id integer NOT NULL,
    CONSTRAINT groups_permissions_perm_name_check CHECK (((perm_name)::text = lower((perm_name)::text)))
);


ALTER TABLE public.groups_permissions OWNER TO "web-r";

--
-- Name: groups_resources_permissions; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE groups_resources_permissions (
    resource_id integer NOT NULL,
    perm_name character varying(50) NOT NULL,
    group_id integer NOT NULL,
    CONSTRAINT groups_resources_permissions_perm_name_check CHECK (((perm_name)::text = lower((perm_name)::text)))
);


ALTER TABLE public.groups_resources_permissions OWNER TO "web-r";

--
-- Name: groups_routes_permissions; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE groups_routes_permissions (
    route_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.groups_routes_permissions OWNER TO "web-r";

--
-- Name: jabatans; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE jabatans (
    id integer NOT NULL,
    kode character varying(64),
    nama character varying(128),
    status integer
);


ALTER TABLE public.jabatans OWNER TO "web-r";

--
-- Name: jabatans_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE jabatans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jabatans_id_seq OWNER TO "web-r";

--
-- Name: jabatans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE jabatans_id_seq OWNED BY jabatans.id;


--
-- Name: objekpajaks; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE objekpajaks (
    id integer NOT NULL,
    kode character varying(64),
    nama character varying(128),
    status integer,
    alamat_1 character varying(128),
    alamat_2 character varying(128),
    wilayah_id integer,
    unit_id integer,
    pajak_id integer,
    subjekpajak_id integer
);


ALTER TABLE public.objekpajaks OWNER TO "web-r";

--
-- Name: objekpajaks_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE objekpajaks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.objekpajaks_id_seq OWNER TO "web-r";

--
-- Name: objekpajaks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE objekpajaks_id_seq OWNED BY objekpajaks.id;


--
-- Name: pajaks; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE pajaks (
    id integer NOT NULL,
    kode character varying(64),
    nama character varying(128),
    status integer,
    rekening_id integer,
    tahun integer NOT NULL,
    tarif double precision NOT NULL,
    denda_rekening_id integer
);


ALTER TABLE public.pajaks OWNER TO "web-r";

--
-- Name: pajaks_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE pajaks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pajaks_id_seq OWNER TO "web-r";

--
-- Name: pajaks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE pajaks_id_seq OWNED BY pajaks.id;


--
-- Name: paps; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE paps (
    id bigint NOT NULL,
    kd_status smallint,
    kd_bayar character varying(16),
    npwpd character varying(14),
    nm_perus character varying(40),
    al_perus character varying(50),
    vol_air bigint,
    npa bigint,
    bea_pok_pjk bigint,
    bea_den_pjk bigint,
    m_pjk_bln character varying(2),
    m_pjk_thn character varying(4),
    tgl_tetap date,
    tgl_jt_tempo date,
    keterangan character varying(255)
);


ALTER TABLE public.paps OWNER TO "web-r";

--
-- Name: paps_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE paps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paps_id_seq OWNER TO "web-r";

--
-- Name: paps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE paps_id_seq OWNED BY paps.id;


--
-- Name: params; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE params (
    id integer NOT NULL,
    denda integer,
    jatuh_tempo integer
);


ALTER TABLE public.params OWNER TO "web-r";

--
-- Name: params_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.params_id_seq OWNER TO "web-r";

--
-- Name: params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE params_id_seq OWNED BY params.id;


--
-- Name: pegawai_users; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE pegawai_users (
    user_id integer NOT NULL,
    pegawai_id integer,
    change_unit integer NOT NULL
);


ALTER TABLE public.pegawai_users OWNER TO "web-r";

--
-- Name: pegawais; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE pegawais (
    id integer NOT NULL,
    kode character varying(64),
    nama character varying(128),
    status integer,
    jabatan_id integer,
    unit_id integer,
    user_id integer
);


ALTER TABLE public.pegawais OWNER TO "web-r";

--
-- Name: pegawais_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE pegawais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pegawais_id_seq OWNER TO "web-r";

--
-- Name: pegawais_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE pegawais_id_seq OWNED BY pegawais.id;


--
-- Name: pkbs; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE pkbs (
    id bigint NOT NULL,
    kd_status smallint,
    flag_sms smallint,
    no_ktp character varying(16),
    no_rangka character varying(40),
    email character varying(40),
    no_hp character varying(20),
    tg_pros_daftar date,
    jam_daftar character varying(10),
    ket character varying(40),
    kd_bayar character varying(16),
    kd_wil character varying(2),
    kd_wil_proses character varying(2),
    nm_pemilik character varying(40),
    no_polisi character varying(10),
    warna_tnkb character varying(40),
    milik_ke integer,
    nm_merek_kb character varying(40),
    nm_model_kb character varying(40),
    th_buatan character varying(4),
    tg_akhir_pjklm date,
    tg_akhir_pjkbr date,
    bbn_pok bigint,
    bbn_den bigint,
    pkb_pok bigint,
    pkb_den bigint,
    swd_pok bigint,
    swd_den bigint,
    adm_stnk bigint,
    adm_tnkb bigint,
    jumlah bigint,
    tg_bayar_bank date,
    jam_bayar_bank character varying(10),
    kd_trn_bank character varying(20),
    kd_trn_dpd character varying(20),
    ivr character varying(2)
);


ALTER TABLE public.pkbs OWNER TO "web-r";

--
-- Name: pkbs_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE pkbs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pkbs_id_seq OWNER TO "web-r";

--
-- Name: pkbs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE pkbs_id_seq OWNED BY pkbs.id;


--
-- Name: rekenings; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE rekenings (
    id integer NOT NULL,
    kode character varying(24),
    nama character varying(128),
    level_id smallint,
    is_summary smallint,
    parent_id smallint
);


ALTER TABLE public.rekenings OWNER TO "web-r";

--
-- Name: rekenings_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE rekenings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rekenings_id_seq OWNER TO "web-r";

--
-- Name: rekenings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE rekenings_id_seq OWNED BY rekenings.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE resources (
    resource_id integer NOT NULL,
    resource_name character varying(100) NOT NULL,
    resource_type character varying(30) NOT NULL,
    parent_id integer,
    ordering integer DEFAULT 0 NOT NULL,
    owner_user_id integer,
    owner_group_id integer
);


ALTER TABLE public.resources OWNER TO "web-r";

--
-- Name: resources_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE resources_resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resources_resource_id_seq OWNER TO "web-r";

--
-- Name: resources_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE resources_resource_id_seq OWNED BY resources.resource_id;


--
-- Name: routes; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE routes (
    id integer NOT NULL,
    kode character varying(256),
    nama character varying(256),
    path character varying(256) NOT NULL,
    factory character varying(256),
    perm_name character varying(16),
    disabled smallint DEFAULT 0::smallint NOT NULL,
    created timestamp without time zone DEFAULT '2015-05-21 15:15:12.10542'::timestamp without time zone NOT NULL,
    updated timestamp without time zone,
    create_uid integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.routes OWNER TO "web-r";

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.routes_id_seq OWNER TO "web-r";

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE routes_id_seq OWNED BY routes.id;


--
-- Name: subjekpajaks; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE subjekpajaks (
    id integer NOT NULL,
    kode character varying(64),
    nama character varying(128),
    status integer,
    alamat_1 character varying(128),
    alamat_2 character varying(128),
    kelurahan character varying(128),
    kecamatan character varying(128),
    kota character varying(128),
    user_id integer,
    provinsi character varying(128),
    email character varying(40),
    unit_id integer
);


ALTER TABLE public.subjekpajaks OWNER TO "web-r";

--
-- Name: subjekpajaks_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE subjekpajaks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subjekpajaks_id_seq OWNER TO "web-r";

--
-- Name: subjekpajaks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE subjekpajaks_id_seq OWNED BY subjekpajaks.id;


--
-- Name: unit_rekenings; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE unit_rekenings (
    id integer NOT NULL,
    unit_id integer,
    rekening_id integer
);


ALTER TABLE public.unit_rekenings OWNER TO "web-r";

--
-- Name: unit_rekenings_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE unit_rekenings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_rekenings_id_seq OWNER TO "web-r";

--
-- Name: unit_rekenings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE unit_rekenings_id_seq OWNED BY unit_rekenings.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE units (
    id integer NOT NULL,
    kode character varying(16),
    nama character varying(128),
    level_id smallint,
    is_summary smallint,
    parent_id smallint
);


ALTER TABLE public.units OWNER TO "web-r";

--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_id_seq OWNER TO "web-r";

--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE units_id_seq OWNED BY units.id;


--
-- Name: user_units; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE user_units (
    user_id integer NOT NULL,
    unit_id integer NOT NULL
);


ALTER TABLE public.user_units OWNER TO "web-r";

--
-- Name: users; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    user_name character varying(30),
    user_password character varying(256),
    email character varying(100) NOT NULL,
    status smallint NOT NULL,
    security_code character varying(256),
    last_login_date timestamp without time zone DEFAULT now(),
    registered_date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO "web-r";

--
-- Name: users_groups; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE users_groups (
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.users_groups OWNER TO "web-r";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "web-r";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_permissions; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE users_permissions (
    perm_name character varying(30) NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT user_permissions_perm_name_check CHECK (((perm_name)::text = lower((perm_name)::text)))
);


ALTER TABLE public.users_permissions OWNER TO "web-r";

--
-- Name: users_resources_permissions; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE users_resources_permissions (
    resource_id integer NOT NULL,
    perm_name character varying(50) NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT users_resources_permissions_perm_name_check CHECK (((perm_name)::text = lower((perm_name)::text)))
);


ALTER TABLE public.users_resources_permissions OWNER TO "web-r";

--
-- Name: wilayahs; Type: TABLE; Schema: public; Owner: web-r; Tablespace: 
--

CREATE TABLE wilayahs (
    id integer NOT NULL,
    kode character varying(24),
    nama character varying(128),
    level_id smallint,
    parent_id integer
);


ALTER TABLE public.wilayahs OWNER TO "web-r";

--
-- Name: wilayahs_id_seq; Type: SEQUENCE; Schema: public; Owner: web-r
--

CREATE SEQUENCE wilayahs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wilayahs_id_seq OWNER TO "web-r";

--
-- Name: wilayahs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: web-r
--

ALTER SEQUENCE wilayahs_id_seq OWNED BY wilayahs.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arinvoices ALTER COLUMN id SET DEFAULT nextval('arinvoices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsspds ALTER COLUMN id SET DEFAULT nextval('arsspds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsts ALTER COLUMN id SET DEFAULT nextval('arsts_id_seq'::regclass);


--
-- Name: sts_id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsts_item ALTER COLUMN sts_id SET DEFAULT nextval('arsts_item_sts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY beaker_cache ALTER COLUMN id SET DEFAULT nextval('beaker_cache_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY jabatans ALTER COLUMN id SET DEFAULT nextval('jabatans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY objekpajaks ALTER COLUMN id SET DEFAULT nextval('objekpajaks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pajaks ALTER COLUMN id SET DEFAULT nextval('pajaks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY paps ALTER COLUMN id SET DEFAULT nextval('paps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY params ALTER COLUMN id SET DEFAULT nextval('params_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pegawais ALTER COLUMN id SET DEFAULT nextval('pegawais_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pkbs ALTER COLUMN id SET DEFAULT nextval('pkbs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY rekenings ALTER COLUMN id SET DEFAULT nextval('rekenings_id_seq'::regclass);


--
-- Name: resource_id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY resources ALTER COLUMN resource_id SET DEFAULT nextval('resources_resource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY routes ALTER COLUMN id SET DEFAULT nextval('routes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY subjekpajaks ALTER COLUMN id SET DEFAULT nextval('subjekpajaks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY unit_rekenings ALTER COLUMN id SET DEFAULT nextval('unit_rekenings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY units ALTER COLUMN id SET DEFAULT nextval('units_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY wilayahs ALTER COLUMN id SET DEFAULT nextval('wilayahs_id_seq'::regclass);


--
-- Data for Name: alembic_ziggurat_foundations_version; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY alembic_ziggurat_foundations_version (version_num) FROM stdin;
439766f6104d
\.


--
-- Data for Name: arinvoices; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY arinvoices (id, tahun_id, unit_id, no_id, subjek_pajak_id, objek_pajak_id, kode, unit_kode, unit_nama, rekening_id, rek_kode, rek_nama, wp_kode, wp_nama, wp_alamat_1, wp_alamat_2, op_kode, op_nama, op_alamat_1, op_alamat_2, dasar, tarif, pokok, denda, bunga, jumlah, periode_1, periode_2, tgl_tetap, jatuh_tempo, status_bayar, owner_id, create_uid, update_uid, create_date, update_date, status_grid, wilayah_id) FROM stdin;
7	2015	208	1	5	6	2232002608150001	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	10000000	100	10000000	0	0	10000000	2015-08-26	2015-08-26	2015-08-26	2015-08-26	0	15	\N	\N	\N	\N	0	1
10	2016	208	3	7	11	2132000604160003	1.20.05.	Dinas Pendapatan Daerah	11	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	\N	\N	450000	100	450000	0	0	450000	2016-04-06	2016-04-30	2016-04-06	2016-05-31	1	10	\N	\N	\N	\N	0	1
11	2016	208	4	8	12	2132000604160004	1.20.05.	Dinas Pendapatan Daerah	8	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	P-0002	PT. Harapan Makmur Sentosa	Jl. Jakarta No.105, Kota Bandung	-	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	\N	\N	810000	100	810000	0	0	810000	2016-04-06	2016-04-30	2016-04-06	2016-05-31	1	10	\N	\N	\N	\N	0	1
8	2016	208	1	5	10	2032000404160001	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	10000000000	100	10000000000	0	0	10000000000	2016-04-04	2016-04-04	2016-04-04	2016-04-04	1	1	\N	\N	\N	\N	0	1
9	2016	208	2	5	10	2032000404160002	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	3000000000	100	3000000000	0	0	3000000000	2016-04-04	2016-04-04	2016-04-04	2016-04-04	1	1	\N	\N	\N	\N	0	1
13	2016	208	6	7	14	2132000604160006	1.20.05.	Dinas Pendapatan Daerah	5	4.1.1.01.01.	Pajak Kendaraan Bermotor	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.01.	Pajak Kendaraan Bermotor	\N	\N	200000	100	200000	0	0	200000	2016-04-06	2016-04-30	2016-04-06	2016-05-31	1	10	\N	\N	\N	\N	0	1
12	2016	208	5	9	13	2132000604160005	1.20.05.	Dinas Pendapatan Daerah	14	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	P-0003	PT. Guna San Marino	Jl. Soekarno-hatta no.20, RT/RW 01/01	-	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	\N	\N	1030500	100	1030500	0	0	1030500	2016-04-06	2016-04-16	2016-04-06	2016-05-31	1	10	\N	\N	\N	\N	0	1
14	2016	208	7	7	15	2132000604160007	1.20.05.	Dinas Pendapatan Daerah	35	4.1.1.03.14.	E-2 Sepeda Motor, Scooter (Dinas)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.03.14.	E-2 Sepeda Motor, Scooter (Dinas)	\N	\N	260500	100	260500	0	0	260500	2016-04-06	2016-04-30	2016-04-06	2016-05-31	1	10	\N	\N	\N	\N	0	1
15	2016	208	8	5	18	2132001304160008	1.20.05.	Dinas Pendapatan Daerah	9	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	\N	\N	10000	100	10000	0	0	10000	2016-04-13	2016-04-13	2016-04-13	2016-04-13	1	10	\N	\N	\N	\N	0	1
16	2016	208	9	5	20	2132001304160009	1.20.05.	Dinas Pendapatan Daerah	11	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	\N	\N	15000	100	15000	500	0	15500	2016-04-13	2016-04-13	2016-04-13	2016-04-13	1	10	\N	\N	\N	\N	0	1
17	2016	208	10	5	22	2132001304160010	1.20.05.	Dinas Pendapatan Daerah	14	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	\N	\N	5000	100	5000	300	0	5300	2016-04-13	2016-04-13	2016-04-13	2016-04-13	1	10	\N	\N	\N	\N	0	1
18	2016	208	11	7	14	2132001304160011	1.20.05.	Dinas Pendapatan Daerah	5	4.1.1.01.01.	Pajak Kendaraan Bermotor	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.01.	Pajak Kendaraan Bermotor	\N	\N	20000	100	20000	100	0	20100	2016-04-13	2016-04-13	2016-04-13	2016-04-13	1	10	\N	\N	\N	\N	0	1
19	2016	208	12	5	26	2132001304160012	1.20.05.	Dinas Pendapatan Daerah	20	4.1.1.02.01.	Pajak Kendaraan Di Atas Air	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.02.01.	Pajak Kendaraan Di Atas Air	\N	\N	50000	100	50000	3000	0	53000	2016-04-13	2016-04-13	2016-04-13	2016-04-13	1	10	\N	\N	\N	\N	0	1
20	2016	208	13	5	25	2132001304160013	1.20.05.	Dinas Pendapatan Daerah	22	4.1.1.03.01.	Bea Balik Nama Kendaraan Bermotor	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.03.01.	Bea Balik Nama Kendaraan Bermotor	\N	\N	55500	100	55500	4000	0	59500	2016-04-13	2016-04-13	2016-04-13	2016-04-13	1	10	\N	\N	\N	\N	0	1
28	2016	208	20	7	38	2132001804160020	1.20.05.	Dinas Pendapatan Daerah	24	4.1.1.03.03.	A-3 Sedan, Jeep, Station Wagon (Dinas)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.03.03.	A-3 Sedan, Jeep, Station Wagon (Dinas)	\N	\N	2554000	100	2554000	0	0	2554000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	0	10	\N	\N	\N	\N	0	1
21	2016	208	14	7	27	2132001804160014	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.05.02.	Pertamax	\N	\N	1050000	100	1050000	0	0	1050000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	1	10	\N	\N	\N	\N	0	1
22	2016	208	15	7	31	2132001804160015	1.20.05.	Dinas Pendapatan Daerah	8	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	\N	\N	910000	100	910000	0	0	910000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	1	10	\N	\N	\N	\N	0	1
23	2016	208	16	7	34	2132001804160016	1.20.05.	Dinas Pendapatan Daerah	9	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	\N	\N	900000	100	900000	0	0	900000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	1	10	\N	\N	\N	\N	0	1
26	2016	208	19	7	37	2132001804160019	1.20.05.	Dinas Pendapatan Daerah	6	4.1.1.01.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	\N	\N	2100000	100	2100000	0	0	2100000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	1	10	\N	\N	\N	\N	0	1
24	2016	208	17	7	35	2132001804160017	1.20.05.	Dinas Pendapatan Daerah	12	4.1.1.01.08.	C-2 Truck, Pick Up (Umum)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.08.	C-2 Truck, Pick Up (Umum)	\N	\N	620000	100	620000	0	0	620000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	1	10	\N	\N	\N	\N	0	1
29	2016	208	21	10	39	2132000905160021	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	790000000	100	790000000	0	0	790000000	2016-05-09	2016-05-31	2016-05-09	2016-06-30	1	10	\N	\N	\N	\N	0	1
30	2016	208	22	10	40	2132000905160022	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	850000000	100	850000000	0	0	850000000	2016-05-09	2016-05-31	2016-05-09	2016-06-30	1	10	\N	\N	\N	\N	0	1
31	2016	208	23	10	41	2132000905160023	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	670000000	100	670000000	0	0	670000000	2016-05-09	2016-05-31	2016-05-09	2016-06-30	1	10	\N	\N	\N	\N	0	1
38	2016	208	30	10	40	2132000905160030	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	185000000	100	185000000	0	0	185000000	2016-05-23	2016-06-20	2016-05-23	2016-06-30	1	10	\N	\N	\N	\N	0	1
32	2016	208	24	10	42	2132000905160024	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	500000000	100	500000000	0	0	500000000	2016-05-09	2016-06-30	2016-05-09	2016-06-30	1	10	\N	\N	\N	\N	0	1
35	2016	208	27	10	41	2132000905160027	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	67000000	100	67000000	0	0	67000000	2016-05-16	2016-06-06	2016-05-16	2016-06-30	1	10	\N	\N	\N	\N	0	1
33	2016	208	25	10	39	2132000905160025	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	79000000	100	79000000	0	0	79000000	2016-05-16	2016-06-06	2016-05-16	2016-06-30	1	10	\N	\N	\N	\N	0	1
36	2016	208	28	10	42	2132000905160028	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	50000000	100	50000000	0	0	50000000	2016-05-16	2016-06-06	2016-05-16	2016-06-30	0	10	\N	\N	\N	\N	0	1
25	2016	208	18	7	36	2132001804160018	1.20.05.	Dinas Pendapatan Daerah	17	4.1.1.01.13.	E-1 Sepeda Motor, Scooter (Pribadi)	P-0001	PT. Sarana Mandiri	Jl. Ahmad Yani no.100, Kota Bandung	-	4.1.1.01.13.	E-1 Sepeda Motor, Scooter (Pribadi)	\N	\N	240000	100	240000	0	0	240000	2016-04-18	2016-04-30	2016-04-18	2016-05-31	1	10	\N	\N	\N	\N	0	1
48	2016	208	40	10	42	2132000905160040	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	350000000	100	350000000	0	0	350000000	2016-05-25	2016-06-22	2016-05-25	2016-06-30	0	10	\N	\N	\N	\N	0	1
45	2016	208	37	10	39	2132000905160037	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	379000000	100	379000000	0	0	379000000	2016-05-25	2016-06-22	2016-05-25	2016-06-30	1	10	\N	\N	\N	\N	0	1
50	2016	208	42	11	44	2132002605160042	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.03.	Pertamax Plus	\N	\N	85000000	100	85000000	0	0	85000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	0	10	\N	\N	\N	\N	0	1
52	2016	208	44	11	46	2132002605160044	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.05.	Gas	\N	\N	180000000	100	180000000	0	0	180000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	0	10	\N	\N	\N	\N	0	1
53	2016	208	45	11	43	2132002605160045	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.02.	Pertamax	\N	\N	79000000	100	79000000	0	0	79000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
54	2016	208	46	11	44	2132002605160046	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.03.	Pertamax Plus	\N	\N	86000000	100	86000000	0	0	86000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
55	2016	208	47	11	45	2132002605160047	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.04.	Solar	\N	\N	67000000	100	67000000	0	0	67000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
56	2016	208	48	11	46	2132002605160048	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.05.	Gas	\N	\N	145000000	100	145000000	0	0	145000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
57	2016	208	49	11	43	2132002605160049	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.02.	Pertamax	\N	\N	77500000	100	77500000	0	0	77500000	2016-05-28	2016-06-04	2016-05-28	2016-06-05	0	10	\N	\N	\N	\N	0	1
58	2016	208	50	11	44	2132002605160050	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.03.	Pertamax Plus	\N	\N	83000000	100	83000000	0	0	83000000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
59	2016	208	51	11	45	2132002605160051	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.04.	Solar	\N	\N	66000000	100	66000000	0	0	66000000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
60	2016	208	52	11	46	2132002605160052	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.05.	Gas	\N	\N	155000000	100	155000000	0	0	155000000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
61	2016	208	53	5	9	2132002605160053	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.02.	Pertamax	\N	\N	158000000	100	158000000	0	0	158000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	0	10	\N	\N	\N	\N	0	1
44	2016	208	36	10	41	2132000905160036	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	267000000	100	267000000	0	0	267000000	2016-05-24	2016-06-21	2016-05-24	2016-06-30	1	10	\N	\N	\N	\N	0	1
42	2016	208	34	10	40	2132000905160034	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	285000000	100	285000000	0	0	285000000	2016-05-24	2016-06-21	2016-05-24	2016-06-30	1	10	\N	\N	\N	\N	0	1
49	2016	208	41	11	43	2132002605160041	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.02.	Pertamax	\N	\N	65000000	100	65000000	0	0	65000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	1	10	\N	\N	\N	\N	0	1
46	2016	208	38	10	40	2132000905160038	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	385000000	100	385000000	0	0	385000000	2016-05-25	2016-06-22	2016-05-25	2016-06-30	1	10	\N	\N	\N	\N	0	1
51	2016	208	43	11	45	2132002605160043	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0005	PT. Petronas	Jl. Suci no.100 , RT 006 RW 007	-	4.1.1.05.04.	Solar	\N	\N	65000000	100	65000000	0	0	65000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	1	10	\N	\N	\N	\N	0	1
41	2016	208	33	10	39	2132000905160033	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	279000000	100	279000000	0	0	279000000	2016-05-24	2016-06-21	2016-05-24	2016-06-30	1	10	\N	\N	\N	\N	0	1
40	2016	208	32	10	42	2132000905160032	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	150000000	100	150000000	0	0	150000000	2016-05-23	2016-06-20	2016-05-23	2016-06-30	1	10	\N	\N	\N	\N	0	1
34	2016	208	26	10	40	2132000905160026	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	85000000	100	85000000	0	0	85000000	2016-05-16	2016-06-06	2016-05-16	2016-06-30	1	10	\N	\N	\N	\N	0	1
47	2016	208	39	10	41	2132000905160039	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	367000000	100	367000000	0	0	367000000	2016-05-25	2016-06-22	2016-05-25	2016-06-30	1	10	\N	\N	\N	\N	0	1
37	2016	208	29	10	39	2132000905160029	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	179000000	100	179000000	0	0	179000000	2016-05-23	2016-06-13	2016-05-23	2016-06-30	1	10	\N	\N	\N	\N	0	1
39	2016	208	31	10	41	2132000905160031	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	167000000	100	167000000	0	0	167000000	2016-05-23	2016-06-20	2016-05-23	2016-06-30	1	10	\N	\N	\N	\N	0	1
62	2016	208	54	5	10	2132002605160054	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	168000000	100	168000000	0	0	168000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	0	10	\N	\N	\N	\N	0	1
65	2016	208	57	5	9	2132002605160057	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.02.	Pertamax	\N	\N	237000000	100	237000000	0	0	237000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
63	2016	208	55	5	6	2132002605160055	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	130000000	100	130000000	0	0	130000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	0	10	\N	\N	\N	\N	0	1
64	2016	208	56	5	47	2132002605160056	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.05.	Gas	\N	\N	240000000	100	240000000	0	0	240000000	2016-05-26	2016-06-02	2016-05-26	2016-06-03	0	10	\N	\N	\N	\N	0	1
67	2016	208	59	5	6	2132002605160059	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	195000000	100	195000000	0	0	195000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
69	2016	208	61	5	9	2132002605160061	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.02.	Pertamax	\N	\N	135900000	100	135900000	0	0	135900000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
71	2016	208	63	5	6	2132002605160063	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	136500000	100	136500000	0	0	136500000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
66	2016	208	58	5	10	2132002605160058	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	252000000	100	252000000	0	0	252000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
68	2016	208	60	5	47	2132002605160060	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.05.	Gas	\N	\N	370000000	100	370000000	0	0	370000000	2016-05-27	2016-06-03	2016-05-27	2016-06-04	0	10	\N	\N	\N	\N	0	1
70	2016	208	62	5	10	2132002605160062	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	145500000	100	145500000	0	0	145500000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
72	2016	208	64	5	47	2132002605160064	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.05.	Gas	\N	\N	252900000	100	252900000	0	0	252900000	2016-05-28	2016-06-04	2016-05-28	2016-06-06	0	10	\N	\N	\N	\N	0	1
43	2016	208	35	10	42	2132000905160035	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	250000000	100	250000000	0	0	250000000	2016-05-24	2016-06-21	2016-05-24	2016-06-30	1	10	\N	\N	\N	\N	0	1
76	2016	208	67	5	6	2132002106160067	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	670000000	100	670000000	0	0	670000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	0	10	\N	\N	\N	\N	0	1
77	2016	208	68	5	47	2132002106160068	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.05.	Gas	\N	\N	980000000	100	980000000	0	0	980000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	0	10	\N	\N	\N	\N	0	1
78	2016	208	69	5	9	2132002106160069	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.02.	Pertamax	\N	\N	640000000	100	640000000	0	0	640000000	2016-07-01	2016-07-08	2016-07-01	2016-07-31	0	10	\N	\N	\N	\N	0	1
79	2016	208	70	5	10	2132002106160070	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	720000000	100	720000000	0	0	720000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
80	2016	208	71	5	6	2132002106160071	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	560000000	100	560000000	0	0	560000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
81	2016	208	72	5	47	2132002106160072	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.05.	Gas	\N	\N	880000000	100	880000000	0	0	880000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
82	2016	208	73	5	9	2132002106160073	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.02.	Pertamax	\N	\N	540000000	100	540000000	0	0	540000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
83	2016	208	74	5	10	2132002106160074	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	610000000	100	610000000	0	0	610000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
84	2016	208	75	5	6	2132002106160075	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.04.	Solar	\N	\N	470000000	100	470000000	0	0	470000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
85	2016	208	76	5	47	2132002106160076	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.05.	Gas	\N	\N	720000000	100	720000000	0	0	720000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
73	2016	208	65	5	9	2132002106160065	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.02.	Pertamax	\N	\N	740000000	100	740000000	0	0	740000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	1	10	\N	\N	\N	\N	0	1
86	2016	208	77	10	39	2132002106160077	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	730000000	100	730000000	0	0	730000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	0	10	\N	\N	\N	\N	0	1
87	2016	208	78	10	40	2132002106160078	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	790000000	100	790000000	0	0	790000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	0	10	\N	\N	\N	\N	0	1
88	2016	208	79	10	41	2132002106160079	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	650000000	100	650000000	0	0	650000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	0	10	\N	\N	\N	\N	0	1
89	2016	208	80	10	42	2132002106160080	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	860000000	100	860000000	0	0	860000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	0	10	\N	\N	\N	\N	0	1
90	2016	208	81	10	39	2132002106160081	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	630000000	100	630000000	0	0	630000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
91	2016	208	82	10	40	2132002106160082	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	740000000	100	740000000	0	0	740000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
92	2016	208	83	10	41	2132002106160083	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	600000000	100	600000000	0	0	600000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
93	2016	208	84	10	42	2132002106160084	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	810000000	100	810000000	0	0	810000000	2016-06-22	2016-06-29	2016-06-22	2016-06-30	0	10	\N	\N	\N	\N	0	1
94	2016	208	85	10	39	2132002106160085	1.20.05.	Dinas Pendapatan Daerah	40	4.1.1.05.02.	Pertamax	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.02.	Pertamax	\N	\N	680000000	100	680000000	0	0	680000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
95	2016	208	86	10	40	2132002106160086	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.03.	Pertamax Plus	\N	\N	740000000	100	740000000	0	0	740000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
96	2016	208	87	10	41	2132002106160087	1.20.05.	Dinas Pendapatan Daerah	42	4.1.1.05.04.	Solar	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.04.	Solar	\N	\N	550000000	100	550000000	0	0	550000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
75	2016	208	66	5	10	2132002106160066	1.20.05.	Dinas Pendapatan Daerah	41	4.1.1.05.03.	Pertamax Plus	0123456789123456	Pertamina	Jln Soekarno - Hatta	\N	4.1.1.05.03.	Pertamax Plus	\N	\N	810000000	100	810000000	0	0	810000000	2016-06-21	2016-06-28	2016-06-21	2016-06-30	1	10	\N	\N	\N	\N	0	1
97	2016	208	88	10	42	2132002106160088	1.20.05.	Dinas Pendapatan Daerah	43	4.1.1.05.05.	Gas	P-0004	PT. Shell 	Jl. Cijambe Kulon, Bandung 	-	4.1.1.05.05.	Gas	\N	\N	760000000	100	760000000	0	0	760000000	2016-06-23	2016-06-30	2016-06-23	2016-06-30	0	10	\N	\N	\N	\N	0	1
\.


--
-- Name: arinvoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('arinvoices_id_seq', 97, true);


--
-- Data for Name: arsspds; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY arsspds (id, tahun_id, unit_id, arinvoice_id, pembayaran_ke, bunga, bayar, tgl_bayar, create_uid, update_uid, create_date, update_date, posted, ntb, ntp, bank_id, channel_id) FROM stdin;
2	2016	208	8	1	0	0	2016-04-06 00:00:00	\N	\N	2016-04-06 21:28:40.728332+07	2016-04-06 21:28:40.728332+07	0	20160406212839	201611066731353	110	6010
3	2016	208	8	2	200000000	10200000000	2016-04-13 00:00:00	\N	\N	2016-04-13 10:44:35.447304+07	2016-04-13 10:44:35.447304+07	0	20160413104434	201611014903388	110	6010
4	2016	208	9	1	60000000	3060000000	2016-04-13 00:00:00	\N	\N	2016-04-13 10:45:29.792178+07	2016-04-13 10:45:29.792178+07	0	BJB20160413653082   	201611068859639	110	6010
5	2016	208	10	1	0	450000	2016-04-13 00:00:00	\N	\N	2016-04-13 13:36:39.757817+07	2016-04-13 13:36:39.757817+07	0	BJB20160413023389   	201611027096230	110	6010
6	2016	208	11	1	0	810000	2016-04-14 00:00:00	\N	\N	2016-04-14 08:21:59.750067+07	2016-04-14 08:21:59.750067+07	0	BJB20160414653100   	201611039963620	110	6010
7	2016	208	13	1	0	200000	2016-04-15 00:00:00	\N	\N	2016-04-15 14:22:12.287548+07	2016-04-15 14:22:12.287548+07	0	BJB20160415582624	201611081244965	110	6011
8	2016	208	12	1	0	1030500	2016-04-15 00:00:00	\N	\N	2016-04-15 15:54:24.539062+07	2016-04-15 15:54:24.539062+07	0	BJB20160415582627	201611092426543	110	6011
9	2016	208	14	1	0	260500	2016-04-15 00:00:00	\N	\N	2016-04-15 16:17:02.599609+07	2016-04-15 16:17:02.599609+07	0	BJB20160415582630	201611085570794	110	6011
10	2016	208	15	1	200	10200	2016-04-18 00:00:00	\N	\N	2016-04-18 09:14:27.953348+07	2016-04-18 09:14:27.953348+07	0	BJB20160418582635	201611062153323	110	6011
11	2016	208	16	1	310	15810	2016-04-18 00:00:00	\N	\N	2016-04-18 09:43:45.181882+07	2016-04-18 09:43:45.181882+07	0	BJB20160418582655	201611014020995	110	6011
12	2016	208	17	1	106	5406	2016-04-18 00:00:00	\N	\N	2016-04-18 10:41:49.677033+07	2016-04-18 10:41:49.677033+07	0	BJB20160418582671	201611091757415	110	6011
13	2016	208	18	1	402	20502	2016-04-18 00:00:00	\N	\N	2016-04-18 10:50:00.339118+07	2016-04-18 10:50:00.339118+07	0	BJB20160418582674	201611065431566	110	6011
14	2016	208	19	1	1060	54060	2016-04-18 00:00:00	\N	\N	2016-04-18 10:57:55.237913+07	2016-04-18 10:57:55.237913+07	0	BJB20160418582681	201611048379464	110	6011
15	2016	208	20	1	1190	60690	2016-04-18 00:00:00	\N	\N	2016-04-18 11:46:09.111746+07	2016-04-18 11:46:09.111746+07	0	BJB20160418023398   	201611064684803	110	6010
16	2016	208	21	1	0	1050000	2016-04-18 00:00:00	\N	\N	2016-04-18 13:30:29.236452+07	2016-04-18 13:30:29.236452+07	0	BJB20160418023400   	201611053653297	110	6010
17	2016	208	22	1	0	910000	2016-04-20 00:00:00	\N	\N	2016-04-20 14:28:25.070718+07	2016-04-20 14:28:25.070718+07	0	BJB20160420023410   	201611027283810	110	6010
18	2016	208	23	1	0	900000	2016-04-20 00:00:00	\N	\N	2016-04-20 14:38:51.453498+07	2016-04-20 14:38:51.453498+07	0	BJB20160420023412   	201611046133430	110	6010
19	2016	208	26	1	0	2100000	2016-05-09 00:00:00	\N	\N	2016-05-09 15:07:32.087132+07	2016-05-09 15:07:32.087132+07	0	20160509023420      	201611092070513	110	6010
20	2016	208	25	1	0	240000	2016-05-09 00:00:00	\N	\N	2016-05-09 15:14:25.278488+07	2016-05-09 15:14:25.278488+07	0	20160509023424      	201611079870887	110	6010
21	2016	208	24	1	0	620000	2016-05-09 00:00:00	\N	\N	2016-05-09 15:37:55.132672+07	2016-05-09 15:37:55.132672+07	0	20160509583784	201611080109520	110	6011
22	2016	208	35	1	0	67000000	2016-05-10 00:00:00	\N	\N	2016-05-10 09:31:03.272763+07	2016-05-10 09:31:03.272763+07	0	20160510583856	201611023217205	110	6011
23	2016	208	38	1	0	185000000	2016-05-10 00:00:00	\N	\N	2016-05-10 09:43:24.688344+07	2016-05-10 09:43:24.688344+07	0	20160510583870	201611068374430	110	6011
24	2016	208	29	1	0	790000000	2016-05-12 00:00:00	\N	\N	2016-05-12 09:36:30.743219+07	2016-05-12 09:36:30.743219+07	0	20160512029715      	201611077497853	110	6010
25	2016	208	30	1	0	850000000	2016-05-12 00:00:00	\N	\N	2016-05-12 09:44:33.736606+07	2016-05-12 09:44:33.736606+07	0	20160512029721      	201611089581553	110	6010
26	2016	208	31	1	0	670000000	2016-05-12 00:00:00	\N	\N	2016-05-12 10:11:42.673695+07	2016-05-12 10:11:42.673695+07	0	20160512584031	201611099635284	110	6011
27	2016	208	45	1	0	379000000	2016-05-13 00:00:00	\N	\N	2016-05-13 10:54:32.273898+07	2016-05-13 10:54:32.273898+07	0	20160513023465      	201611082054935	110	6010
28	2016	208	32	1	0	500000000	2016-05-13 00:00:00	\N	\N	2016-05-13 14:24:05.682706+07	2016-05-13 14:24:05.682706+07	0	20160513584094	201611045057323	110	6011
29	2016	208	43	1	0	250000000	2016-05-27 00:00:00	\N	\N	2016-05-27 09:26:35.036206+07	2016-05-27 09:26:35.036206+07	0	20160527023704      	201611076873900	110	6010
30	2016	208	44	1	0	267000000	2016-05-27 00:00:00	\N	\N	2016-05-27 09:47:55.734133+07	2016-05-27 09:47:55.734133+07	0	20160527585003	201611092018715	110	6011
31	2016	208	42	1	0	285000000	2016-05-27 00:00:00	\N	\N	2016-05-27 09:49:21.126913+07	2016-05-27 09:49:21.126913+07	0	20160527585010	201611080894821	110	6011
32	2016	208	49	1	0	65000000	2016-05-27 00:00:00	\N	\N	2016-05-27 10:59:38.563129+07	2016-05-27 10:59:38.563129+07	0	20160527023720      	201611043107959	110	6010
33	2016	208	46	1	0	385000000	2016-05-27 00:00:00	\N	\N	2016-05-27 11:07:35.971082+07	2016-05-27 11:07:35.971082+07	0	20160527023724      	201611061200438	110	6010
34	2016	208	51	1	0	65000000	2016-05-27 00:00:00	\N	\N	2016-05-27 11:18:14.457895+07	2016-05-27 11:18:14.457895+07	0	20160527023727      	201611036455179	110	6010
35	2016	208	41	1	0	279000000	2016-05-27 00:00:00	\N	\N	2016-05-27 11:50:21.87469+07	2016-05-27 11:50:21.87469+07	0	20160527585066	201611026494906	110	6011
36	2016	208	40	1	0	150000000	2016-05-27 00:00:00	\N	\N	2016-05-27 11:52:16.222321+07	2016-05-27 11:52:16.222321+07	0	20160527585072	201611084082900	110	6011
37	2016	208	33	1	0	79000000	2016-05-27 00:00:00	\N	\N	2016-05-27 14:44:02.358328+07	2016-05-27 14:44:02.358328+07	0	20160527023748      	201611058606864	110	6010
38	2016	208	34	1	0	85000000	2016-05-27 00:00:00	\N	\N	2016-05-27 14:55:18.238538+07	2016-05-27 14:55:18.238538+07	0	20160527023752      	201611043560701	110	6010
39	2016	208	47	1	0	367000000	2016-05-27 00:00:00	\N	\N	2016-05-27 16:17:48.994777+07	2016-05-27 16:17:48.994777+07	0	20160527023779      	201611098301733	110	6010
40	2016	208	37	1	0	179000000	2016-05-27 00:00:00	\N	\N	2016-05-27 16:25:47.851949+07	2016-05-27 16:25:47.851949+07	0	20160527023783      	201611098025203	110	6010
41	2016	208	39	1	0	167000000	2016-06-20 00:00:00	\N	\N	2016-06-20 15:44:18.692991+07	2016-06-20 15:44:18.692991+07	0	20160620023825      	201611082601266	110	6010
42	2016	208	73	1	0	740000000	2016-06-21 00:00:00	\N	\N	2016-06-21 10:24:36.861968+07	2016-06-21 10:24:36.861968+07	0	20160621023830      	201611069928227	110	6010
43	2016	208	75	1	0	810000000	2016-06-21 00:00:00	\N	\N	2016-06-21 10:44:55.571614+07	2016-06-21 10:44:55.571614+07	0	20160621586492	201611078005396	110	6011
\.


--
-- Name: arsspds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('arsspds_id_seq', 43, true);


--
-- Data for Name: arsts; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY arsts (id, kode, nama, tahun_id, unit_id, tgl_sts, unit_kode, unit_nama, no_id, virified, posted, create_uid, update_uid, create_date, update_date, status_bayar, jumlah) FROM stdin;
2	201612005000001	pembayaran P3APER	2016	208	2016-06-02 00:00:00+07	1.20.05.	Dinas Pendapatan Daerah	1	0	0	\N	\N	\N	\N	\N	0
\.


--
-- Name: arsts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('arsts_id_seq', 2, true);


--
-- Data for Name: arsts_item; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY arsts_item (sts_id, sspd_id, rekening_id, jumlah) FROM stdin;
\.


--
-- Name: arsts_item_sts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('arsts_item_sts_id_seq', 1, false);


--
-- Data for Name: beaker_cache; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY beaker_cache (id, namespace, accessed, created, data) FROM stdin;
6	4d5f491b35594e4ba06b8c2974bf98ba	2015-06-08 15:56:53.997959	2015-06-08 15:53:34.396155	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55d56357fbecf550e5f6372656174696f6e5f74696d6571044741d55d560398438975732e
78	a16d7677d75746fcac5189070cc9dc84	2016-05-27 13:31:39.530821	2016-05-27 13:29:46.02426	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d1fa72e1d3bf550e5f6372656174696f6e5f74696d6571044741d5d1fa56816c7675732e
1	96f2fcd5e25747ffa1f6dfa0d25f4d0a	2015-05-21 10:43:18.001962	2015-05-21 10:38:52.602201	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55755155880ae550e5f6372656174696f6e5f74696d6571044741d55754d320af3675732e
2	480c668d9fde4ae9bfdd835e87a43828	2015-05-21 13:22:34.917086	2015-05-21 13:04:15.614992	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5575e6aba81bf55035f665f71045d71055513504b4220737564616820646973696d70616e2e710661550e5f6372656174696f6e5f74696d6571074741d5575d57e72e9d75732e
83	bd9d49bee9f345fe8bc8cee7adb9f319	2016-07-11 11:33:50.809806	2016-07-11 11:33:13.328355	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5e0c86bb3acde550e5f6372656174696f6e5f74696d6571044741d5e0c86253e45075732e
79	c553d1972ded497da19911d8799edfb7	2016-05-31 15:40:50.705649	2016-05-31 15:36:16.541828	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d35384abf2b6550e5f6372656174696f6e5f74696d6571044741d5d3534021a35175732e
57	f2d328c479854c4e84f0f68b5af89ab5	2015-09-08 13:37:45.348391	2015-09-08 13:36:34.338512	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57ba08e5607dd550e5f6372656174696f6e5f74696d6571044741d57ba07c94ac8675732e
84	43edbcced99240ff813c6c0ee9c5465c	2016-07-20 09:28:56.97255	2016-07-20 09:28:53.250831	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5e3b87a3dbd98550e5f6372656174696f6e5f74696d6571044741d5e3b8794fe6d675732e
58	71497e7ce368419787a0be5267b65878	2015-09-09 12:00:26.262402	2015-09-09 11:56:35.618767	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57bef3a90244f550e5f6372656174696f6e5f74696d6571044741d57bef00e666b675732e
81	a9acf3bddb404f53b83a85c8a80c29b5	2016-06-06 14:40:36.586694	2016-06-06 14:39:23.855016	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d54a3d254d6a550e5f6372656174696f6e5f74696d6571044741d5d54a2af5af1475732e
3	bc288e5a1b9b418f9e50d112c0a669b6	2015-05-27 09:38:20.452383	2015-05-27 09:02:54.837535	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5594b86ab9f84550e5f6372656174696f6e5f74696d6571044741d5594973b3f26375732e
77	3f91ed1a9d1a4095a8782545d1b2d306	2016-05-27 13:27:40.785192	2016-05-27 13:24:21.269557	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d1fa37321fac550e5f6372656174696f6e5f74696d6571044741d5d1fa0550391175732e
4	b9c374f4b7d5407995b5a2e69f68e3cf	2015-05-27 12:54:38.383328	2015-05-27 12:53:51.766788	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5595707981455550e5f6372656174696f6e5f74696d6571044741d55956fbef6f1175732e
5	92ecd61a3eef47c98bdfefb00f059540	2015-05-27 18:22:38.673459	2015-05-27 18:22:38.607417	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5596a3faa88a0550e5f6372656174696f6e5f74696d6571044741d5596a3fa6b6e975732e
82	471b77de58ad4df3a04af20b7522bad3	2016-06-21 10:46:31.05185	2016-06-21 09:32:45.112017	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5da2e25c32ded550e5f6372656174696f6e5f74696d6571044741d5da29d3455f7875732e
80	aafae9c8845341958e4f9023420f933d	2016-06-02 13:54:30.578281	2016-06-02 13:45:21.029235	\\x80027d7101550773657373696f6e7d71022855067374735f696471034b02550e5f61636365737365645f74696d6571044741d5d3f609a4c40d5507756e69745f696471054bd0550e5f6372656174696f6e5f74696d6571064741d5d3f58040d10775732e
60	6c82bfc6b87a47dcb4135993945e9ae2	2015-09-11 06:56:04.102257	2015-09-11 06:36:52.787341	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57c86250650ad550e5f6372656174696f6e5f74696d6571044741d57c850531530975732e
7	e809acec5a104484aaaf6660fac75a43	2015-06-08 18:00:57.63832	2015-06-08 17:59:48.783771	\\x80027d7101550773657373696f6e7d710228550c6c6f67696e206661696c6564710358e80500003c666f726d0a202069643d226465666f726d220a20206d6574686f643d22504f5354220a2020656e63747970653d226d756c7469706172742f666f726d2d64617461220a20206163636570742d636861727365743d227574662d382220636c6173733d226465666f726d220a20203e0a0a20203c6669656c6473657420636c6173733d226465666f726d466f726d4669656c64736574223e0a0a202020200a0a202020203c696e70757420747970653d2268696464656e22206e616d653d225f636861727365745f22202f3e0a202020203c696e70757420747970653d2268696464656e22206e616d653d225f5f666f726d69645f5f222076616c75653d226465666f726d222f3e0a0a202020203c64697620636c6173733d22616c65727420616c6572742d64616e676572223e0a2020202020203c64697620636c6173733d226572726f724d73674c626c220a20202020202020203e54686572652077617320612070726f626c656d207769746820796f7572207375626d697373696f6e3c2f6469763e0a2020202020203c7020636c6173733d226572726f724d7367223e3c2f703e0a202020203c2f6469763e0a0a202020200a0a202020203c6469760a2020202020636c6173733d22666f726d2d67726f7570206861732d6572726f72206974656d2d757365726e616d65220a20202020207469746c653d22220a202020202069643d226974656d2d6465666f726d4669656c6431223e0a0a20203c6c6162656c20666f723d226465666f726d4669656c6431220a202020202020202020636c6173733d22636f6e74726f6c2d6c6162656c207265717569726564220a20202020202020202069643d227265712d6465666f726d4669656c6431220a2020202020202020203e0a202020204e616d612050656e6767756e610a20203c2f6c6162656c3e0a0a20200a202020203c696e70757420747970653d227465787422206e616d653d22757365726e616d65222076616c75653d22220a202020202020202020202069643d226465666f726d4669656c64312220636c6173733d2220666f726d2d636f6e74726f6c20222f3e0a20200a0a20203c7020636c6173733d2268656c702d626c6f636b222069643d226572726f722d6465666f726d4669656c6431223e52657175697265643c2f703e0a0a20200a3c2f6469763e0a0a202020203c6469760a2020202020636c6173733d22666f726d2d67726f75702020220a20202020207469746c653d22220a202020202069643d226974656d2d6465666f726d4669656c6432223e0a0a20203c6c6162656c20666f723d226465666f726d4669656c6432220a202020202020202020636c6173733d22636f6e74726f6c2d6c6162656c207265717569726564220a20202020202020202069643d227265712d6465666f726d4669656c6432220a2020202020202020203e0a202020204b6174612053616e64690a20203c2f6c6162656c3e0a0a20200a202020203c696e707574200a20202020747970653d2270617373776f726422200a202020206e616d653d2270617373776f726422200a2020202076616c75653d22220a2020202069643d226465666f726d4669656c64322220636c6173733d2220666f726d2d636f6e74726f6c20222f3e0a20200a0a20200a0a20200a3c2f6469763e0a0a0a202020203c64697620636c6173733d22666f726d2d67726f7570223e0a2020202020200a20202020202020203c627574746f6e0a202020202020202020202020202069643d226465666f726d6c6f67696e220a20202020202020202020202020206e616d653d226c6f67696e220a2020202020202020202020202020747970653d227375626d6974220a2020202020202020202020202020636c6173733d2262746e2062746e2d7072696d61727920220a202020202020202020202020202076616c75653d226c6f67696e223e0a202020202020202020200a202020202020202020204c6f67696e0a20202020202020203c2f627574746f6e3e0a2020202020200a202020203c2f6469763e0a0a20203c2f6669656c647365743e0a0a20200a0a3c2f666f726d3e0a7104550e5f61636365737365645f74696d6571054741d55d5d7a68b9aa550e5f6372656174696f6e5f74696d6571064741d55d5d693212a575732e
8	09f389bdc6844efca8f7ba2d7c92fbb9	2015-06-09 13:24:46.789159	2015-06-09 11:32:38.355842	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55da1abb24b9d550e5f6372656174696f6e5f74696d6571044741d55d9b19950bc875732e
21	96d1f9dcee374fbc97fc70cfb69d00ad	2015-06-18 00:20:00.932178	2015-06-17 23:24:36.552992	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5606b0ffeca4b550e5f6372656174696f6e5f74696d6571044741d56067d123445b75732e
10	d826add18c0946c985025103a7e109bb	2015-06-09 13:44:22.106926	2015-06-09 12:28:45.630834	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55da2d1867b96550e5f6372656174696f6e5f74696d6571044741d55d9e636839e275732e
19	df7c2c768ad34dfaadf273c279fd3b8a	2015-06-17 13:48:31.864716	2015-06-17 13:37:59.596994	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d560460fcb5821550e5f6372656174696f6e5f74696d6571044741d5604571e2eeb375732e
18	759d96aec02348dc84b0af0fd6972ff3	2015-06-15 14:30:54.618875	2015-06-15 14:30:54.24235	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55f9fcba770f4550e5f6372656174696f6e5f74696d6571044741d55f9fcb8efdb175732e
13	f2e2789fc44e453a873b682e220ab9c5	2015-06-09 17:46:04.952399	2015-06-09 15:18:15.140042	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55db0fb3cd9e4550e5f6372656174696f6e5f74696d6571044741d55da851c8dc8375732e
9	c4e61d1995a34508831890ca8f16ced6	2015-06-09 12:20:22.485031	2015-06-09 11:59:33.0838	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55d9de56e4c49550e5f6372656174696f6e5f74696d6571044741d55d9cad4385d775732e
14	87a3452bad244b99b26d707a8bbc8c68	2015-06-11 16:58:01.585967	2015-06-11 16:58:00.03886	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55e56ea047675550e5f6372656174696f6e5f74696d6571044741d55e56ea016c1a75732e
12	86516eb2f0834549b1e493c2be0e4cbb	2015-06-09 13:53:37.107598	2015-06-09 13:34:53.368098	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55da35c46c148550e5f6372656174696f6e5f74696d6571044741d55da24357603575732e
62	35a7875867714c83835ba7f2e4a3d6b9	2016-04-04 11:29:01.215818	2016-04-04 11:24:18.309288	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c07b634da737550e5f6372656174696f6e5f74696d6571044741d5c07b1c91784675732e
17	b1e119b53da74da39076114f0cef6e96	2015-06-15 14:37:58.798484	2015-06-15 14:25:23.722679	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55fa035b2f0ed550e5f6372656174696f6e5f74696d6571044741d55f9f78ecaaac75732e
25	7f41b98a283448f9a4f5e0425410fc28	2015-06-19 14:28:36.75696	2015-06-19 12:34:45.916263	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d560f129305033550e5f6372656174696f6e5f74696d6571044741d560ea7d7a028675732e
16	314fc8b799cb4eb1a6a9fa6ec8833cb5	2015-06-15 13:54:10.9677	2015-06-15 13:42:47.607666	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55f9da4bdaf86550e5f6372656174696f6e5f74696d6571044741d55f9cf9e537bd75732e
15	7d5a43569bc64f45a8e12b177f345480	2015-06-15 13:33:48.379663	2015-06-15 13:32:52.321761	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55f9c72a96cc2550e5f6372656174696f6e5f74696d6571044741d55f9c6512d1e975732e
11	5be0180956854616a25077ca1cf3e071	2015-06-09 13:43:36.235829	2015-06-09 13:25:37.713406	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d55da2c5c50fae550e5f6372656174696f6e5f74696d6571044741d55da1b86d7eae75732e
20	94d6e330d3204ce78903969479d0407b	2015-06-17 17:32:55.155198	2015-06-17 17:11:59.450941	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5605335c9c25d550e5f6372656174696f6e5f74696d6571044741d56051fbdcb7d075732e
23	604d0b380f1345e88b60d47daf2e57d6	2015-06-18 20:10:53.109737	2015-06-18 20:06:48.945113	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d560b0d746e619550e5f6372656174696f6e5f74696d6571044741d560b09a3c3c4b75732e
59	7627aff91aa74b3b85db4b24c0204467	2015-09-09 15:14:37.588181	2015-09-09 15:08:15.895439	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57bfa9b6509b7550e5f6372656174696f6e5f74696d6571044741d57bfa3bf929c775732e
22	66fb6ac401f746d9827569a818ba0874	2015-06-18 20:31:50.038394	2015-06-18 20:06:04.835557	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d560b21182543b550e5f6372656174696f6e5f74696d6571044741d560b08f3470a075732e
64	0031e3eda19d4be5bec258c398cef781	2016-04-06 17:36:51.503991	2016-04-06 17:20:48.003713	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c139b0e01d3f550e5f6372656174696f6e5f74696d6571044741d5c138bfffc97975732e
70	4c81300f079d4b9388c9ea196c67543c	2016-05-09 15:33:49.417511	2016-05-09 14:59:55.000653	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5cc12db5a96b7550e5f6372656174696f6e5f74696d6571044741d5cc10debd9f0a75732e
65	5a15c5852446483d8b0b9256a0e4d9aa	2016-04-13 11:28:06.400807	2016-04-13 10:42:37.186139	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c372b5996fd2550e5f6372656174696f6e5f74696d6571044741d5c3700b4a539775732e
61	2a13bdfc04984bcc9982715009289378	2015-09-11 07:54:46.20791	2015-09-11 07:37:09.020574	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57c89958cd467550e5f6372656174696f6e5f74696d6571044741d57c888d41314475732e
67	154ffc12eee84a0982186f420e64eceb	2016-04-18 12:25:01.293113	2016-04-18 12:07:55.631624	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c51beb529fb2550e5f6372656174696f6e5f74696d6571044741d5c51aeae51aa875732e
63	d696367118ef4429a656caac20d7e5a1	2016-04-06 17:11:41.614802	2016-04-06 17:10:55.93342	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c13837672f98550e5f6372656174696f6e5f74696d6571044741d5c1382bfa127775732e
68	030aafbc98e64c70bb28241bd20d6ad1	2016-04-28 08:55:30.104824	2016-04-28 08:48:33.405829	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c85b64113aa3550e5f6372656174696f6e5f74696d6571044741d5c85afc5836fc75732e
24	75e2009acd6f49af80bd9dfc6a0ab026	2015-06-19 14:24:59.468515	2015-06-19 10:40:15.919987	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d560f0f2dddae0550e5f6372656174696f6e5f74696d6571044741d560e3c7f95c7475732e
66	5d9fd0a4e1424a58864ff7b6ce56e753	2016-04-13 11:44:19.488847	2016-04-13 11:33:59.932471	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c373a8df1f2a550e5f6372656174696f6e5f74696d6571044741d5c3730dfa294175732e
69	02b71c726ae44334b2300c726f5338bb	2016-04-28 09:02:28.211049	2016-04-28 09:01:07.299836	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5c85bcd0d5d4f550e5f6372656174696f6e5f74696d6571044741d5c85bb8d3080375732e
30	8c80056db0bd4be1896b91f1e0fa9648	2015-06-23 09:53:50.953893	2015-06-23 08:29:54.454688	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d562328fbceb6c550e5f6372656174696f6e5f74696d6571044741d5622da49b86d375732e
26	ae23b7c0dd504274a491407f6f1f9a17	2015-06-19 15:54:52.865347	2015-06-19 15:37:27.030461	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d560f63736428d550e5f6372656174696f6e5f74696d6571044741d560f531c1d2f675732e
27	23ccab8d400047d798b17d6fb304c968	2015-06-19 21:46:07.626688	2015-06-19 21:44:58.148514	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5610acbe7a3be550e5f6372656174696f6e5f74696d6571044741d5610aba894e8775732e
28	308c568b272f4b00bec7ed7b6c19fa99	2015-06-22 17:02:25.942871	2015-06-22 16:49:50.725492	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d561f74c7c177f550e5f6372656174696f6e5f74696d6571044741d561f68fad6a6675732e
29	984750713c5741539f8f77b1bbf408f2	2015-06-22 17:05:47.112301	2015-06-22 17:05:46.906568	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d561f77ec6abef550e5f6372656174696f6e5f74696d6571044741d561f77eb9da5e75732e
40	2510f021a834481d8b7b784e8c2f14ac	2015-07-11 21:04:55.752785	2015-07-11 21:03:03.55298	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d56848a1efa687550e5f6372656174696f6e5f74696d6571044741d5684885e2176175732e
41	75e5f3feb75a410f859372903cf109db	2015-07-11 21:16:55.148449	2015-07-11 21:16:53.660564	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5684955c8fb16550e5f6372656174696f6e5f74696d6571044741d56849556a212d75732e
42	c41c5054a8c24ac9ad561f1f5781a5ac	2015-08-10 12:55:00.319621	2015-08-10 12:54:22.535341	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5720f2d14302b550e5f6372656174696f6e5f74696d6571044741d5720f23a11deb75732e
43	791a98ec0e164ce78f15e48696abaf75	2015-08-11 13:59:06.326832	2015-08-11 13:59:06.18818	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d572674e94c954550e5f6372656174696f6e5f74696d6571044741d572674e8a9f5175732e
44	5a2d8abf08104ce8bc8d8cc525d1fdaf	2015-08-25 07:55:13.975461	2015-08-25 07:55:13.975474	\\x80027d7101550773657373696f6e71027d710328550e5f61636365737365645f74696d6571044741d576ef3c7d5f7c55035f665f71055d71065511504b422073756461682070726f7365732e710761550e5f6372656174696f6e5f74696d6571084741d576ef3c7d5f7c75732e
32	70e6911fb2714af5aa10be860d4dd0d4	2015-06-23 20:02:37.657575	2015-06-23 19:34:04.852787	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d562563b69fd11550e5f6372656174696f6e5f74696d6571044741d562548f31eb5b75732e
33	1d437c0f30144074a76b1a29c80a683b	2015-06-23 20:04:10.640532	2015-06-23 19:50:14.666207	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5625652a8de83550e5f6372656174696f6e5f74696d6571044741d5625581aa820275732e
47	b674f85f7ea34154b79c7de42f13dfa9	2015-08-25 08:43:22.813123	2015-08-25 08:32:13.736729	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576f20eb3949a550e5f6372656174696f6e5f74696d6571044741d576f1676ef48075732e
34	486f0b5a2019467ab0935befe8b99b68	2015-06-24 09:40:18.732195	2015-06-24 09:34:51.839806	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5628624ae9525550e5f6372656174696f6e5f74696d6571044741d56285d2f49f1775732e
31	5866e5656b2e4a47a40c2ecd1052475a	2015-06-23 11:46:13.968978	2015-06-23 11:23:58.254168	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d56239257de1da550e5f6372656174696f6e5f74696d6571044741d56237d79024bc75732e
35	047fcad7f988485e9f7a293ef1277bc9	2015-06-25 13:46:38.781195	2015-06-25 13:45:42.443961	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d562e8f3b1de05550e5f6372656174696f6e5f74696d6571044741d562e8e59b62d475732e
36	1942676885454d3783820249faf28c42	2015-06-27 13:15:59.65924	2015-06-27 13:15:59.659252	\\x80027d7101550773657373696f6e71027d710328550e5f61636365737365645f74696d6571044741d5638fe7e925e555035f665f71055d71065511504b422073756461682070726f7365732e710761550e5f6372656174696f6e5f74696d6571084741d5638fe7e925e575732e
37	e7eb8a712d50414fb6548a6066715f2f	2015-06-27 13:15:59.691863	2015-06-27 13:15:59.691875	\\x80027d7101550773657373696f6e71027d710328550e5f61636365737365645f74696d6571044741d5638fe7ec2dbe55035f665f71055d71065511504b422073756461682070726f7365732e710761550e5f6372656174696f6e5f74696d6571084741d5638fe7ec2dbe75732e
48	f8f1809941c54ef192e672302c8e01de	2015-08-25 09:09:37.845791	2015-08-25 09:07:05.732967	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576f39875f4e8550e5f6372656174696f6e5f74696d6571044741d576f3726eb79975732e
46	2348c697063d4caaa1dcb0cedb683a75	2015-08-25 08:00:41.79099	2015-08-25 07:59:07.468695	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576ef8e720aaf550e5f6372656174696f6e5f74696d6571044741d576ef76ddd19a75732e
45	9ca5f2bf3ea34fe29f4c71a9853ba2ae	2015-08-25 08:01:42.914014	2015-08-25 07:55:15.036115	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576ef9dba09ab550e5f6372656174696f6e5f74696d6571044741d576ef3cc2303475732e
38	f2f1fc30cb8240e3ad31e636edff45e8	2015-07-02 11:51:22.53341	2015-07-02 11:43:43.169685	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d56530d2a1ac60550e5f6372656174696f6e5f74696d6571044741d565305fc9c94775732e
39	57ba9347b7984dcf9699d6fa7141c17e	2015-07-06 19:43:45.271262	2015-07-06 19:43:45.232694	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5669e0050cfee550e5f6372656174696f6e5f74696d6571044741d5669e004dcfe175732e
52	37dc639520e1455899d3710327dc6b2e	2015-08-25 19:59:38.979257	2015-08-25 19:57:30.848232	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57719aebe8a59550e5f6372656174696f6e5f74696d6571044741d577198eb618c675732e
49	fa13b58565a64ec7877d6909f95481b2	2015-08-25 09:24:27.241325	2015-08-25 09:23:32.471504	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576f476cf38eb550e5f6372656174696f6e5f74696d6571044741d576f4691e146675732e
51	b85d2988b09847e9b99fcf73380ca27d	2015-08-25 10:22:08.784684	2015-08-25 10:21:44.731925	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576f7d8320592550e5f6372656174696f6e5f74696d6571044741d576f7d22d42d575732e
71	01681444ce6c4ee48470c3bb022aed01	2016-05-25 09:25:33.644389	2016-05-25 08:59:17.749838	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d1434768ffda550e5f6372656174696f6e5f74696d6571044741d5d141bd6ebd2b75732e
72	ecf516a4b8fd444abb94cdba39aae70c	2016-05-25 10:37:23.109761	2016-05-25 10:36:25.473467	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d1477cc6e8d9550e5f6372656174696f6e5f74696d6571044741d5d1476e5e22c975732e
50	3ed0b9fc5f6342de9a825a6ae22c9ad4	2015-08-25 09:55:56.832665	2015-08-25 09:40:50.29977	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d576f64f342c8c550e5f6372656174696f6e5f74696d6571044741d576f56c930bb375732e
73	03f3d9ac3cd54ee5b3ab7b362da9dffd	2016-05-25 12:06:29.206314	2016-05-25 11:32:23.962017	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d14cb54cf6d7550e5f6372656174696f6e5f74696d6571044741d5d14ab5fd704c75732e
53	478c75e807c941d3aeb14bec6dbe69e7	2015-08-25 23:18:22.426341	2015-08-25 21:57:34.442288	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57725539b2379550e5f6372656174696f6e5f74696d6571044741d57720979bb9d475732e
74	d6ac5e7eda1c42cb80b537a7b7fe649a	2016-05-25 16:05:15.065491	2016-05-25 14:30:51.015008	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d15ab2c3f41f550e5f6372656174696f6e5f74696d6571044741d5d1552ac0d20f75732e
54	586d7fabb72b4f359738a26df8f2665c	2015-08-26 09:47:46.60921	2015-08-26 08:46:26.522556	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5774a34a6cb81550e5f6372656174696f6e5f74696d6571044741d577469c9fd84d75732e
55	a1f2d2a84a824584ab6bef83ae7cbdba	2015-08-26 14:05:33.311257	2015-08-26 10:54:09.61456	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d577594f53ca10550e5f6372656174696f6e5f74696d6571044741d5774e1866dbec75732e
75	13b6505e46ca4b998cf4db86045a1694	2016-05-26 11:24:11.7239	2016-05-26 10:02:04.847927	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d5d19e9aee3127550e5f6372656174696f6e5f74696d6571044741d5d199cb34d38075732e
76	df94bcfd70ee4064a008f074260e5c8c	2016-05-26 12:58:39.379011	2016-05-26 12:18:00.239128	\\x80027d7101550773657373696f6e7d71022855067374735f696471034b01550e5f61636365737365645f74696d6571044741d5d1a423d81ef35507756e69745f696471054bd0550e5f6372656174696f6e5f74696d6571064741d5d1a1c20e26bb75732e
56	c3f8e92b250d4a3fa03777a77bbdfa0f	2015-09-07 10:02:16.636754	2015-09-07 09:56:49.758338	\\x80027d7101550773657373696f6e7d710228550e5f61636365737365645f74696d6571034741d57b3f8e289ec7550e5f6372656174696f6e5f74696d6571044741d57b3f3c6f8b2a75732e
\.


--
-- Name: beaker_cache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('beaker_cache_id_seq', 84, true);


--
-- Data for Name: external_identities; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY external_identities (external_id, external_user_name, local_user_name, provider_name, access_token, alt_token, token_secret) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY groups (group_name, description, member_count, id) FROM stdin;
admin	administrator	1	3
bud	Bendahara Umum Daerah	1	4
bendahara	Bendahara Penerimaan	1	2
wp	Wajib Pajak	2	1
\.


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('groups_id_seq', 8, true);


--
-- Data for Name: groups_permissions; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY groups_permissions (perm_name, group_id) FROM stdin;
\.


--
-- Data for Name: groups_resources_permissions; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY groups_resources_permissions (resource_id, perm_name, group_id) FROM stdin;
\.


--
-- Data for Name: groups_routes_permissions; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY groups_routes_permissions (route_id, group_id) FROM stdin;
132	2
133	2
134	2
136	2
132	4
133	4
134	4
136	4
135	4
114	2
115	2
116	2
122	2
117	2
70	2
71	2
72	2
74	2
73	2
42	2
80	2
81	2
82	2
84	2
83	2
94	2
95	2
96	2
98	2
97	2
99	2
100	2
101	2
103	2
102	2
104	2
65	2
66	2
67	2
69	2
68	2
4	2
57	2
70	1
71	1
72	1
74	1
73	1
118	1
119	1
120	1
123	1
121	1
66	1
42	1
4	1
57	1
75	4
76	4
77	4
79	4
78	4
65	4
66	4
67	4
69	4
68	4
80	4
81	4
82	4
84	4
83	4
94	4
95	4
96	4
98	4
97	4
99	4
100	4
101	4
103	4
102	4
104	4
70	4
71	4
72	4
74	4
73	4
105	4
42	4
4	4
\.


--
-- Data for Name: jabatans; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY jabatans (id, kode, nama, status) FROM stdin;
\.


--
-- Name: jabatans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('jabatans_id_seq', 1, false);


--
-- Data for Name: objekpajaks; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY objekpajaks (id, kode, nama, status, alamat_1, alamat_2, wilayah_id, unit_id, pajak_id, subjekpajak_id) FROM stdin;
6	4.1.1.05.04.	Solar	1	\N	\N	1	208	29	5
9	4.1.1.05.02.	Pertamax	1	\N	\N	1	208	27	5
10	4.1.1.05.03.	Pertamax Plus	1	\N	\N	1	208	28	5
11	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	1	\N	\N	1	208	5	7
12	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	1	\N	\N	1	208	3	8
13	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	1	\N	\N	1	208	7	9
14	4.1.1.01.01.	Pajak Kendaraan Bermotor	1	\N	\N	1	208	1	7
15	4.1.1.03.14.	E-2 Sepeda Motor, Scooter (Dinas)	1	\N	\N	1	208	24	7
18	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	1	\N	\N	1	208	4	5
19	4.1.1.01.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	1	\N	\N	1	208	2	5
20	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	1	\N	\N	1	208	5	5
22	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	1	\N	\N	1	208	7	5
24	4.1.1.01.13.	E-1 Sepeda Motor, Scooter (Pribadi)	1	\N	\N	1	208	9	9
25	4.1.1.03.01.	Bea Balik Nama Kendaraan Bermotor	1	\N	\N	1	208	11	5
26	4.1.1.02.01.	Pajak Kendaraan Di Atas Air	1	\N	\N	1	208	10	5
27	4.1.1.05.02.	Pertamax	1	\N	\N	1	208	27	7
31	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	1	\N	\N	1	208	3	7
34	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	1	\N	\N	1	208	4	7
35	4.1.1.01.08.	C-2 Truck, Pick Up (Umum)	1	\N	\N	1	208	6	7
36	4.1.1.01.13.	E-1 Sepeda Motor, Scooter (Pribadi)	1	\N	\N	1	208	9	7
37	4.1.1.01.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	1	\N	\N	1	208	2	7
38	4.1.1.03.03.	A-3 Sedan, Jeep, Station Wagon (Dinas)	1	\N	\N	1	208	13	7
39	4.1.1.05.02.	Pertamax	1	\N	\N	1	208	27	10
40	4.1.1.05.03.	Pertamax Plus	1	\N	\N	1	208	28	10
41	4.1.1.05.04.	Solar	1	\N	\N	1	208	29	10
42	4.1.1.05.05.	Gas	1	\N	\N	1	208	30	10
43	4.1.1.05.02.	Pertamax	1	\N	\N	1	208	27	11
44	4.1.1.05.03.	Pertamax Plus	1	\N	\N	1	208	28	11
45	4.1.1.05.04.	Solar	1	\N	\N	1	208	29	11
46	4.1.1.05.05.	Gas	1	\N	\N	1	208	30	11
47	4.1.1.05.05.	Gas	1	\N	\N	1	208	30	5
\.


--
-- Name: objekpajaks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('objekpajaks_id_seq', 47, true);


--
-- Data for Name: pajaks; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY pajaks (id, kode, nama, status, rekening_id, tahun, tarif, denda_rekening_id) FROM stdin;
1	4.1.1.01.01.	Pajak Kendaraan Bermotor	1	5	2015	100	\N
2	4.1.1.01.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	1	6	2015	100	\N
3	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	1	8	2015	100	\N
4	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	1	9	2015	100	\N
5	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	1	11	2015	100	\N
6	4.1.1.01.08.	C-2 Truck, Pick Up (Umum)	1	12	2015	100	\N
7	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	1	14	2015	100	\N
8	4.1.1.01.11.	D-2 Kendaraan Khusus (Umum)	1	15	2015	100	\N
9	4.1.1.01.13.	E-1 Sepeda Motor, Scooter (Pribadi)	1	17	2015	100	\N
10	4.1.1.02.01.	Pajak Kendaraan Di Atas Air	1	20	2015	100	\N
11	4.1.1.03.01.	Bea Balik Nama Kendaraan Bermotor	1	22	2015	100	\N
12	4.1.1.03.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	1	23	2015	100	\N
13	4.1.1.03.03.	A-3 Sedan, Jeep, Station Wagon (Dinas)	1	24	2015	100	\N
14	4.1.1.03.04.	B-1 Bus, Micro Bus (Pribadi)	1	25	2015	100	\N
15	4.1.1.03.05.	B-2 Bus, Micro Bus (Umum)	1	26	2015	100	\N
16	4.1.1.03.06.	B-3 Bus, Micro Bus (Dinas)	1	27	2015	100	\N
17	4.1.1.03.07.	C-1 Truck, Pick Up (Pribadi)	1	28	2015	100	\N
18	4.1.1.03.08.	C-2 Truck, Pick Up (Umum)	1	29	2015	100	\N
19	4.1.1.03.09.	C-3 Truck, Pick Up (Dinas)	1	30	2015	100	\N
20	4.1.1.03.10.	D-1 Kendaraan Khusus (Pribadi)	1	31	2015	100	\N
21	4.1.1.03.11.	D-2 Kendaraan Khusus (Umum)	1	32	2015	100	\N
22	4.1.1.03.12.	D-3 Kendaraan Khusus (Dinas)	1	33	2015	100	\N
23	4.1.1.03.13.	E-1 Sepeda Motor, Scooter (Pribadi)	1	34	2015	100	\N
24	4.1.1.03.14.	E-2 Sepeda Motor, Scooter (Dinas)	1	35	2015	100	\N
25	4.1.1.04.01.	Bea Balik nama Kendaraan Di atas Air	1	37	2015	100	\N
26	4.1.1.05.01.	Pajak Bahan Bakar Kendaraan Bermotor	1	39	2015	100	\N
27	4.1.1.05.02.	Pertamax	1	40	2015	100	\N
28	4.1.1.05.03.	Pertamax Plus	1	41	2015	100	\N
29	4.1.1.05.04.	Solar	1	42	2015	100	\N
30	4.1.1.05.05.	Gas	1	43	2015	100	\N
31	4.1.1.06.01.	Pajak Pengambilan Pemanfaatan Air Permukaan	1	45	2015	100	\N
32	4.1.1.07.01.	Pajak Rokok	1	48	2015	100	\N
33	4.1.2.03.01.	Retribusi Izin Trayek	1	80	2015	100	\N
34	4.1.4.01.01.	Pelepasan Hak Atas Tanah	1	101	2015	100	\N
35	4.1.4.01.02.	Penjualan Peralatan/Perlengkapan Kantor Tidak Terpakai	1	102	2015	100	\N
36	4.1.4.01.03.	Penjualan Mesin/Alat-alat Berat Tidak Terpakai	1	103	2015	100	\N
37	4.1.4.01.04.	Penjualan Rumah Jabatan/Rumah Dinas	1	104	2015	100	\N
38	4.1.4.01.05.	Penjualan Kendaraan Dinas Roda Dua	1	105	2015	100	\N
39	4.1.4.01.06.	Penjualan Kendaraan Dinas Roda Empat	1	106	2015	100	\N
40	4.1.4.01.07.	Penjualan Drum Bekas	1	107	2015	100	\N
41	4.1.4.01.08.	Penjualan Hasil Penebangan Pohon	1	108	2015	100	\N
42	4.1.4.01.09.	Penjualan Lampu Hias Bekas	1	109	2015	100	\N
43	4.1.4.01.10.	Penjualan Bahan-bahan Bekas Bangunan	1	110	2015	100	\N
44	4.1.4.01.11.	Penjualan Perlengkapan Lalu Lintas	1	111	2015	100	\N
45	4.1.4.01.12.	Penjualan Obat-obatan dan Hasil Farmasi	1	112	2015	100	\N
46	4.1.4.01.13.	Penjualan Hasil Pertanian	1	113	2015	100	\N
47	4.1.4.01.14.	Penjualan Hasil Kehutanan	1	114	2015	100	\N
48	4.1.4.01.15.	Penjualan Hasil Perkebunan	1	115	2015	100	\N
49	4.1.4.01.16.	Penjualan Hasil Peternakan	1	116	2015	100	\N
50	4.1.4.01.17.	Penjualan Hasil Perikanan	1	117	2015	100	\N
51	4.1.4.01.18.	Penjualan Hasil Sitaan	1	118	2015	100	\N
52	4.1.4.02.01.	Jasa Giro Kas Daerah	1	120	2015	100	\N
53	4.1.4.02.02.	Jasa Giro Pemegang Kas	1	121	2015	100	\N
54	4.1.4.02.03.	Jasa Giro Dana Cadangan	1	122	2015	100	\N
55	4.1.4.03.01.	Rekening Deposito pada BankPembangunan Daerah (Bank Jabar)-PAD	1	124	2015	100	\N
56	4.1.4.03.02.	Rekening Deposito pada BankPembangunan Daerah (Bank Jabar)-DCD	1	125	2015	100	\N
57	4.1.4.04.01.	Kerugian Uang Daerah	1	127	2015	100	\N
58	4.1.4.04.02.	Kerugian Barang Daerah	1	128	2015	100	\N
59	4.1.4.05.01.	Penerimaan Komisi	1	130	2015	100	\N
60	4.1.4.05.02.	Penerimaan Potongan	1	131	2015	100	\N
61	4.1.4.05.03.	Penerimaan Keuntungan Selisih Nilai Tukar Rupiah	1	132	2015	100	\N
62	4.1.4.06.01.	Bidang Pendidikan	1	134	2015	100	\N
63	4.1.4.06.02.	Bidang Kesehatan	1	135	2015	100	\N
64	4.1.4.06.03.	Bidang Pekerjaan Umum	1	136	2015	100	\N
65	4.1.4.06.04.	Bidang Perumahan Rakyat	1	137	2015	100	\N
66	4.1.4.06.05.	Bidang Penataan Ruang	1	138	2015	100	\N
67	4.1.4.06.06.	Bidang Perencanaan Pembangunan	1	139	2015	100	\N
68	4.1.4.06.07.	Bidang Perhubungan	1	140	2015	100	\N
69	4.1.4.06.08.	Bidang Lingkungan Hidup	1	141	2015	100	\N
70	4.1.4.06.09.	Bidang Pertanahan	1	142	2015	100	\N
71	4.1.4.07.01.	Pendapatan Denda Pajak Kendaraan Bermotor	1	144	2015	100	\N
72	4.1.4.07.02.	Pendapatan Denda Pajak Bea Balik Nama Kendaraan Bermotor	1	145	2015	100	\N
73	4.1.4.07.03.	Pendapatan Denda Pajak Kendaraan di Air	1	146	2015	100	\N
74	4.1.4.07.04.	Pendapatan Denda Pajak Bea Balik Nama Kendaraan di Air	1	147	2015	100	\N
75	4.1.4.07.05.	Pendapatan Denda Pajak Air Permukaan	1	148	2015	100	\N
76	4.1.4.08.01.	Pendapatan Denda Retribusi Jasa Umum	1	151	2015	100	\N
77	4.1.4.08.02.	Pendapatan Denda Retribusi Jasa Usaha	1	152	2015	100	\N
78	4.1.4.08.03.	Pendapatan Denda Retribusi Perizinan Tertentu	1	153	2015	100	\N
79	4.1.4.09.01.	Hasil Eksekusi Jaminan Atas Pelaksanaan Pekerjaan	1	156	2015	100	\N
80	4.1.4.09.02.	Hasil Eksekusi Jaminan Atas Pembongkaran Reklame	1	157	2015	100	\N
81	4.1.4.10.01.	Pendapatan dan Pengembalian Pajak Penghasilan Pasal 21	1	160	2015	100	\N
82	4.1.4.10.02.	Pendapatan dari Pengembalian Kelebihan Pembayaran Asuransi Kesehatan	1	161	2015	100	\N
83	4.1.4.10.03.	Pendapatan dari Pengembalian Kelebihan Pembayaran Gaji dan Tunjangan	1	162	2015	100	\N
84	4.1.4.10.04.	Pendapatan dari Pengembalian Kelebihan Pembayaran Perjalanan Dinas	1	163	2015	100	\N
85	4.1.4.10.05.	Pendapatan dari Pengembalian Uang Muka	1	164	2015	100	\N
86	4.1.4.10.06.	Pendapatan dari Pengembalian TASPEN	1	165	2015	100	\N
87	4.1.4.10.07.	Pendapatan dari Pengembalian Dana Operasional Siswa (BOS)	1	166	2015	100	\N
88	4.1.4.11.01.	Fasilitas Sosial	1	168	2015	100	\N
89	4.1.4.11.02.	Fasilitas Umum	1	169	2015	100	\N
90	4.1.4.12.01.	Uang Pendaftaran/Ujian Masuk	1	171	2015	100	\N
91	4.1.4.12.02.	Uang Sekolah/Pendidikan dan Pelatihan	1	172	2015	100	\N
92	4.1.4.12.03.	Uang Ujian Kenaikan Tingkat/Kelas	1	173	2015	100	\N
93	4.1.4.13.01.	Angsuran/Cicilan Penjualan Rumah Dinas	1	175	2015	100	\N
94	4.1.4.13.02.	Angsuran/Cicilan Penjualan Kendaraan Perorangan Dinas	1	176	2015	100	\N
95	4.1.4.15.01.	Sewa Tanah dan Bangunan	1	179	2015	100	\N
96	4.1.4.15.02.	Sewa Alat-alat Berat	1	180	2015	100	\N
97	4.1.4.15.03.	Sewa Gedung/Ruangan/Aula/Asrama/Mess	1	181	2015	100	\N
98	4.1.4.15.04.	Sewa Lahan ( Tanah, Tambak dan sejenisnya)	1	182	2015	100	\N
99	4.1.4.15.05.	Sewa Tempat Olah Raga	1	183	2015	100	\N
100	4.1.4.15.06.	Sewa Tempat Rekreasi	1	184	2015	100	\N
101	4.1.4.16.01.	Pendapatan BLUD Rumah Sakit Daerah	1	186	2015	100	\N
102	4.2.1.01.01.	Bagi Hasil dari Pajak Bumi dan Bangunan	1	191	2015	100	\N
103	4.2.1.01.02.	Bagi Hasil dari Bea Perolehan Hak Atas Tanah dan Bangunan	1	192	2015	100	\N
104	4.2.1.01.03.	Bagi Hasil dari Pajak Penghasilan (PPh) Pasal 25 dan Pasal 29 Wajib Pajak Orang Pribadi Dalam Negeri dan PPh Pasal 21	1	193	2015	100	\N
105	4.2.1.02.01.	Bagi Hasil dari Iuran Hak Pengusahaan Hutan	1	195	2015	100	\N
106	4.2.1.02.02.	Bagi Hasil dari Provisi Sumber Daya Hutan	1	196	2015	100	\N
107	4.2.1.02.03.	Bagi Hasil dari Dana Reboisasi	1	197	2015	100	\N
108	4.2.1.02.04.	Bagi Hasil dari Iuran Tetap (Land-Rent)	1	198	2015	100	\N
109	4.2.1.02.05.	Bagi Hasil dari Iuran Eksplorasi dan Iuran Eksploitasi (Royalti)	1	199	2015	100	\N
110	4.2.1.02.06.	Bagi Hasil dari Pungutan Pengusahaan Perikanan	1	200	2015	100	\N
111	4.2.1.02.07.	Bagi Hasil dari Pungutan Hasil Perikanan	1	201	2015	100	\N
112	4.2.1.02.08.	Bagi Hasil dari Pertambangan Minyak Bumi	1	202	2015	100	\N
113	4.2.1.02.09.	Bagi Hasil dari Pertambangan Gas Bumi/Alam	1	203	2015	100	\N
114	4.2.1.02.10.	Bagi Hasil dari Pertambangan Panas Bumi	1	204	2015	100	\N
115	4.2.1.01.04.	Bagi Hasil Cukai Hasil Tembakau	1	205	2015	100	\N
116	4.2.2.01.01.	Dana Alokasi Umum	1	208	2015	100	\N
117	4.2.3.01.01.	Dana Alokasi Khusus	1	211	2015	100	\N
118	4.3.1.01.01.	Pendapatan Hibah dari Pemerintah	1	215	2015	100	\N
119	4.3.1.02.01.	Pemerintah Daerah dari Pemerintah Daerah lainya	1	217	2015	100	\N
120	4.3.1.03.01.	Badan/Lembaga/Organisasi Swasta	1	219	2015	100	\N
121	4.3.1.04.01.	Kelompok Masyarakat/Perorangan	1	221	2015	100	\N
122	4.3.1.05.01.	Pendapatan Hibah dari Bilateral	1	223	2015	100	\N
123	4.3.1.05.02.	Pendapatan Hibah dari Multilateral	1	224	2015	100	\N
124	4.3.1.05.03.	Pendapatan Hibah dari Donor Lainnya	1	225	2015	100	\N
125	4.3.2.01.01.	Korban/Kerusakan Akibat Bencana Alam	1	228	2015	100	\N
126	4.3.3.01.01.	Dana Bagi Hasil Pajak dari Provinsi	1	231	2015	100	\N
127	4.3.3.02.01.	Dana Bagi Hasil Pajak dari Kabupaten	1	233	2015	100	\N
128	4.3.3.03.01.	Dana Bagi Hasil Pajak dari Kota	1	235	2015	100	\N
129	4.3.4.01.01.	Dana Penyesuaian	1	238	2015	100	\N
130	4.3.4.02.01.	Dana Otonomi Khusus	1	240	2015	100	\N
131	4.3.5.01.01.	Bantuan Keuangan dari Provinsi	1	243	2015	100	\N
132	4.3.5.02.01.	Bantuan Keuangan dari Kabupaten	1	245	2015	100	\N
133	4.3.5.03.01.	Bantuan Keuangan dari Kota	1	247	2015	100	\N
134	4.3.1.03.02.01.	Bantuan PT.Jasa Raharja (Persero)	1	249	2015	100	\N
135	4.3.1.03.02.02.	I P E P (Iuran Pembiayaan Ekspoitasi dan Pemeliharaan Prasarana Pengairan)	1	250	2015	100	\N
136	4.1.4.17.01.	Dari Kelompok Masyarakat	1	256	2015	100	\N
137	4.3.6.01.01.	Lain-lain Penerimaan...	1	261	2015	100	\N
138	4.3.1.03.02.	Bantuan Pihak Ketiga	1	333	2015	100	\N
139	4.1.2.01.01.01.	1. Rumah Sakit Jiwa	1	502	2015	100	\N
140	4.1.2.01.01.02.	2. Rumah Sakit Paru	1	503	2015	100	\N
141	4.1.2.01.01.03.	3. Balai Kesehatan Paru Masyarakat Cirebon	1	504	2015	100	\N
142	4.1.2.01.03.	Retribusi Pelayanan Pendidikan	1	505	2015	100	\N
143	4.1.2.01.02.01.	1. Balai Kemeterologian Bogor	1	508	2015	100	\N
144	4.1.2.01.02.02.	2. Balai Kemeterologian Karawang	1	509	2015	100	\N
145	4.1.2.01.02.03.	3. Balai Kemeterologian Cirebon	1	510	2015	100	\N
146	4.1.2.01.02.04.	4. Balai Kemeterologian Bandung	1	511	2015	100	\N
147	4.1.2.01.02.05.	5. Balai Kemeterologian Tasikmalaya	1	512	2015	100	\N
148	4.1.2.02.01.01.	1. Sewa Tanah dan Bangunan Dinas Bina Marga	1	515	2015	100	\N
149	4.1.2.02.01.02.	2. Sewa Alat Berat	1	516	2015	100	\N
150	4.1.2.02.01.03.	3. Sewa Gedung/Ruangan/Aula/Asrama	1	517	2015	100	\N
151	4.1.2.02.02.	Retribusi Pelayanan Kepelabuhan	1	518	2015	100	\N
152	4.1.2.02.03.01.	a. Dinas Kehutanan	1	522	2015	100	\N
153	4.1.2.02.03.02.	b. Dinas Pemuda dan Olah Raga	1	523	2015	100	\N
154	4.1.2.02.04.	Retribusi Penyebrangan di Air	1	524	2015	100	\N
155	4.1.2.02.05.01.	1. Dinas Pertanian dan Tanaman Pangan	1	526	2015	100	\N
156	4.1.2.02.05.02.	2. Dinas Peternakan	1	527	2015	100	\N
157	4.1.2.02.05.03.	3. Dinas Perikanan	1	528	2015	100	\N
158	4.1.2.02.05.04.	4. Dinas Perkebunan	1	529	2015	100	\N
159	4.1.2.03.02.	Retribusi Izin Usaha Perikanan	1	532	2015	100	\N
160	4.1.3.01.01.01.	1. Bagian Laba Atas Penyertaan Modal pada PD. Agribisnis dan Pertambangan	1	534	2015	100	\N
161	4.1.3.01.01.02.	2. Bagian Laba Atas Penyertaan Modal pada PD. Jasa dan Kepariwisataan	1	535	2015	100	\N
162	4.1.3.01.01.03.	3. Bagian Laba Atas Penyertaan Modal pada PT. Agronesia	1	536	2015	100	\N
163	4.1.3.01.01.04.	4. Bagian Laba Atas Penyertaan Modal pada PT. Jasa Sarana	1	537	2015	100	\N
164	4.1.3.01.02.01.	1. Bagian Laba Keuangan Bank PT. Bank Pembangunan Daerah	1	539	2015	100	\N
165	4.1.3.01.02.02.	2. Bagian Laba Keuangan Bank Bank Perkreditan Rakyat	1	540	2015	100	\N
166	4.1.3.01.02.03.	3. Bagian Laba Keuangan Bank Lembaga Perkreditan Kecamatan	1	541	2015	100	\N
167	4.1.3.02.01.	Bagian Laba Atas Penyertaan modal pada Perusahaan Milik Pemerintah/BUMN	1	542	2015	100	\N
168	4.1.3.03.01.	Perusahaan Patungan	1	543	2015	100	\N
169	4.1.4.06.10.	Bidang Pertanian	1	581	2015	100	\N
170	4.1.4.06.11.	Bidang Perdagangan	1	582	2015	100	\N
171	4.1.4.06.12.	Bidang Perindustrian	1	583	2015	100	\N
172	4.1.4.06.13.	Bidang Pariwisata	1	584	2015	100	\N
173	4.1.4.06.14.	Bidang Kebudayaan	1	585	2015	100	\N
174	4.1.4.06.15.	Bidang Pemerintahan	1	586	2015	100	\N
175	4.1.2.02.01.04.	Sewa Peralatan Laboratorium/Jasa Pengujian	1	587	2015	100	\N
176	4.1.4.07.07.	Pendapatan Denda Pajak Bahan Bakar Kendaraan Bermotor	1	593	2015	100	\N
177	4.1.4.07.08.	Pendapatan Denda Pajak Rokok	1	594	2015	100	\N
178	4.1.4.10.08.	Pendapatan dari Pengembalian Belanja Subsidi	1	607	2015	100	\N
179	4.1.4.10.09.	Pendapatan dari Pengembalian Belanja Hibah	1	608	2015	100	\N
180	4.1.4.10.10.	Pendapatan dari Pengembalian Belanja Sosial	1	609	2015	100	\N
181	4.1.4.10.11.	Pendapatan dari Pengembalian Belanja Bantuan Keuangan	1	610	2015	100	\N
182	4.1.4.13.03.	Angsuran/Cicilan Ganti Kerugian Barang Milik Daerah	1	618	2015	100	\N
183	4.1.4.13.04.	Angsuran/Cicilan Penjualan Tanah	1	619	2015	100	\N
184	4.1.2.01.01.04.	4. Balai Laboratorium Kesehatan	1	654	2015	100	\N
185	4.1.2.01.01.05.	5. Balai Kesehatan Kerja Masyarakat Bandung	1	655	2015	100	\N
186	4.1.2.02.01.03.01.	a. Mess Pangandaran Dinas PSDA	1	656	2015	100	\N
187	4.1.2.02.01.03.02.	b. Dinas Tenaga Kerja dan Transmigrasi	1	657	2015	100	\N
188	4.1.2.02.01.03.03.01.	1) Balai Taman Budaya	1	659	2015	100	\N
189	4.1.2.02.01.03.03.02.	2) Balai Museum Sribaduga	1	660	2015	100	\N
190	4.1.2.02.01.03.03.03.	3) Mess Pondok Seni Pangandaran	1	661	2015	100	\N
191	4.1.2.02.01.03.04.01.	1) Laboratorium Kesehatan	1	663	2015	100	\N
192	4.1.2.02.01.03.04.02.	2)BKPM	1	664	2015	100	\N
193	4.1.2.02.01.03.04.03.	3)Balai Pelatihan Kesehatan	1	665	2015	100	\N
194	4.1.2.02.01.03.05.	e. Rumah Sakit Jiwa	1	666	2015	100	\N
195	4.1.2.02.01.03.06.	f. Rumah Sakit Paru	1	667	2015	100	\N
196	4.1.2.02.01.03.07.01.	1) BPTPK Cirebon	1	669	2015	100	\N
197	4.1.2.02.01.03.07.02.	2) Balai Pengujian dan Pembinaan Mutu Hasil Perikanan	1	670	2015	100	\N
198	4.1.2.02.01.03.07.03.	3) Balai Pelabuhan Perikanan Pantai Muara Asem	1	671	2015	100	\N
199	4.1.2.02.01.03.08.01.	1) BPP Padi Cihea	1	673	2015	100	\N
200	4.1.2.02.01.03.08.02.	2) BPP Palawija	1	674	2015	100	\N
201	4.1.2.02.01.03.08.03.	3) BPP Hortikultura	1	675	2015	100	\N
202	4.1.2.02.01.03.08.04.	4) BPTPH	1	676	2015	100	\N
203	4.1.2.02.01.03.08.05.	5) BPSBTPH	1	677	2015	100	\N
204	4.1.2.02.01.03.08.06.	6) BAPELTAN	1	678	2015	100	\N
205	4.1.2.02.01.03.08.07.	7) KOPERASI PUSAT	1	679	2015	100	\N
206	4.1.2.02.01.03.09.	i. Dinas Sosial	1	680	2015	100	\N
207	4.1.2.02.01.03.12.01.	1) Balai Perindustrian	1	682	2015	100	\N
208	4.1.2.02.01.03.14.	k. Dinas Pendapatan Provinsi Jawa Barat	1	683	2015	100	\N
209	4.1.2.02.01.03.15.	l. BKPP Wilayah Bogor	1	684	2015	100	\N
210	4.1.2.02.01.03.16.	m. BKPP Wilayah Purwakarta	1	685	2015	100	\N
211	4.1.2.02.01.03.17.	n. BKPP Wilayah Priangan	1	686	2015	100	\N
212	4.1.2.02.01.03.18.	o. Badan Pendidikan dan Pelatihan	1	687	2015	100	\N
213	4.1.2.02.01.03.19.	p. Biro Humas, Protokol dan Umum	1	688	2015	100	\N
214	4.1.2.02.01.03.20.01.	1) LPTQ	1	690	2015	100	\N
215	4.1.2.02.01.03.20.02.	2) Pusda'i	1	691	2015	100	\N
216	4.1.2.02.01.03.20.03.	3) At Ta'awun	1	692	2015	100	\N
217	4.1.2.02.01.04.01.01.	1) BPPPH dan Kesmapet	1	694	2015	100	\N
218	4.1.2.02.01.04.01.02.	2) BPMPT Cikole Lembang	1	695	2015	100	\N
219	4.1.2.02.01.04.02.01.	1) Balai Pengujian Laboratorium Energi dan Sumber Daya Mineral	1	697	2015	100	\N
220	4.1.2.02.01.04.03.01.	1) BPMKL	1	699	2015	100	\N
\.


--
-- Name: pajaks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('pajaks_id_seq', 220, true);


--
-- Data for Name: paps; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY paps (id, kd_status, kd_bayar, npwpd, nm_perus, al_perus, vol_air, npa, bea_pok_pjk, bea_den_pjk, m_pjk_bln, m_pjk_thn, tgl_tetap, tgl_jt_tempo, keterangan) FROM stdin;
\.


--
-- Name: paps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('paps_id_seq', 1, false);


--
-- Data for Name: params; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY params (id, denda, jatuh_tempo) FROM stdin;
\.


--
-- Name: params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('params_id_seq', 1, false);


--
-- Data for Name: pegawai_users; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY pegawai_users (user_id, pegawai_id, change_unit) FROM stdin;
\.


--
-- Data for Name: pegawais; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY pegawais (id, kode, nama, status, jabatan_id, unit_id, user_id) FROM stdin;
\.


--
-- Name: pegawais_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('pegawais_id_seq', 1, false);


--
-- Data for Name: pkbs; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY pkbs (id, kd_status, flag_sms, no_ktp, no_rangka, email, no_hp, tg_pros_daftar, jam_daftar, ket, kd_bayar, kd_wil, kd_wil_proses, nm_pemilik, no_polisi, warna_tnkb, milik_ke, nm_merek_kb, nm_model_kb, th_buatan, tg_akhir_pjklm, tg_akhir_pjkbr, bbn_pok, bbn_den, pkb_pok, pkb_den, swd_pok, swd_den, adm_stnk, adm_tnkb, jumlah, tg_bayar_bank, jam_bayar_bank, kd_trn_bank, kd_trn_dpd, ivr) FROM stdin;
\.


--
-- Name: pkbs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('pkbs_id_seq', 1, false);


--
-- Data for Name: rekenings; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY rekenings (id, kode, nama, level_id, is_summary, parent_id) FROM stdin;
1	4.	PENDAPATAN DAERAH	1	1	\N
2	4.1.	PENDAPATAN ASLI DAERAH	2	1	\N
3	4.1.1.	Pajak Daerah	3	1	\N
4	4.1.1.01.	Pajak Kendaraan Bermotor	4	1	\N
5	4.1.1.01.01.	Pajak Kendaraan Bermotor	5	0	\N
6	4.1.1.01.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	5	0	\N
8	4.1.1.01.04.	B-1 Bus, Micro Bus (Pribadi)	5	0	\N
9	4.1.1.01.05.	B-2 Bus, Micro Bus (Umum)	5	0	\N
11	4.1.1.01.07.	C-1 Truck, Pick Up (Pribadi)	5	0	\N
12	4.1.1.01.08.	C-2 Truck, Pick Up (Umum)	5	0	\N
14	4.1.1.01.10.	D-1 Kendaraan Khusus (Pribadi)	5	0	\N
15	4.1.1.01.11.	D-2 Kendaraan Khusus (Umum)	5	0	\N
17	4.1.1.01.13.	E-1 Sepeda Motor, Scooter (Pribadi)	5	0	\N
19	4.1.1.02.	Pajak Kendaraan Di Atas Air	4	1	\N
20	4.1.1.02.01.	Pajak Kendaraan Di Atas Air	5	0	\N
21	4.1.1.03.	Bea Balik Nama Kendaraan Bermotor	4	1	\N
22	4.1.1.03.01.	Bea Balik Nama Kendaraan Bermotor	5	0	\N
23	4.1.1.03.02.	A-2 Sedan, Jeep, Station Wagon (Umum)	5	0	\N
24	4.1.1.03.03.	A-3 Sedan, Jeep, Station Wagon (Dinas)	5	0	\N
25	4.1.1.03.04.	B-1 Bus, Micro Bus (Pribadi)	5	0	\N
26	4.1.1.03.05.	B-2 Bus, Micro Bus (Umum)	5	0	\N
27	4.1.1.03.06.	B-3 Bus, Micro Bus (Dinas)	5	0	\N
28	4.1.1.03.07.	C-1 Truck, Pick Up (Pribadi)	5	0	\N
29	4.1.1.03.08.	C-2 Truck, Pick Up (Umum)	5	0	\N
30	4.1.1.03.09.	C-3 Truck, Pick Up (Dinas)	5	0	\N
31	4.1.1.03.10.	D-1 Kendaraan Khusus (Pribadi)	5	0	\N
32	4.1.1.03.11.	D-2 Kendaraan Khusus (Umum)	5	0	\N
33	4.1.1.03.12.	D-3 Kendaraan Khusus (Dinas)	5	0	\N
34	4.1.1.03.13.	E-1 Sepeda Motor, Scooter (Pribadi)	5	0	\N
35	4.1.1.03.14.	E-2 Sepeda Motor, Scooter (Dinas)	5	0	\N
36	4.1.1.04.	Bea Balik nama Kendaraan Di atas Air	4	1	\N
37	4.1.1.04.01.	Bea Balik nama Kendaraan Di atas Air	5	0	\N
38	4.1.1.05.	Pajak Bahan Bakar Kendaraan Bermotor	4	1	\N
39	4.1.1.05.01.	Pajak Bahan Bakar Kendaraan Bermotor	5	0	\N
40	4.1.1.05.02.	Pertamax	5	0	\N
41	4.1.1.05.03.	Pertamax Plus	5	0	\N
42	4.1.1.05.04.	Solar	5	0	\N
43	4.1.1.05.05.	Gas	5	0	\N
44	4.1.1.06.	Pajak Air	4	1	\N
45	4.1.1.06.01.	Pajak Pengambilan Pemanfaatan Air Permukaan	5	0	\N
47	4.1.1.07.	Pajak Rokok	4	1	\N
48	4.1.1.07.01.	Pajak Rokok	5	0	\N
49	4.1.2.	Retribusi Daerah	3	1	\N
50	4.1.2.01.	Retribusi Jasa Umum	4	1	\N
501	4.1.2.01.01.	Retribusi Pelayanan Kesehatan	5	1	\N
502	4.1.2.01.01.01.	1. Rumah Sakit Jiwa	6	0	\N
503	4.1.2.01.01.02.	2. Rumah Sakit Paru	6	0	\N
504	4.1.2.01.01.03.	3. Balai Kesehatan Paru Masyarakat Cirebon	6	0	\N
654	4.1.2.01.01.04.	4. Balai Laboratorium Kesehatan	6	0	\N
655	4.1.2.01.01.05.	5. Balai Kesehatan Kerja Masyarakat Bandung	6	0	\N
507	4.1.2.01.02.	Retribusi Pelayanan Tera/Tera Ulang	5	1	\N
508	4.1.2.01.02.01.	1. Balai Kemeterologian Bogor	6	0	\N
509	4.1.2.01.02.02.	2. Balai Kemeterologian Karawang	6	0	\N
510	4.1.2.01.02.03.	3. Balai Kemeterologian Cirebon	6	0	\N
511	4.1.2.01.02.04.	4. Balai Kemeterologian Bandung	6	0	\N
512	4.1.2.01.02.05.	5. Balai Kemeterologian Tasikmalaya	6	0	\N
505	4.1.2.01.03.	Retribusi Pelayanan Pendidikan	5	0	\N
65	4.1.2.02.	Retribusi Jasa Usaha	4	1	\N
514	4.1.2.02.01.	Retribusi Pemakaian Kekayaan Daerah	5	1	\N
515	4.1.2.02.01.01.	1. Sewa Tanah dan Bangunan Dinas Bina Marga	6	0	\N
516	4.1.2.02.01.02.	2. Sewa Alat Berat	6	0	\N
517	4.1.2.02.01.03.	3. Sewa Gedung/Ruangan/Aula/Asrama	6	0	\N
656	4.1.2.02.01.03.01.	a. Mess Pangandaran Dinas PSDA	7	0	\N
657	4.1.2.02.01.03.02.	b. Dinas Tenaga Kerja dan Transmigrasi	7	0	\N
658	4.1.2.02.01.03.03.	c. Dinas Kebudayaan dan Pariwisata	7	1	\N
659	4.1.2.02.01.03.03.01.	1) Balai Taman Budaya	8	0	\N
660	4.1.2.02.01.03.03.02.	2) Balai Museum Sribaduga	8	0	\N
661	4.1.2.02.01.03.03.03.	3) Mess Pondok Seni Pangandaran	8	0	\N
662	4.1.2.02.01.03.04.	d. Dinas Kesehatan	7	1	\N
663	4.1.2.02.01.03.04.01.	1) Laboratorium Kesehatan	8	0	\N
664	4.1.2.02.01.03.04.02.	2)BKPM	8	0	\N
665	4.1.2.02.01.03.04.03.	3)Balai Pelatihan Kesehatan	8	0	\N
666	4.1.2.02.01.03.05.	e. Rumah Sakit Jiwa	7	0	\N
667	4.1.2.02.01.03.06.	f. Rumah Sakit Paru	7	0	\N
668	4.1.2.02.01.03.07.	g. Dinas Perikanan	7	1	\N
669	4.1.2.02.01.03.07.01.	1) BPTPK Cirebon	8	0	\N
670	4.1.2.02.01.03.07.02.	2) Balai Pengujian dan Pembinaan Mutu Hasil Perikanan	8	0	\N
671	4.1.2.02.01.03.07.03.	3) Balai Pelabuhan Perikanan Pantai Muara Asem	8	0	\N
672	4.1.2.02.01.03.08.	h. Dinas Pertanian	7	1	\N
673	4.1.2.02.01.03.08.01.	1) BPP Padi Cihea	8	0	\N
674	4.1.2.02.01.03.08.02.	2) BPP Palawija	8	0	\N
675	4.1.2.02.01.03.08.03.	3) BPP Hortikultura	8	0	\N
676	4.1.2.02.01.03.08.04.	4) BPTPH	8	0	\N
677	4.1.2.02.01.03.08.05.	5) BPSBTPH	8	0	\N
678	4.1.2.02.01.03.08.06.	6) BAPELTAN	8	0	\N
679	4.1.2.02.01.03.08.07.	7) KOPERASI PUSAT	8	0	\N
680	4.1.2.02.01.03.09.	i. Dinas Sosial	7	0	\N
681	4.1.2.02.01.03.12.	j. Dinas Industri dan Perdagangan	7	1	\N
682	4.1.2.02.01.03.12.01.	1) Balai Perindustrian	8	0	\N
683	4.1.2.02.01.03.14.	k. Dinas Pendapatan Provinsi Jawa Barat	7	0	\N
684	4.1.2.02.01.03.15.	l. BKPP Wilayah Bogor	7	0	\N
685	4.1.2.02.01.03.16.	m. BKPP Wilayah Purwakarta	7	0	\N
686	4.1.2.02.01.03.17.	n. BKPP Wilayah Priangan	7	0	\N
687	4.1.2.02.01.03.18.	o. Badan Pendidikan dan Pelatihan	7	0	\N
688	4.1.2.02.01.03.19.	p. Biro Humas, Protokol dan Umum	7	0	\N
689	4.1.2.02.01.03.20.	q. Biro Pelayanan Sosial Dasar	7	1	\N
690	4.1.2.02.01.03.20.01.	1) LPTQ	8	0	\N
691	4.1.2.02.01.03.20.02.	2) Pusda'i	8	0	\N
692	4.1.2.02.01.03.20.03.	3) At Ta'awun	8	0	\N
587	4.1.2.02.01.04.	Sewa Peralatan Laboratorium/Jasa Pengujian	6	0	\N
693	4.1.2.02.01.04.01.	a. Dinas Peternakan	7	1	\N
694	4.1.2.02.01.04.01.01.	1) BPPPH dan Kesmapet	8	0	\N
695	4.1.2.02.01.04.01.02.	2) BPMPT Cikole Lembang	8	0	\N
696	4.1.2.02.01.04.02.	b. Dinas Energi Sumber Daya Mineral	7	1	\N
697	4.1.2.02.01.04.02.01.	1) Balai Pengujian Laboratorium Energi dan Sumber Daya Mineral	8	0	\N
698	4.1.2.02.01.04.03.	c. Dinas Perumahan dan Permukiman	7	1	\N
699	4.1.2.02.01.04.03.01.	1) BPMKL	8	0	\N
518	4.1.2.02.02.	Retribusi Pelayanan Kepelabuhan	5	0	\N
521	4.1.2.02.03.	Retribusi Tempat Rekreasi dan Olah Raga	5	1	\N
522	4.1.2.02.03.01.	a. Dinas Kehutanan	6	0	\N
523	4.1.2.02.03.02.	b. Dinas Pemuda dan Olah Raga	6	0	\N
524	4.1.2.02.04.	Retribusi Penyebrangan di Air	5	0	\N
525	4.1.2.02.05.	Retribusi Penjualan Produk Usaha Daerah	5	1	\N
526	4.1.2.02.05.01.	1. Dinas Pertanian dan Tanaman Pangan	6	0	\N
527	4.1.2.02.05.02.	2. Dinas Peternakan	6	0	\N
528	4.1.2.02.05.03.	3. Dinas Perikanan	6	0	\N
529	4.1.2.02.05.04.	4. Dinas Perkebunan	6	0	\N
79	4.1.2.03.	Retribusi Perizinan Tertentu	4	1	\N
80	4.1.2.03.01.	Retribusi Izin Trayek	5	0	\N
532	4.1.2.03.02.	Retribusi Izin Usaha Perikanan	5	0	\N
85	4.1.3.	Hasil Pengelolaan Kekayaan Daerah yang Dipisahkan	3	1	\N
86	4.1.3.01.	Bagian Laba Atas Penyertaan Modal pada Perusahaan Milik Daerah/BUMD	4	1	\N
533	4.1.3.01.01.	Bagian Laba Atas Penyertaan Modal pada Perusahaan Daerah	5	1	\N
534	4.1.3.01.01.01.	1. Bagian Laba Atas Penyertaan Modal pada PD. Agribisnis dan Pertambangan	6	0	\N
535	4.1.3.01.01.02.	2. Bagian Laba Atas Penyertaan Modal pada PD. Jasa dan Kepariwisataan	6	0	\N
536	4.1.3.01.01.03.	3. Bagian Laba Atas Penyertaan Modal pada PT. Agronesia	6	0	\N
537	4.1.3.01.01.04.	4. Bagian Laba Atas Penyertaan Modal pada PT. Jasa Sarana	6	0	\N
538	4.1.3.01.02.	Bagian Laba Atas Penyertaan Modal pada Lembaga Keuangan Bank	5	1	\N
539	4.1.3.01.02.01.	1. Bagian Laba Keuangan Bank PT. Bank Pembangunan Daerah	6	0	\N
540	4.1.3.01.02.02.	2. Bagian Laba Keuangan Bank Bank Perkreditan Rakyat	6	0	\N
541	4.1.3.01.02.03.	3. Bagian Laba Keuangan Bank Lembaga Perkreditan Kecamatan	6	0	\N
91	4.1.3.02.	Bagian Laba Atas Penyertaan modal pada Perusahaan Milik Pemerintah/BUMN	4	1	\N
542	4.1.3.02.01.	Bagian Laba Atas Penyertaan modal pada Perusahaan Milik Pemerintah/BUMN	5	0	\N
95	4.1.3.03.	Bagian Laba Atas Penyertaan Modal pada Perusahaan Patungan Milik Swasta	4	1	\N
543	4.1.3.03.01.	Perusahaan Patungan	5	0	\N
99	4.1.4.	Lain-lain Pendapatan Asli Daerah yang Sah	3	1	\N
100	4.1.4.01.	Hasil Penjualan Aset Daerah yang Tidak Dipisahkan	4	1	\N
101	4.1.4.01.01.	Pelepasan Hak Atas Tanah	5	0	\N
102	4.1.4.01.02.	Penjualan Peralatan/Perlengkapan Kantor Tidak Terpakai	5	0	\N
103	4.1.4.01.03.	Penjualan Mesin/Alat-alat Berat Tidak Terpakai	5	0	\N
104	4.1.4.01.04.	Penjualan Rumah Jabatan/Rumah Dinas	5	0	\N
105	4.1.4.01.05.	Penjualan Kendaraan Dinas Roda Dua	5	0	\N
106	4.1.4.01.06.	Penjualan Kendaraan Dinas Roda Empat	5	0	\N
107	4.1.4.01.07.	Penjualan Drum Bekas	5	0	\N
108	4.1.4.01.08.	Penjualan Hasil Penebangan Pohon	5	0	\N
109	4.1.4.01.09.	Penjualan Lampu Hias Bekas	5	0	\N
110	4.1.4.01.10.	Penjualan Bahan-bahan Bekas Bangunan	5	0	\N
111	4.1.4.01.11.	Penjualan Perlengkapan Lalu Lintas	5	0	\N
112	4.1.4.01.12.	Penjualan Obat-obatan dan Hasil Farmasi	5	0	\N
113	4.1.4.01.13.	Penjualan Hasil Pertanian	5	0	\N
114	4.1.4.01.14.	Penjualan Hasil Kehutanan	5	0	\N
115	4.1.4.01.15.	Penjualan Hasil Perkebunan	5	0	\N
116	4.1.4.01.16.	Penjualan Hasil Peternakan	5	0	\N
117	4.1.4.01.17.	Penjualan Hasil Perikanan	5	0	\N
118	4.1.4.01.18.	Penjualan Hasil Sitaan	5	0	\N
119	4.1.4.02.	Jasa Giro	4	1	\N
120	4.1.4.02.01.	Jasa Giro Kas Daerah	5	0	\N
121	4.1.4.02.02.	Jasa Giro Pemegang Kas	5	0	\N
122	4.1.4.02.03.	Jasa Giro Dana Cadangan	5	0	\N
123	4.1.4.03.	Pendapatan Bunga	4	1	\N
124	4.1.4.03.01.	Rekening Deposito pada BankPembangunan Daerah (Bank Jabar)-PAD	5	0	\N
125	4.1.4.03.02.	Rekening Deposito pada BankPembangunan Daerah (Bank Jabar)-DCD	5	0	\N
126	4.1.4.04.	Tuntutan Ganti Rugi (TGR)	4	1	\N
127	4.1.4.04.01.	Kerugian Uang Daerah	5	0	\N
128	4.1.4.04.02.	Kerugian Barang Daerah	5	0	\N
129	4.1.4.05.	Komisi, Potongan dan Keuntungan Selisih Nilai Tukar Rupiah	4	1	\N
130	4.1.4.05.01.	Penerimaan Komisi	5	0	\N
131	4.1.4.05.02.	Penerimaan Potongan	5	0	\N
132	4.1.4.05.03.	Penerimaan Keuntungan Selisih Nilai Tukar Rupiah	5	0	\N
133	4.1.4.06.	Pendapatan Denda Atas Keterlambatan Pelaksanaan Pekerjaan	4	1	\N
134	4.1.4.06.01.	Bidang Pendidikan	5	0	\N
135	4.1.4.06.02.	Bidang Kesehatan	5	0	\N
136	4.1.4.06.03.	Bidang Pekerjaan Umum	5	0	\N
137	4.1.4.06.04.	Bidang Perumahan Rakyat	5	0	\N
138	4.1.4.06.05.	Bidang Penataan Ruang	5	0	\N
139	4.1.4.06.06.	Bidang Perencanaan Pembangunan	5	0	\N
140	4.1.4.06.07.	Bidang Perhubungan	5	0	\N
141	4.1.4.06.08.	Bidang Lingkungan Hidup	5	0	\N
142	4.1.4.06.09.	Bidang Pertanahan	5	0	\N
581	4.1.4.06.10.	Bidang Pertanian	5	0	\N
582	4.1.4.06.11.	Bidang Perdagangan	5	0	\N
583	4.1.4.06.12.	Bidang Perindustrian	5	0	\N
584	4.1.4.06.13.	Bidang Pariwisata	5	0	\N
585	4.1.4.06.14.	Bidang Kebudayaan	5	0	\N
586	4.1.4.06.15.	Bidang Pemerintahan	5	0	\N
143	4.1.4.07.	Pendapatan Denda Pajak	4	1	\N
144	4.1.4.07.01.	Pendapatan Denda Pajak Kendaraan Bermotor	5	0	\N
145	4.1.4.07.02.	Pendapatan Denda Pajak Bea Balik Nama Kendaraan Bermotor	5	0	\N
146	4.1.4.07.03.	Pendapatan Denda Pajak Kendaraan di Air	5	0	\N
147	4.1.4.07.04.	Pendapatan Denda Pajak Bea Balik Nama Kendaraan di Air	5	0	\N
148	4.1.4.07.05.	Pendapatan Denda Pajak Air Permukaan	5	0	\N
593	4.1.4.07.07.	Pendapatan Denda Pajak Bahan Bakar Kendaraan Bermotor	5	0	\N
594	4.1.4.07.08.	Pendapatan Denda Pajak Rokok	5	0	\N
150	4.1.4.08.	Pendapatan Denda Retribusi	4	1	\N
151	4.1.4.08.01.	Pendapatan Denda Retribusi Jasa Umum	5	0	\N
152	4.1.4.08.02.	Pendapatan Denda Retribusi Jasa Usaha	5	0	\N
153	4.1.4.08.03.	Pendapatan Denda Retribusi Perizinan Tertentu	5	0	\N
155	4.1.4.09.	Pendapatan Hasil Eksekusi Atas Jaminan	4	1	\N
156	4.1.4.09.01.	Hasil Eksekusi Jaminan Atas Pelaksanaan Pekerjaan	5	0	\N
157	4.1.4.09.02.	Hasil Eksekusi Jaminan Atas Pembongkaran Reklame	5	0	\N
159	4.1.4.10.	Pendapatan dari Pengembalian	4	1	\N
160	4.1.4.10.01.	Pendapatan dan Pengembalian Pajak Penghasilan Pasal 21	5	0	\N
161	4.1.4.10.02.	Pendapatan dari Pengembalian Kelebihan Pembayaran Asuransi Kesehatan	5	0	\N
162	4.1.4.10.03.	Pendapatan dari Pengembalian Kelebihan Pembayaran Gaji dan Tunjangan	5	0	\N
163	4.1.4.10.04.	Pendapatan dari Pengembalian Kelebihan Pembayaran Perjalanan Dinas	5	0	\N
164	4.1.4.10.05.	Pendapatan dari Pengembalian Uang Muka	5	0	\N
165	4.1.4.10.06.	Pendapatan dari Pengembalian TASPEN	5	0	\N
166	4.1.4.10.07.	Pendapatan dari Pengembalian Dana Operasional Siswa (BOS)	5	0	\N
607	4.1.4.10.08.	Pendapatan dari Pengembalian Belanja Subsidi	5	0	\N
608	4.1.4.10.09.	Pendapatan dari Pengembalian Belanja Hibah	5	0	\N
609	4.1.4.10.10.	Pendapatan dari Pengembalian Belanja Sosial	5	0	\N
610	4.1.4.10.11.	Pendapatan dari Pengembalian Belanja Bantuan Keuangan	5	0	\N
167	4.1.4.11.	Fasilitas Sosial dan Fasilitas Umum	4	1	\N
168	4.1.4.11.01.	Fasilitas Sosial	5	0	\N
169	4.1.4.11.02.	Fasilitas Umum	5	0	\N
170	4.1.4.12.	Pendapatan dari Penyelenggaraan Pendidikan dan Pelatihan	4	1	\N
171	4.1.4.12.01.	Uang Pendaftaran/Ujian Masuk	5	0	\N
172	4.1.4.12.02.	Uang Sekolah/Pendidikan dan Pelatihan	5	0	\N
173	4.1.4.12.03.	Uang Ujian Kenaikan Tingkat/Kelas	5	0	\N
174	4.1.4.13.	Pendapatan dari Angsuran/Cicilan Penjualan	4	1	\N
175	4.1.4.13.01.	Angsuran/Cicilan Penjualan Rumah Dinas	5	0	\N
176	4.1.4.13.02.	Angsuran/Cicilan Penjualan Kendaraan Perorangan Dinas	5	0	\N
618	4.1.4.13.03.	Angsuran/Cicilan Ganti Kerugian Barang Milik Daerah	5	0	\N
619	4.1.4.13.04.	Angsuran/Cicilan Penjualan Tanah	5	0	\N
177	4.1.4.14.	Penerimaan dari Taman Hutan Raya (TAHURA)	4	1	\N
178	4.1.4.15.	Pendapatan dari Sewa	4	1	\N
179	4.1.4.15.01.	Sewa Tanah dan Bangunan	5	0	\N
180	4.1.4.15.02.	Sewa Alat-alat Berat	5	0	\N
181	4.1.4.15.03.	Sewa Gedung/Ruangan/Aula/Asrama/Mess	5	0	\N
182	4.1.4.15.04.	Sewa Lahan ( Tanah, Tambak dan sejenisnya)	5	0	\N
183	4.1.4.15.05.	Sewa Tempat Olah Raga	5	0	\N
184	4.1.4.15.06.	Sewa Tempat Rekreasi	5	0	\N
185	4.1.4.16.	Pendapatan Badan Layanan Umum Daerah (BLUD)	4	1	\N
186	4.1.4.16.01.	Pendapatan BLUD Rumah Sakit Daerah	5	0	\N
187	4.1.4.17.	Hasil Pengelolaan Dana Bergulir	4	1	\N
256	4.1.4.17.01.	Dari Kelompok Masyarakat	5	0	\N
627	4.1.4.18.	Pendapatan Penerimaan Lain-lain	4	1	\N
188	4.2.	DANA PERIMBANGAN	2	1	\N
189	4.2.1.	Dana Bagi Hasil Pajak/Bagi Hasil Bukan Pajak	3	1	\N
190	4.2.1.01.	Bagi Hasil Pajak	4	1	\N
191	4.2.1.01.01.	Bagi Hasil dari Pajak Bumi dan Bangunan	5	0	\N
192	4.2.1.01.02.	Bagi Hasil dari Bea Perolehan Hak Atas Tanah dan Bangunan	5	0	\N
193	4.2.1.01.03.	Bagi Hasil dari Pajak Penghasilan (PPh) Pasal 25 dan Pasal 29 Wajib Pajak Orang Pribadi Dalam Negeri dan PPh Pasal 21	5	0	\N
205	4.2.1.01.04.	Bagi Hasil Cukai Hasil Tembakau	5	0	\N
194	4.2.1.02.	Bagi Hasil Bukan Pajak/Sumber Daya Alam	4	1	\N
195	4.2.1.02.01.	Bagi Hasil dari Iuran Hak Pengusahaan Hutan	5	0	\N
196	4.2.1.02.02.	Bagi Hasil dari Provisi Sumber Daya Hutan	5	0	\N
197	4.2.1.02.03.	Bagi Hasil dari Dana Reboisasi	5	0	\N
198	4.2.1.02.04.	Bagi Hasil dari Iuran Tetap (Land-Rent)	5	0	\N
199	4.2.1.02.05.	Bagi Hasil dari Iuran Eksplorasi dan Iuran Eksploitasi (Royalti)	5	0	\N
200	4.2.1.02.06.	Bagi Hasil dari Pungutan Pengusahaan Perikanan	5	0	\N
201	4.2.1.02.07.	Bagi Hasil dari Pungutan Hasil Perikanan	5	0	\N
202	4.2.1.02.08.	Bagi Hasil dari Pertambangan Minyak Bumi	5	0	\N
203	4.2.1.02.09.	Bagi Hasil dari Pertambangan Gas Bumi/Alam	5	0	\N
204	4.2.1.02.10.	Bagi Hasil dari Pertambangan Panas Bumi	5	0	\N
206	4.2.2.	Dana Alokasi Umum	3	1	\N
207	4.2.2.01.	Dana Alokasi Umum	4	1	\N
208	4.2.2.01.01.	Dana Alokasi Umum	5	0	\N
209	4.2.3.	Dana Alokasi Khusus	3	1	\N
210	4.2.3.01.	Dana Alokasi Khusus	4	1	\N
211	4.2.3.01.01.	Dana Alokasi Khusus	5	0	\N
212	4.3.	LAIN-LAIN PENDAPATAN DAERAH YANG SAH	2	1	\N
213	4.3.1.	Pendapatan Hibah	3	1	\N
214	4.3.1.01.	Pendapatan Hibah dari Pemerintah	4	1	\N
215	4.3.1.01.01.	Pendapatan Hibah dari Pemerintah	5	0	\N
216	4.3.1.02.	Pendapatan Hibah dari Pemerintah Daerah lainya	4	1	\N
217	4.3.1.02.01.	Pemerintah Daerah dari Pemerintah Daerah lainya	5	0	\N
218	4.3.1.03.	Pendapatan Hibah dari Badan/Lembaga/Organisasi Swasta Dalam Negeri	4	1	\N
219	4.3.1.03.01.	Badan/Lembaga/Organisasi Swasta	5	0	\N
333	4.3.1.03.02.	Bantuan Pihak Ketiga	5	0	\N
249	4.3.1.03.02.01.	Bantuan PT.Jasa Raharja (Persero)	5	0	\N
250	4.3.1.03.02.02.	I P E P (Iuran Pembiayaan Ekspoitasi dan Pemeliharaan Prasarana Pengairan)	5	0	\N
220	4.3.1.04.	Pendapatan Hibah dari Kelompok Masyarakat/Perorangan	4	1	\N
221	4.3.1.04.01.	Kelompok Masyarakat/Perorangan	5	0	\N
222	4.3.1.05.	Pendapatan Hibah dari Luar Negeri	4	1	\N
223	4.3.1.05.01.	Pendapatan Hibah dari Bilateral	5	0	\N
224	4.3.1.05.02.	Pendapatan Hibah dari Multilateral	5	0	\N
225	4.3.1.05.03.	Pendapatan Hibah dari Donor Lainnya	5	0	\N
226	4.3.2.	Dana Darurat	3	1	\N
227	4.3.2.01.	Penanggulangan Korban/Kerusakan Akibat Bencana Alam	4	1	\N
228	4.3.2.01.01.	Korban/Kerusakan Akibat Bencana Alam	5	0	\N
229	4.3.3.	Dana Bagi Hasil Pajak dari Provinsi dan Pemerintah Daerah Lainnya	3	1	\N
230	4.3.3.01.	Dana Bagi Hasil Pajak dari Provinsi	4	1	\N
231	4.3.3.01.01.	Dana Bagi Hasil Pajak dari Provinsi	5	0	\N
232	4.3.3.02.	Dana Bagi Hasil Pajak dari Kabupaten	4	1	\N
233	4.3.3.02.01.	Dana Bagi Hasil Pajak dari Kabupaten	5	0	\N
234	4.3.3.03.	Dana Bagi Hasil Pajak dari Kota	4	1	\N
235	4.3.3.03.01.	Dana Bagi Hasil Pajak dari Kota	5	0	\N
236	4.3.4.	Dana Penyesuaian dan Otonomi Khusus	3	1	\N
237	4.3.4.01.	Dana Penyesuaian	4	1	\N
238	4.3.4.01.01.	Dana Penyesuaian	5	0	\N
239	4.3.4.02.	Dana Otonomi Khusus	4	1	\N
240	4.3.4.02.01.	Dana Otonomi Khusus	5	0	\N
241	4.3.5.	Bantuan Keuangan dari Provinsi/Pemerintah Daerah Lainnya	3	1	\N
242	4.3.5.01.	Bantuan Keuangan dari Provinsi	4	1	\N
243	4.3.5.01.01.	Bantuan Keuangan dari Provinsi	5	0	\N
244	4.3.5.02.	Bantuan Keuangan dari Kabupaten	4	1	\N
245	4.3.5.02.01.	Bantuan Keuangan dari Kabupaten	5	0	\N
246	4.3.5.03.	Bantuan Keuangan dari Kota	4	1	\N
247	4.3.5.03.01.	Bantuan Keuangan dari Kota	5	0	\N
251	4.3.6.	Lain-lain Penerimaan	3	1	\N
252	4.3.6.01.	Lain-lain Penerimaan	4	1	\N
261	4.3.6.01.01.	Lain-lain Penerimaan...	5	0	\N
\.


--
-- Name: rekenings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('rekenings_id_seq', 699, true);


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY resources (resource_id, resource_name, resource_type, parent_id, ordering, owner_user_id, owner_group_id) FROM stdin;
\.


--
-- Name: resources_resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('resources_resource_id_seq', 1, false);


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY routes (id, kode, nama, path, factory, perm_name, disabled, created, updated, create_uid) FROM stdin;
124	rekon-esamsat	Rekon e-Samsat	/rekon-esamsat	\N	read	0	2015-03-08 16:45:45	\N	1
125	rekon-esamsat-act	Baca Rekon e-Samsat	/rekon-esamsat/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
126	rekon-esamsat-edit	Edit Rekon e-Samsat	/rekon-esamsat/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
127	rekon-esamsat-delete	Hapus Rekon e-Samsat	/rekon-esamsat/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
128	rekon-epap	Rekon e-PAP	/rekon-epap	\N	read	0	2015-03-08 16:45:45	\N	1
129	rekon-epap-act	Baca Rekon e-PAP	/rekon-epap/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
130	rekon-epap-edit	Edit Rekon e-PAP	/rekon-epap/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
131	rekon-epap-delete	Hapus Rekon e-PAP	/rekon-epap/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
132	fast-pay	Pembayaran Cepat	/fast-pay	\N	read	0	2015-03-08 16:45:45	\N	1
133	fast-pay-act	Baca Pembayaran Cepat	/fast-pay/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
134	fast-pay-add	Tambah Pembayaran Cepat	/fast-pay/add	\N	add	0	2015-03-08 16:45:45	\N	1
135	fast-pay-edit	Edit Pembayaran Cepat	/fast-pay/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
136	fast-pay-delete	Hapus Pembayaran Cepat	/fast-pay/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
4	password	Ubah password	/password	\N	edit	0	2015-03-08 16:45:45	\N	1
1	home	Beranda	/	\N	''	0	2015-03-08 16:45:45	\N	1
2	login	Masuk	/login	\N	''	0	2015-03-08 16:45:45	\N	1
3	logout	Logout	/logout	\N	view	0	2015-03-08 16:45:45	\N	1
5	forbidden	Forbidden	/forbidden	\N	view	0	2015-03-08 16:45:45	\N	1
7	user	Users	/user	\N	view	0	2015-03-08 16:45:45	\N	1
8	user-act	Baca User 	/user/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
9	user-add	Tambah user	/user/add	\N	add	0	2015-03-08 16:45:45	\N	1
10	user-edit	Edit user	/user/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
11	user-delete	Hapus user	/user/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
12	group	Group	/group	\N	read	0	2015-03-08 16:45:45	\N	1
13	group-add	Tambah Group	/group/add	\N	add	0	2015-03-08 16:45:45	\N	1
14	group-act	Baca Group	/group/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
15	group-edit	Edit Group	/group/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
16	group-delete	Hapus Group	/group/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
17	pkb	List Pajak Kendaraan Bermotor	/pkb	\N	read	0	2015-03-08 16:45:45	\N	1
18	pkb-add	Pajak Kendaraan Bermotor	/pkb/add	\N	add	0	2015-03-08 16:45:45	\N	1
19	pap	List Pajak Air Permukaan	/pap	\N	read	0	2015-03-08 16:45:45	\N	1
20	pap-add	Pajak Air Permukaan	/pap/add	\N	add	0	2015-03-08 16:45:45	\N	1
26	rekening	Kode Rekening	/rekening	\N	read	0	2015-03-08 16:45:45	\N	1
27	rekening-act	Baca Kode Rekening	/rekening/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
28	rekening-add	Tambah Kode Rekening	/rekening/add	\N	add	0	2015-03-08 16:45:45	\N	1
29	rekening-edit	Edit Kode Rekening	/rekening/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
40	rekening-delete	Hapus Kode Rekening	/rekening/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
41	skpd	Unit Kerja/OPD	/skpd	\N	read	0	2015-03-08 16:45:45	\N	1
42	skpd-act	Baca Unit Kerja/OPD	/skpd/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
43	skpd-add	Tambah Unit Kerja/OPD	/skpd/add	\N	add	0	2015-03-08 16:45:45	\N	1
44	skpd-edit	Edit Unit Kerja/OPD	/skpd/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
45	skpd-delete	Hapus Unit Kerja/OPD	/skpd/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
46	jabatan	Jabatan	/jabatan	\N	read	0	2015-03-08 16:45:45	\N	1
47	jabatan-act	Baca Jabatan	/jabatan/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
48	jabatan-add	Tambah Jabatan	/jabatan/add	\N	add	0	2015-03-08 16:45:45	\N	1
49	jabatan-edit	Edit Jabatan	/jabatan/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
50	jabatan-delete	Hapus Jabatan	/jabatan/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
51	pegawai	Pegawai	/pegawai	\N	read	0	2015-03-08 16:45:45	\N	1
52	pegawai-act	Baca Pegawai	/pegawai/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
53	pegawai-add	Tambah Pegawai	/pegawai/add	\N	add	0	2015-03-08 16:45:45	\N	1
54	pegawai-edit	Edit Pegawai	/pegawai/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
55	pegawai-delete	Hapus Pegawai	/pegawai/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
56	pajak	Tarif	/pajak	\N	read	0	2015-03-08 16:45:45	\N	1
57	pajak-act	Baca Tarif	/pajak/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
58	pajak-add	Tambah Tarif	/pajak/add	\N	add	0	2015-03-08 16:45:45	\N	1
59	pajak-edit	Edit Tarif	/pajak/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
60	pajak-delete	Hapus Tarif	/pajak/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
61	wilayah	Wilayah	/wilayah	\N	read	0	2015-03-08 16:45:45	\N	1
62	wilayah-act	Baca Wilayah	/wilayah/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
63	wilayah-add	Tambah Wilayah	/wilayah/add	\N	add	0	2015-03-08 16:45:45	\N	1
64	wilayah-edit	Edit Wilayah	/wilayah/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
65	wp	Penyetor	/wp	\N	read	0	2015-03-08 16:45:45	\N	1
66	wp-act	Baca Penyetor	/wp/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
67	wp-add	Tambah Penyetor	/wp/add	\N	add	0	2015-03-08 16:45:45	\N	1
68	wp-edit	Edit Penyetor	/wp/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
69	wp-delete	Hapus Penyetor	/wp/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
70	op	Objek	/op	\N	read	0	2015-03-08 16:45:45	\N	1
71	op-act	Baca Objek	/op/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
72	op-add	Tambah Objek	/op/add	\N	add	0	2015-03-08 16:45:45	\N	1
73	op-edit	Edit Objek	/op/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
74	op-delete	Hapus Objek	/op/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
75	arinvoice	Reg. Bayar	/arinvoice	\N	read	0	2015-03-08 16:45:45	\N	1
76	arinvoice-act	Register Action	/arinvoice/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
77	arinvoice-add	Tambah Reg. Bayar	/arinvoice/add	\N	add	0	2015-03-08 16:45:45	\N	1
78	arinvoice-edit	Edit Reg. Bayar	/arinvoice/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
79	arinvoice-delete	Hapus Reg. Bayar	/arinvoice/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
80	arsspd	Penerimaan	/arsspd	\N	read	0	2015-03-08 16:45:45	\N	1
81	arsspd-act	Baca SSPD	/arsspd/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
82	arsspd-add	Tambah Penerimaan	/arsspd/add	\N	add	0	2015-03-08 16:45:45	\N	1
83	arsspd-edit	Edit Penerimaaan	/arsspd/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
84	arsspd-delete	Hapus Penerimaan	/arsspd/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
85	wilayah-delete	Hapus Wilayah	/wilayah/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
86	usergroup	User Group	/usergroup	\N	read	0	2015-03-08 16:45:45	\N	1
87	usergroup-act	User Group Action	/usergroup/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
88	usergroup-add	Tambah User Group	/usergroup/add	\N	add	0	2015-03-08 16:45:45	\N	1
89	usergroup-delete	Hapus User Group	/usergroup/{id}/{id2}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
90	groupperm	Group Permission	/groupperm	\N	read	0	2015-03-08 16:45:45	\N	1
91	groupperm-act	Group Permission Action	/groupperm/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
92	groupperm-add	Tambah Group Permission	/groupperm/add	\N	add	0	2015-03-08 16:45:45	\N	1
93	groupperm-delete	Hapus Group Permission	/groupperm/{id}/{id2}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
94	arsts	Setoran	/arsts	\N	read	0	2015-03-08 16:45:45	\N	1
95	arsts-act	Setoran Action	/arsts/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
96	arsts-add	Tambah Setoran	/arsts/add	\N	add	0	2015-03-08 16:45:45	\N	1
97	arsts-edit	Edit Setoran	/arsts/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
98	arsts-delete	Hapus Setoran	/arsts/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
99	arstsitem	Setoran Detail	/arstsitem	\N	read	0	2015-03-08 16:45:45	\N	1
100	arstsitem-act	Setoran Detail Action	/arstsitem/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
101	arstsitem-add	Tambah Setoran Detail	/arstsitem/{id}/add	\N	add	0	2015-03-08 16:45:45	\N	1
102	arstsitem-edit	Edit Setoran Detail	/arstsitem/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
103	arstsitem-delete	Hapus Setoran Detail	/arstsitem/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
104	arstsitem-list	Tambah Setoran Detail	/arstsitem/{id}/list	\N	add	0	2015-03-08 16:45:45	\N	1
105	reports_act	Report Action	/reports/act/{act}	\N	read	0	2015-03-08 16:45:45	\N	1
106	arinvoice-edt-unit	ARInvoice Ubah Unit	/arinvoice/edt/unit	\N	arinvoice_unit	0	2015-03-08 16:45:45	\N	1
107	arinvoice-edt-subjek	ARInvoice Ubah Subjek	/arinvoice/edt/subjek	\N	arinvoice_subjek	0	2015-03-08 16:45:45	\N	1
108	pkb-edit	Jawaban E-Samsat	/pkb/{nr}/{nk}/{em}/{nh}/{cd}/{ct}/add	\N	view	0	2015-03-08 16:45:45	\N	1
109	pap-edit	Jawaban E-PAP	/pap/{nr}/{nk}/{em}/add	\N	view	0	2015-03-08 16:45:45	\N	1
110	user-unit	User OPD	/user-unit	\N	read	0	2015-03-08 16:45:45	\N	1
111	user-unit-act	User OPD Act	/user-unit/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
112	user-unit-add	Tambah User OPD	/user-unit/add	\N	add	0	2015-03-08 16:45:45	\N	1
113	user-unit-delete	Hapus User OPD	/user-unit/{id}/{id2}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
114	arinvoiceb	Reg. Bayar Bendahara	/arinvoiceb	\N	read	0	2015-03-08 16:45:45	\N	1
115	arinvoiceb-act	Register Bendahara Action	/arinvoiceb/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
116	arinvoiceb-add	Tambah Reg. Bayar Bendahara	/arinvoiceb/add	\N	add	0	2015-03-08 16:45:45	\N	1
117	arinvoiceb-edit	Edit Reg. Bayar Bendahara	/arinvoiceb/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
118	arinvoicewp	Reg. Bayar WP	/arinvoicewp	\N	read	0	2015-03-08 16:45:45	\N	1
119	arinvoicewp-act	Register WP Action	/arinvoicewp/{act}/act	\N	read	0	2015-03-08 16:45:45	\N	1
120	arinvoicewp-add	Tambah Reg. Bayar WP	/arinvoicewp/add	\N	add	0	2015-03-08 16:45:45	\N	1
121	arinvoicewp-edit	Edit Reg. Bayar WP	/arinvoicewp/{id}/edit	\N	edit	0	2015-03-08 16:45:45	\N	1
122	arinvoiceb-delete	Hapus Reg. Bayar Bendahara	/arinvoiceb/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
123	arinvoicewp-delete	Hapus Reg. Bayar WP	/arinvoicewp/{id}/delete	\N	delete	0	2015-03-08 16:45:45	\N	1
\.


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('routes_id_seq', 136, true);


--
-- Data for Name: subjekpajaks; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY subjekpajaks (id, kode, nama, status, alamat_1, alamat_2, kelurahan, kecamatan, kota, user_id, provinsi, email, unit_id) FROM stdin;
5	0123456789123456	Pertamina	1	Jln Soekarno - Hatta	\N	\N	\N	\N	10	\N	pertamina@gmail.com	208
6	101	A	1	A	--	--	--	Bogor	1	Jawa Barat	\N	208
7	P-0001	PT. Sarana Mandiri	1	Jl. Ahmad Yani no.100, Kota Bandung	-	Cibeunying Kidul	Cikutra	Bandung	10	Jawa Barat	saranamandiri01@gmail.com	208
8	P-0002	PT. Harapan Makmur Sentosa	1	Jl. Jakarta No.105, Kota Bandung	-	Sukamulya	Arcamanik	Bandung	10	Jawa Barat	harapanmakmur01@gmail.com	208
9	P-0003	PT. Guna San Marino	1	Jl. Soekarno-hatta no.20, RT/RW 01/01	-	Panyileukan	Cibiru	Bandung	10	Jawa Barat	gunasan01@gmail.com	208
10	P-0004	PT. Shell 	1	Jl. Cijambe Kulon, Bandung 	-	Pasir Endah	Ujungberung	Bandung	10	Jawa Barat	shellcorp@yahoo.com	208
11	P-0005	PT. Petronas	1	Jl. Suci no.100 , RT 006 RW 007	-	Citarum	Bandung Wetan	Bandung	10	Jawa Barat	petronas@yahoo.com	208
12	P-0006	PT. Putra Manglayang	1	Jl. Nasution n0.21B, RT 001/RW 003	-	Pasir Endah	Ujungberung	Bandung	10	Jawa Barat	\N	208
\.


--
-- Name: subjekpajaks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('subjekpajaks_id_seq', 12, true);


--
-- Data for Name: unit_rekenings; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY unit_rekenings (id, unit_id, rekening_id) FROM stdin;
\.


--
-- Name: unit_rekenings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('unit_rekenings_id_seq', 1, false);


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY units (id, kode, nama, level_id, is_summary, parent_id) FROM stdin;
1	1.	URUSAN WAJIB	1	1	\N
2	1.01.	Pendidikan	2	1	\N
3	1.01.01.	DINAS PENDIDIKAN	3	1	\N
4	1.01.01.01.	Sekretariat	4	0	\N
5	1.01.01.02.	Bidang Pendidikan Dasar	4	0	\N
6	1.01.01.03.	Bidang Pendidikan Menengah dan Tinggi	4	0	\N
7	1.01.01.04.	Bidang Pendidikan Luar Biasa	4	0	\N
8	1.01.01.05.	Bidang Sarana dan Prasarana	4	0	\N
9	1.01.01.06.	Balai Pelatihan Pendidik dan Tenaga Kependidikan Pendidik Umum	4	0	\N
10	1.01.01.07.	Balai Pelatihan Pendidik dan Tenaga Kependidikan Pendidikan Kejuruan	4	0	\N
11	1.01.01.08.	Balai Pelatihan Pendidik dan Tenaga Kependidikan Pendidikan Luar Biasa	4	0	\N
12	1.01.01.09.	Balai Pengembangan Bahasa Daerah dan Kesenian	4	0	\N
13	1.02.	Kesehatan	2	1	\N
14	1.02.01.	DINAS KESEHATAN	3	1	\N
15	1.02.01.01.	Sekretariat	4	0	\N
16	1.02.01.02.	Bidang Regulasi dan Kebijakan Kesehatan	4	0	\N
17	1.02.01.03.	Bidang Bina Pelayanan Kesehatan	4	0	\N
18	1.02.01.04.	Bidang Bina Penyehatan Lingkungan dan Pencegahan Penyakit	4	0	\N
19	1.02.01.05.	Bidang Sumber Daya Kesehatan	4	0	\N
20	1.02.01.06.	Balai Laboratorium Kesehatan	4	0	\N
21	1.02.01.07.	Balai Pelatihan Tenaga Kesehatan Masyarakat	4	0	\N
22	1.02.01.08.	Balai Kesehatan Kerja Masyarakat	4	0	\N
23	1.02.01.09.	Balai Kesehatan Paru Masyarakat	4	0	\N
24	1.02.02.	RUMAH SAKIT JIWA	3	1	\N
25	1.02.02.01.	Bagian Sumber Daya Manusia dan Perencanaan	4	0	\N
26	1.02.02.02.	Bagian Keuangan dan Akuntansi	4	0	\N
27	1.02.02.03.	Bagian Umum	4	0	\N
28	1.02.02.04.	Bidang Pelayanan Medik	4	0	\N
29	1.02.02.05.	Bidang Pelayanan Perawatan	4	0	\N
30	1.02.02.06.	Bidang Pelayanan Penunjang	4	0	\N
31	1.02.03.	RUMAH SAKIT PARU	3	1	\N
32	1.02.03.01.	Subbagian Tata Usaha	4	0	\N
33	1.02.03.02.	Seksi Pelayanan Medis	4	0	\N
34	1.02.03.03.	Seksi Pelayanan Perawatan	4	0	\N
35	1.02.03.04.	Seksi Penunjang Medik	4	0	\N
36	1.02.04.	RUMAH SAKIT UMUM DAERAH AL-IHSAN	3	1	\N
37	1.02.04.01.	Bagian Umum dan Hukum	4	0	\N
38	1.02.04.02.	Bagian Sumber Daya Manusia	4	0	\N
39	1.02.04.03.	Bagian keuangan dan Akuntansi	4	0	\N
40	1.02.04.04.	Bidang Medik	4	0	\N
41	1.02.04.05.	Bidang Keperawatan	4	0	\N
42	1.02.04.06.	Bidang Penunjang Medik	4	0	\N
43	1.03.	Pekerjaan Umum	2	1	\N
44	1.03.01.	DINAS BINA MARGA	3	1	\N
45	1.03.01.01.	Sekretariat	4	0	\N
46	1.03.01.02.	Bidang Teknik	4	0	\N
47	1.03.01.03.	Bidang Pembangunan	4	0	\N
48	1.03.01.04.	Bidang Pemeliharaan dan Penanganan Bencana Alam	4	0	\N
49	1.03.01.05.	Bidang Pengawasan Pemanfaatan	4	0	\N
50	1.03.01.06.	Balai Pengelolaan Jalan Wilayah Pelayanan I	4	0	\N
51	1.03.01.07.	Balai Pengelolaan Jalan Wilayah Pelayanan II	4	0	\N
52	1.03.01.08.	Balai Pengelolaan Jalan Wilayah Pelayanan III	4	0	\N
53	1.03.01.09.	Balai Pengelolaan Jalan Wilayah Pelayanan IV	4	0	\N
54	1.03.01.10.	Balai Pengelolaan Jalan Wilayah Pelayanan V	4	0	\N
55	1.03.01.11.	Balai Pengelolaan Jalan Wilayah Pelayanan VI	4	0	\N
56	1.03.02.	Dinas Pengelolaan Sumber Daya Air	3	1	\N
57	1.03.02.01.	Sekretariat	4	0	\N
58	1.03.02.02.	Bidang Rekayasa Teknik	4	0	\N
59	1.03.02.03.	Bidang Konstruksi	4	0	\N
60	1.03.02.04.	Bidang Operasi dan Program	4	0	\N
61	1.03.02.05.	Bidang Bina Manfaat	4	0	\N
62	1.03.02.06.	Balai Pendayagunaan Sumber Daya Air Wilayah Sungai Ciliwung-Cisadane	4	0	\N
63	1.03.02.07.	Balai Pendayagunaan Sumber Daya Air Wilayah Sungai Cisadea-Cibareno	4	0	\N
64	1.03.02.08.	Balai Pendayagunaan Sumber Daya Air Wilayah Sungai Citarum	4	0	\N
65	1.03.02.09.	Balai Pendayagunaan Sumber Daya Air Wilayah Sungai Cimanuk-Cisanggarung	4	0	\N
66	1.03.02.10.	Balai Pendayagunaan Sumber Daya Air Wilayah Sungai Citanduy	4	0	\N
67	1.03.02.11.	Balai Pendayagunaan Sumber Daya Air Wilayah Sungai Ciwulan-Cilaki	4	0	\N
68	1.03.02.12.	Balai Data dan Informasi Sumber Daya Air	4	0	\N
69	1.04.	Perumahan	2	1	\N
70	1.05.	Penataan Ruang	2	1	\N
71	1.05.01.	Dinas Permukiman dan Perumahan	3	1	\N
72	1.05.01.01.	Sekretariat	4	0	\N
73	1.05.01.02.	Bidang Tata Ruang Kawasan	4	0	\N
74	1.05.01.03.	Bidang Permukiman	4	0	\N
75	1.05.01.04.	Bidang Perumahan	4	0	\N
76	1.05.01.05.	Bidang Jasa Konstruksi	4	0	\N
77	1.05.01.06.	Balai Pengujian Mutu Konstruksi dan Lingkungan	4	0	\N
78	1.05.01.07.	Balai Pengelolaan Sampah Regional Jawa Barat	4	0	\N
466	1.05.01.08.	Balai Pengelolaan dan Pelayanan Perumahan Jawa Barat	4	0	\N
79	1.06.	Perencanaan Pembangunan	2	1	\N
80	1.06.01.	Badan Perencanaan Pembangunan Daerah	3	1	\N
81	1.06.01.01.	Sekretariat	4	0	\N
82	1.06.01.02.	Bidang Penelitian, Pengendalian dan Evaluasi	4	0	\N
83	1.06.01.03.	Bidang Fisik	4	0	\N
84	1.06.01.04.	Bidang Ekonomi	4	0	\N
85	1.06.01.05.	Bidang Sosial dan Budaya	4	0	\N
86	1.06.01.06.	Bidang Pemerintahan	4	0	\N
87	1.06.01.07.	Bidang Pendanaan Pembangunan	4	0	\N
88	1.06.01.08.	Balai Pusat Data dan Analisa Pembangunan Jawa Barat	4	0	\N
89	1.07.	Perhubungan	2	1	\N
90	1.07.01.	Dinas Perhubungan	3	1	\N
91	1.07.01.01.	Sekretariat	4	0	\N
92	1.07.01.02.	Bidang Transportasi Darat	4	0	\N
93	1.07.01.03.	Bidang Transportasi Laut dan Angkutan Sungai, Danau dan Penyebrangan (ASDP)	4	0	\N
94	1.07.01.04.	Bidang Transportasi Udara	4	0	\N
95	1.07.01.05.	Bidang Bina Sistem Operasional Transportasi	4	0	\N
96	1.07.01.06.	Balai Pengelolaan Pelabuhan Laut, Angkutan Sungai, Danau dan Penyebrangan (ASDP)	4	0	\N
97	1.07.01.07.	Balai Pengelolaan Bandar Udara	4	0	\N
98	1.07.01.08.	UPTD Lalu Lintas dan Angkutan Jalan Wilayah I	4	0	\N
99	1.07.01.09.	UPTD Lalu Lintas dan Angkutan Jalan Wilayah II	4	0	\N
100	1.08.	Lingkungan Hidup	2	1	\N
101	1.08.01.	Badan Pengelolaan Lingkungan Hidup Daerah	3	1	\N
102	1.08.01.01.	Sekretariat	4	0	\N
103	1.08.01.02.	Bidang Tata Kelola Lingkungan	4	0	\N
104	1.08.01.03.	Bidang Pengendalian Pencemaran Lingkungan	4	0	\N
105	1.08.01.04.	Bidang Konservasi SDA dan Mitigasi Bencana	4	0	\N
106	1.08.01.05.	Bidang Penataan Hukum, Kemitraan dan Pengembangan Kapasitas Lingkungan	4	0	\N
107	1.09.	Pertanahan	2	1	\N
108	1.10.	Kependudukan dan Catatan Sipil	2	1	\N
109	1.11.	Pemberdayaan Perempuan dan Perlindungan Anak	2	1	\N
110	1.11.01.	Badan Pemberdayaan Perempuan Perlindungan Anak dan KB  	3	1	\N
111	1.11.01.01.	Sekretariat	4	0	\N
112	1.11.01.02.	Bidang Peningkatan Kualitas Hidup dan Perlindungan Perempuan	4	0	\N
113	1.11.01.03.	Bidang Pengarusutamaan Gender dan Kerjasama	4	0	\N
114	1.11.01.04.	Bidang Kesejahteraan dan Perlindungan Anak	4	0	\N
115	1.11.01.05.	Bidang Keluarga Berencana dan Kesejahteraan Keluarga	4	0	\N
116	1.12.	Keluarga Berencana dan Keluarga Sejahtera	2	1	\N
117	1.13.	Sosial	2	1	\N
118	1.13.01.	Dinas Sosial	3	1	\N
119	1.13.01.01.	Sekretariat	4	0	\N
120	1.13.01.02.	Bidang Pembinaan Sosial	4	0	\N
121	1.13.01.03.	Bidang Pelayanan dan Rehabilitasi Sosial	4	0	\N
122	1.13.01.04.	Bidang Pemberdayaan Sosial	4	0	\N
123	1.13.01.05.	Bidang Bantuan dan Perlindungan Sosial	4	0	\N
124	1.13.01.06.	Balai Perlindungan Sosial Tresna Werdha Ciparay - Bandung dan Pemeliharaan Taman Makam Pahlawan	4	0	\N
125	1.13.01.07.	Balai Perlindungan Sosial Asuhan Anak Pagaden-Subang	4	0	\N
126	1.13.01.08.	Balai Pemulihan Sosial Pamardi Putra Lembang-Bandung Barat	4	0	\N
127	1.13.01.09.	Balai Rehabilitasi Sosial Karya Wanita Palimanan-Cirebon	4	0	\N
128	1.13.01.10.	Balai Rehabilitasi Sosial Bina Karya Cisarua-Bandung Barat	4	0	\N
129	1.13.01.11.	Balai Rehabilitasi Sosial Penyandang Cacat Cibabat-Cimahi	4	0	\N
130	1.13.01.12.	Balai Pelatihan Pekerja Sosial Cibabat-Cimahi	4	0	\N
131	1.13.01.13.	Balai Rehabilitasi Sosial Marsudi Putra Cileungsi-Bogor	4	0	\N
132	1.13.01.14.	Balai Pemberdayaan Sosial Bina Remaja Cibabat-Cimahi	4	0	\N
133	1.14.	Ketenagakerjaan	2	1	\N
134	1.14.01.	Dinas Tenaga Kerja dan Transmigrasi	3	1	\N
135	1.14.01.01.	Sekretariat	4	0	\N
136	1.14.01.02.	Bidang Pelatihan dan Produktivitas Tenaga Kerja	4	0	\N
137	1.14.01.03.	Bidang Penempatan Tenaga Kerja	4	0	\N
138	1.14.01.04.	Bidang Perlindungan Ketenagakerjaan	4	0	\N
139	1.14.01.05.	Bidang Transmigrasi	4	0	\N
140	1.14.01.06.	Balai Pelatihan Ketenagakerjaan Bekasi	4	0	\N
141	1.14.01.07.	Balai Latihan Tenaga Kerja Luar Negeri	4	0	\N
142	1.14.01.08.	Balai Pelatihan Ketransmigrasian	4	0	\N
454	1.14.01.09.	Balai Pelayanan Tenaga Kerja Indonesia Terpadu Provinsi Jawa Barat	4	0	\N
143	1.15.	Koperasi dan Usaha Kecil Menengah	2	1	\N
144	1.15.01.	Dinas Koperasi dan Usaha Mikro, Kecil dan Menengah	3	1	\N
145	1.15.01.01.	Sekretariat	4	0	\N
146	1.15.01.02.	Bidang Koperasi	4	0	\N
147	1.15.01.03.	Bidang Kemitraan dan Pengembangan Produk Usaha Mikro, Kecil dan Menengah (UMKM)	4	0	\N
148	1.15.01.04.	Bidang Pembiayaan dan Teknologi	4	0	\N
149	1.15.01.05.	Bidang Pengawasan	4	0	\N
150	1.15.01.06.	Balai Pelatihan Tenaga Koperasi dan Usaha Mikro, Kecil dan Menengah	4	0	\N
151	1.16.	Penanaman Modal	2	1	\N
152	1.16.01.	BADAN KOORDINASI PROMOSI DAN PENANAMAN MODAL DAERAH	3	1	\N
153	1.16.01.01.	Sekretariat	4	0	\N
154	1.16.01.02.	Bidang Pengendalian	4	0	\N
155	1.16.01.03.	Bidang Promosi	4	0	\N
156	1.16.01.04.	Bidang Pelayanan Fasilitas Investasi	4	0	\N
157	1.16.01.05.	Bidang Pengembangan Investasi	4	0	\N
520	1.16.02.	Badan Penanaman Modal dan Perijinan Terpadu	3	1	\N
481	1.16.02.01.	Sekretariat	4	0	\N
158	1.17.	Kebudayaan	2	1	\N
159	1.17.01.	Dinas Pariwisata dan Kebudayaan	3	1	\N
160	1.17.01.01.	Sekretariat	4	0	\N
161	1.17.01.02.	Bidang Kepariwisataan	4	0	\N
162	1.17.01.03.	Bidang Kebudayaan	4	0	\N
163	1.17.01.04.	Bidang Kesenian dan Perfilman	4	0	\N
164	1.17.01.05.	Bidang Pemasaran	4	0	\N
165	1.17.01.06.	Balai Pengelolaan Museum Negeri Sribaduga	4	0	\N
166	1.17.01.07.	Balai Pengelolaan Taman Budaya	4	0	\N
167	1.17.01.08.	Balai Pengelolaan Kepurbakalaan, Sejarah dan Nilai tradisional	4	0	\N
168	1.17.01.09.	Balai Pengembangan Kemitraan, Pelatihan Tenaga Kepariwisataan dan Kebudayaan	4	0	\N
169	1.17.01.10.	Balai Pengelolaan Anjungan Jawa Barat Taman Mini Indonesia Indah	4	0	\N
170	1.18.	Kepemudaan dan Olah Raga	2	1	\N
171	1.18.01.	Dinas Olah Raga dan Pemuda	3	1	\N
172	1.18.01.01.	Sekretariat	4	0	\N
173	1.18.01.02.	Bidang Keolahragaan	4	0	\N
174	1.18.01.03.	Bidang Kepemudaan	4	0	\N
175	1.18.01.04.	Bidang Kemitraan, Prasarana dan Sarana	4	0	\N
176	1.19.	Kesatuan Bangsa dan Politik Dalam Negeri	2	1	\N
177	1.19.01.	Badan Kesatuan Bangsa dan Politik	3	1	\N
178	1.19.01.01.	Sekretariat	4	0	\N
179	1.19.01.02.	Bidang Politik Dalam Negeri	4	0	\N
180	1.19.01.03.	Bidang Ideologi Dan Wawasan Kebangsaan	4	0	\N
181	1.19.01.04.	Bidang Kewaspadaan Daerah	4	0	\N
182	1.19.01.05.	Bidang Ketahanan Ekonomi, Seni Budaya, Agama Dan Kemasyarakatan	4	0	\N
183	1.20.	Otonomi Daerah, Pemerintahan Umum, Administrasi Keuangan Daerah, Perangkat Daerah, Kepegawaian, dan Persandian	2	1	\N
445	1.20.00.	P P K D	3	1	\N
184	1.20.01.	Dewan Perwakilan Rakyat Daerah	3	1	\N
443	1.20.01.01.	Dewan Perwakilan Rakyat Daerah	4	0	\N
185	1.20.02.	Kepala Daerah & Wakil Kepala Daerah	3	1	\N
186	1.20.02.01.	Kepala Daerah	4	0	\N
187	1.20.02.02.	Wakil Kepala Daerah	4	0	\N
188	1.20.03.	Sekretariat Daerah	3	1	\N
189	1.20.03.01.	Biro Pemerintahan Umum	4	0	\N
190	1.20.03.02.	Biro Otonomi Daerah dan Kerjasama	4	0	\N
191	1.20.03.03.	Biro Hukum dan HAM	4	0	\N
192	1.20.03.04.	Biro Administrasi Perekonomian	4	0	\N
193	1.20.03.05.	Biro Bina Produksi	4	0	\N
194	1.20.03.06.	Biro Administrasi Pembangunan	4	0	\N
195	1.20.03.07.	Biro Pelayanan Sosial Dasar	4	0	\N
196	1.20.03.08.	Biro Pengembangan Sosial	4	0	\N
197	1.20.03.09.	Biro Organisasi	4	0	\N
198	1.20.03.10.	Biro Keuangan	4	0	\N
199	1.20.03.11.	Biro Pengelolaan Barang Daerah	4	0	\N
200	1.20.03.12.	Biro Humas Protokol dan Umum	4	0	\N
888	1.20.03.13.	Biro Perekonomian	4	0	\N
889	1.20.03.14.	Biro Investasi dan BUMD	4	0	\N
201	1.20.04.	Sekretariat  DPRD	3	1	\N
202	1.20.04.01.	Sekretariat	4	0	\N
203	1.20.04.02.	Bagian Persidangan	4	0	\N
204	1.20.04.03.	Bagian Perundang-undangan	4	0	\N
205	1.20.04.04.	Bagian Humas dan Protokol	4	0	\N
206	1.20.04.05.	Bagian Umum dan Administrasi	4	0	\N
207	1.20.04.06.	Bagian Keuangan	4	0	\N
208	1.20.05.	Dinas Pendapatan Daerah	3	1	\N
209	1.20.05.01.	Sekretariat	4	0	\N
210	1.20.05.02.	Bidang Perencanaan dan Pengembangan	4	0	\N
211	1.20.05.03.	Bidang Pajak	4	0	\N
212	1.20.05.04.	Bidang Non Pajak	4	0	\N
213	1.20.05.05.	Bidang Pengendalian dan Pembinaan	4	0	\N
214	1.20.05.06.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Depok I	4	0	\N
215	1.20.05.07.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Depok II Cinere	4	0	\N
216	1.20.05.08.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Bogor	4	0	\N
217	1.20.05.09.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Bogor	4	0	\N
218	1.20.05.10.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Sukabumi	4	0	\N
219	1.20.05.11.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Sukabumi I Cibadak	4	0	\N
220	1.20.05.12.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Sukabumi II Pelabuhan Ratu	4	0	\N
221	1.20.05.13.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Cianjur	4	0	\N
222	1.20.05.14.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Bekasi	4	0	\N
223	1.20.05.15.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Bekasi	4	0	\N
224	1.20.05.16.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Karawang	4	0	\N
225	1.20.05.17.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Purwakarta	4	0	\N
226	1.20.05.18.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Subang	4	0	\N
227	1.20.05.19.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Cirebon	4	0	\N
228	1.20.05.20.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Cirebon I Sumber	4	0	\N
229	1.20.05.21.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Cirebon II Ciledug	4	0	\N
230	1.20.05.22.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Indramayu I	4	0	\N
231	1.20.05.23.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Indramayu II Haurgeulis	4	0	\N
232	1.20.05.24.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Kuningan	4	0	\N
233	1.20.05.25.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Majalengka	4	0	\N
234	1.20.05.26.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Bandung I Pajajaran	4	0	\N
235	1.20.05.27.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Bandung II Kawaluyaan	4	0	\N
236	1.20.05.28.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Bandung III Soekarno Hatta	4	0	\N
237	1.20.05.29.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Bandung Barat	4	0	\N
238	1.20.05.30.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Bandung I Rancaekek	4	0	\N
239	1.20.05.31.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Bandung II Soreang	4	0	\N
240	1.20.05.32.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Sumedang	4	0	\N
241	1.20.05.33.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Garut	4	0	\N
242	1.20.05.34.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Tasikmalaya	4	0	\N
243	1.20.05.35.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Tasikmalaya	4	0	\N
244	1.20.05.36.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Ciamis I	4	0	\N
245	1.20.05.37.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kabupaten Ciamis II Pangandaran	4	0	\N
246	1.20.05.38.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Cimahi	4	0	\N
455	1.20.05.39.	Cabang Pelayanan Dinas Pendapatan Daerah Provinsi Wilayah Kota Banjar	4	0	\N
468	1.20.05.40.	Pusat Pengelolaan Informasi Dan Aplikasi Pendapatan	4	0	\N
247	1.20.06.	Inspektorat	3	1	\N
248	1.20.06.01.	Sekretariat	4	0	\N
249	1.20.06.02.	Inspektur Pembantu Wilayah I	4	0	\N
250	1.20.06.03.	Inspektur Pembantu Wilayah II	4	0	\N
251	1.20.06.04.	Inspektur Pembantu Wilayah III	4	0	\N
252	1.20.06.05.	Inspektur Pembantu Wilayah IV	4	0	\N
253	1.20.07.	Badan Koordinasi Pemerintahan dan Pembangunan Wilayah I	3	1	\N
254	1.20.07.01.	Sekretariat	4	0	\N
255	1.20.07.02.	Bidang Pemerintahan	4	0	\N
256	1.20.07.03.	Bidang Perekonomian	4	0	\N
257	1.20.07.04.	Bidang Pembangunan Daerah	4	0	\N
258	1.20.07.05.	Bidang Kesejahteraan Sosial	4	0	\N
259	1.20.08.	Badan Koordinasi Pemerintahan dan Pembangunan Wilayah II	3	1	\N
260	1.20.08.01.	Sekretariat	4	0	\N
261	1.20.08.02.	Bidang Pemerintahan	4	0	\N
262	1.20.08.03.	Bidang Perekonomian	4	0	\N
263	1.20.08.04.	Bidang Pembangunan Daerah	4	0	\N
264	1.20.08.05.	Bidang Kesejahteraan Sosial	4	0	\N
265	1.20.09.	Badan Koordinasi Pemerintahan dan Pembangunan Wilayah III	3	1	\N
266	1.20.09.01.	Sekretariat	4	0	\N
267	1.20.09.02.	Bidang Pemerintahan	4	0	\N
268	1.20.09.03.	Bidang Perekonomian	4	0	\N
269	1.20.09.04.	Bidang Pembangunan Daerah	4	0	\N
270	1.20.09.05.	Bidang Kesejahteraan Sosial	4	0	\N
271	1.20.10.	Badan Koordinasi Pemerintahan dan Pembangunan Wilayah IV	3	1	\N
272	1.20.10.01.	Sekretariat	4	0	\N
273	1.20.10.02.	Bidang Pemerintahan	4	0	\N
274	1.20.10.03.	Bidang Perekonomian	4	0	\N
275	1.20.10.04.	Bidang Pembangunan Daerah	4	0	\N
276	1.20.10.05.	Bidang Kesejahteraan Sosial	4	0	\N
277	1.20.11.	Badan Kepegawaian Daerah	3	1	\N
278	1.20.11.01.	Sekretariat	4	0	\N
279	1.20.11.02.	Bidang Pengadaan dan Informasi Kepegawaian	4	0	\N
280	1.20.11.03.	Bidang Mutasi dan Administrasi Kepegawaian	4	0	\N
281	1.20.11.04.	Bidang Pengembangan Karir	4	0	\N
282	1.20.11.05.	Bidang Kesejahteraan dan Disiplin	4	0	\N
283	1.20.12.	Badan Pendidikan dan Pelatihan Daerah	3	1	\N
284	1.20.12.01.	Sekretariat	4	0	\N
285	1.20.12.02.	Bidang Pengembangan Pendidikan dan Pelatihan	4	0	\N
286	1.20.12.03.	Bidang Pendidikan dan Pelatihan Kepemimpinan dan Fungsional	4	0	\N
287	1.20.12.04.	Bidang Pendidikan dan Pelatihan Teknis	4	0	\N
288	1.20.13.	Kantor Perwakilan Pemerintahan	3	1	\N
289	1.20.13.01.	Tata Usaha	4	0	\N
290	1.20.14.	Badan Pelayanan Perijinan Terpadu	3	1	\N
291	1.20.14.01.	Sekretaris	4	0	\N
292	1.20.14.02.	Bagian Tata Usaha	4	0	\N
293	1.20.14.03.	Bidang Administrasi	4	0	\N
294	1.20.14.04.	Bidang Pelayanan	4	0	\N
295	1.20.14.05.	Bidang Monitoring, Evaluasi dan Pengaduan	4	0	\N
296	1.20.15.	Sekretariat Komisi Penyiaran Indonesia Daerah	3	1	\N
297	1.20.15.01.	Sekretariat	4	0	\N
298	1.20.15.02.	Subbagian Tata Usaha	4	0	\N
299	1.20.15.03.	Subbagian Standardisasi	4	0	\N
300	1.20.15.04.	Subbagian Pembinaan dan Pengawasan	4	0	\N
301	1.20.15.05.	Subbagian Komunikasi	4	0	\N
308	1.20.17.	Badan Penanggulangan Bencana Daerah	3	1	\N
444	1.20.17.01.	Sekretariat	4	0	\N
450	1.20.17.02.	Bidang Pencegahan dan Kesiapsiagaan	4	0	\N
451	1.20.17.03.	Bidang Kedaruratan dan Logistik	4	0	\N
452	1.20.17.04.	Bidang Rehabilitasi dan Rekonstruksi	4	0	\N
309	1.20.18.	Satuan Polisi Pamong Praja	3	1	\N
310	1.20.18.01.	Bagian Tata Usaha	4	0	\N
311	1.20.18.02.	Bidang Bina Program dan Pengembangan	4	0	\N
312	1.20.18.03.	Bidang Pemeliharaan Ketertiban Umum dan Pengamanan Aset	4	0	\N
313	1.20.18.04.	Bidang Pembinaan	4	0	\N
314	1.20.18.05.	Bidang Penegakan Peraturan Daerah	4	0	\N
456	1.20.19.	Sekretariat DP KORPRI	3	1	\N
477	1.20.19.01.	Sekrteriat	4	0	\N
457	1.20.19.02.	Bagian Umum dan Kerjasama	4	0	\N
458	1.20.19.03.	Bagian Olah raga, Seni, Budaya, Mental dan Rohani	4	0	\N
459	1.20.19.04.	Bagian Usaha dan Bantuan Sosial	4	0	\N
510	1.20.20.	Badan Penelitian, Pengembangan dan Penerapan IPTEK	3	1	\N
483	1.20.20.01.	Sekretariat	4	0	\N
315	1.21.	Ketahanan Pangan	2	1	\N
316	1.21.01.	Badan Ketahanan Pangan Daerah	3	1	\N
317	1.21.01.01.	Sekretariat	4	0	\N
318	1.21.01.02.	Bidang Kelembagaan dan Infrastruktur	4	0	\N
319	1.21.01.03.	Bidang Ketersediaan dan Kerawanan Pangan	4	0	\N
320	1.21.01.04.	Bidang Konsumsi Keamanan Pangan	4	0	\N
321	1.21.01.05.	Bidang Distribusi dan Harga Pangan	4	0	\N
322	1.22.	Pemberdayaan Masyarakat dan Desa	2	1	\N
323	1.22.01.	Badan Pemberdayaan Masyarakat dan Pemerintahan Desa	3	1	\N
324	1.22.01.01.	Sekretariat	4	0	\N
325	1.22.01.02.	Bidang Pemerintahan Desa/Kelurahan	4	0	\N
326	1.22.01.03.	Bidang Penguatan Kelembagaan dan Partisipasi	4	0	\N
327	1.22.01.04.	Bidang Pemberdayaan Ekonomi Masyarakat	4	0	\N
328	1.22.01.05.	Bidang Sumber Daya Alam dan Teknologi Tepat Guna	4	0	\N
329	1.23.	Statistik	2	1	\N
330	1.24.	Kearsipan	2	1	\N
331	1.25.	Komunikasi dan Informatika	2	1	\N
332	1.25.01.	Dinas Komunikasi dan Informatika	3	1	\N
333	1.25.01.01.	Sekretariat	4	0	\N
334	1.25.01.02.	Bidang Pos danTelekomunikas	4	0	\N
335	1.25.01.03.	Bidang Sarana Komunikasi dan Diseminasi Informasi	4	0	\N
336	1.25.01.04.	Bidang Telematika	4	0	\N
337	1.25.01.05.	Bidang Pengolahan Data Elektronik	4	0	\N
338	1.25.01.06.	Balai Layanan Pengadaan Secara Elektronik	4	0	\N
339	1.26.	Perpustakaan	2	1	\N
340	1.26.01.	Badan Perpustakaan dan Kearsipan Daerah	3	1	\N
341	1.26.01.01.	Sekretariat	4	0	\N
342	1.26.01.02.	Bidang Deposit dan Pengolahan Bahan Perpustakaan	4	0	\N
343	1.26.01.03.	Bidang Pembinaan Perpustakaan dan Pengembangan Budidaya Baca	4	0	\N
344	1.26.01.04.	Bidang Layanan Otomasi Perpustakaan dan Kearsipan	4	0	\N
345	1.26.01.05.	Bidang Layanan dan Otomatis Kearsipan	4	0	\N
346	1.26.01.06.	Bidang Pembinaan dan Pengembangan	4	0	\N
347	1.26.01.07.	Bidang Pengelolaan Kearsipan	4	0	\N
348	1.26.01.08.	Bidang Akuisisi dan Pelestarian	4	0	\N
349	2.	URUSAN PILIHAN	1	1	\N
350	2.01.	Pertanian	2	1	\N
351	2.01.01.	Dinas Pertanian Tanaman Pangan	3	1	\N
352	2.01.01.01.	Sekretariat	4	0	\N
353	2.01.01.02.	Bidang Sumber Daya	4	0	\N
354	2.01.01.03.	Bidang Produksi Tanaman Pangan	4	0	\N
355	2.01.01.04.	Bidang Produksi Tanaman Hortikultura	4	0	\N
356	2.01.01.05.	Bidang Bina usaha	4	0	\N
357	2.01.01.06.	Balai Pengembangan Benih Padi	4	0	\N
358	2.01.01.07.	Balai Pengembangan Benih Palawija	4	0	\N
359	2.01.01.08.	Balai Pengembangan Benih Kentang	4	0	\N
360	2.01.01.09.	Balai Pengembangan Benih Holtikulktura dan Aneka Tanaman	4	0	\N
361	2.01.01.10.	Balai Pengembangan Teknologi Mekanisasi Pertanian Tanaman Pangan	4	0	\N
362	2.01.01.11.	Balai Pengawasan dan Sertifikasi Benih Tanaman Pangan dan Holtikultura	4	0	\N
363	2.01.01.12.	Balai Proteksi Tanaman Pangan dan Holtikultura	4	0	\N
364	2.01.01.13.	Balai Pelatihan Pertanian	4	0	\N
365	2.01.02.	Dinas Perkebunan	3	1	\N
366	2.01.02.01.	Sekretariat	4	0	\N
367	2.01.02.02.	Bidang Produksi Perkebunan	4	0	\N
368	2.01.02.03.	Bidang Pengembangan SDM, Kelembagaan dan Permodalan	4	0	\N
369	2.01.02.04.	Bidang Pengembangan dan Pengendalian Perkebunan	4	0	\N
370	2.01.02.05.	Bidang Pengolahan, Pemasaran dan Usaha Perkebunan	4	0	\N
371	2.01.02.06.	Balai Proteksi Tanaman Perkebunan	4	0	\N
372	2.01.02.07.	Balai Pengembangan Benih Tanaman Perkebunan	4	0	\N
373	2.01.02.08.	Balai Pengawasan dan Pengujian Mutu Benih Tanaman Perkebunan	4	0	\N
374	2.01.03.	Dinas Peternakan	3	1	\N
375	2.01.03.01.	Sekretariat	4	0	\N
376	2.01.03.02.	Bidang Prasarana dan Sarana	4	0	\N
377	2.01.03.03.	Bidang Produksi	4	0	\N
378	2.01.03.04.	Bidang Kesehatan Hewan dan Kesehatan Masyarakat Veteriner	4	0	\N
379	2.01.03.05.	Bidang Pengembangan Usaha	4	0	\N
380	2.01.03.06.	Balai Pengembangan Perbibitan Ternak Unggas	4	0	\N
381	2.01.03.07.	Balai Pengembangan Perbibitan Ternak Sapi Potong	4	0	\N
474	2.01.03.08.	Balai Pengembangan Pembibitan Ternak Domba Margawati	4	0	\N
383	2.01.03.09.	Balai Penyidikan Penyakit Hewan dan Kesehatan Masyarakat Veteriner Cikole Lembang	4	0	\N
384	2.01.03.10.	Balai Pengujian Mutu Pakan Ternak Cikole Lembang	4	0	\N
385	2.01.03.11.	Balai Pelatihan Peternakan Cikole Lembang	4	0	\N
386	2.01.03.12.	Balai Perbibitan dan Pengembangan Inseminasi Buatan Ternak Sapi Perah BuniKasih	4	0	\N
387	2.01.03.13.	Balai Pengembangan Perbibitan Ternak Sapi Perah dan Hijauan Makanan Ternak  Cikole Lembang	4	0	\N
501	2.01.04.	Sekretariat Badan Koordinasi Penyuluhan Pertanian, Perikanan, dan Kehutanan	3	1	\N
470	2.01.04.01.	Bagian Tata Usaha	4	0	\N
478	2.01.04.02.	Bidang Pertanian	4	0	\N
479	2.01.04.03.	Bidang Perikanan	4	0	\N
480	2.01.04.04.	Bidang Kehutanan	4	0	\N
388	2.02.	Kehutanan	2	1	\N
389	2.02.01.	Dinas Kehutanan	3	1	\N
390	2.02.01.01.	Sekretariat	4	0	\N
391	2.02.01.02.	Bidang Planologi	4	0	\N
392	2.02.01.03.	Bidang Bina Konservasi	4	0	\N
393	2.02.01.04.	Bidang Bina Rehabilitasi Hutan dan Lahan	4	0	\N
394	2.02.01.05.	Bidang Bina Produksi dan Usaha Kehutanan	4	0	\N
395	2.02.01.06.	Balai Pengawasan dan Pengendalian Hasil Hutan	4	0	\N
396	2.02.01.07.	Balai Pengelolaan Taman Hutan Raya Ir. H. Djuanda	4	0	\N
397	2.02.01.08.	Balai Rehabilitasi Lahan dan Konservasi Tanah	4	0	\N
398	2.03.	Energi dan Sumberdaya Mineral	2	1	\N
399	2.03.01.	Dinas Energi dan Sumber Daya Mineral	3	1	\N
400	2.03.01.01.	Sekretariat	4	0	\N
401	2.03.01.02.	Bidang Listrik dan Pemanfaatan Energi	4	0	\N
402	2.03.01.03.	Bidang Mineral, Geologi dan Air Tanah	4	0	\N
403	2.03.01.04.	Bidang Panas Bumi dan Migas	4	0	\N
404	2.03.01.05.	Bidang Bina Usaha dan Kerjasama	4	0	\N
405	2.03.01.06.	UPTD Energi dan Sumber Daya Mineral Wilayah Pelayanan I  Cianjur	4	0	\N
406	2.03.01.07.	UPTD Energi dan Sumber Daya Mineral Wilayah Pelayanan II  Purwakarta	4	0	\N
407	2.03.01.08.	UPTD Energi dan Sumber Daya Mineral Wilayah Pelayanan III Bandung	4	0	\N
408	2.03.01.09.	UPTD Energi dan Sumber Daya Mineral Wilayah Pelayanan IV Tasikmalaya	4	0	\N
409	2.03.01.10.	UPTD Energi dan Sumber Daya Mineral Wilayah Pelayanan V Cirebon	4	0	\N
410	2.03.01.11.	Balai Pengujian Energi dan Sumber Daya Mineral	4	0	\N
411	2.04.	Pariwisata	2	1	\N
412	2.05.	Kelautan dan Perikanan	2	1	\N
413	2.05.01.	Dinas Perikanan dan Kelautan	3	1	\N
414	2.05.01.01.	Sekretariat	4	0	\N
415	2.05.01.02.	Bidang Perikanan Budidaya	4	0	\N
416	2.05.01.03.	Bidang Perikanan Tangkap	4	0	\N
417	2.05.01.04.	Bidang Kelautan	4	0	\N
418	2.05.01.05.	Bidang Pengembangan Usaha	4	0	\N
419	2.05.01.06.	Balai Pengembangan Benih Ikan Air Tawar	4	0	\N
420	2.05.01.07.	Balai Pengembangan Benih Ikan Air Payau dan Laut	4	0	\N
421	2.05.01.08.	Balai Pengembangan Budi Daya Air Tawar	4	0	\N
422	2.05.01.09.	Balai Pengembangan Budi Daya Air Payau dan Laut	4	0	\N
423	2.05.01.10.	Balai Pengembangan Teknologi Penangkapan dan Kelautan	4	0	\N
424	2.05.01.11.	Balai Pengujian dan Pembinaan Mutu Hasil Perikanan	4	0	\N
425	2.05.01.12.	Balai Pelabuhan Perikanan Pantai	4	0	\N
426	2.05.01.13.	Balai Pelestarian Perikanan Perairan Umum	4	0	\N
427	2.05.01.14.	Balai Pengembangan Produksi Budi Daya Air Tawar	4	0	\N
428	2.06.	Perdagangan	2	1	\N
429	2.07.	Industri	2	1	\N
430	2.07.01.	Dinas Perindustrian dan Perdagangan	3	1	\N
431	2.07.01.01.	Sekretariat	4	0	\N
432	2.07.01.02.	Bidang Industri Logam, Mesin, Alat Transportasi, Aneka Tekstil, dan Telematika (ILMATATTEL)	4	0	\N
433	2.07.01.03.	Bidang Industri Aneka, Kerajinan dan Kimia	4	0	\N
434	2.07.01.04.	Bidang Industri Agro	4	0	\N
435	2.07.01.05.	Bidang Perdagangan Dalam Negeri	4	0	\N
436	2.07.01.06.	Bidang Perdagangan Luar Negeri	4	0	\N
437	2.07.01.07.	Bidang Promosi dan Kerjasama Industri dan Perdagangan	4	0	\N
438	2.07.01.08.	Balai Kemetrologian Bandung	4	0	\N
439	2.07.01.09.	Balai Pengembangan Perindustrian	4	0	\N
440	2.07.01.10.	Balai Kemetrologian Bogor	4	0	\N
441	2.07.01.11.	Balai Kemetrologian Karawang	4	0	\N
460	2.07.01.12.	Balai Kemetrologian Cirebon	4	0	\N
461	2.07.01.13.	Balai Kemetrologian Tasikmalaya	4	0	\N
442	2.08.	Ketransmigrasian	2	1	\N
\.


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('units_id_seq', 889, true);


--
-- Data for Name: user_units; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY user_units (user_id, unit_id) FROM stdin;
10	208
15	208
19	208
20	208
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY users (id, user_name, user_password, email, status, security_code, last_login_date, registered_date) FROM stdin;
2	anonymous	\N	anonymous@local	1	default	\N	2015-05-21 08:15:12.931064
1	admin	$2a$10$uBSfHenWToXsdyGiwRoVReTI88JiD8SIEYtoqV3EFYYWrYUF1qzAK	admin@local	1	NoPkQeDPwKdYryhMebrtXloY7OTL1DNWmBJCFj8HpRVZtvifInGjUM5suyXfLJOg	\N	2015-05-21 08:15:12.848773
8	bud	$2a$10$0zwljumSaxZfQasIyeCyX.f0fzjsAC9ZThcaxj6p7zNICKnr0p7uO	bud@	1	DmTFrCNwtqbpZ8VasOd0jNESvmHvjx1QP9gxYuXRlKGpcui4iaLzbDohMGFetYKd	\N	2015-06-19 03:50:22.285621
10	bendahara	$2a$10$ZbnKG2de3dSg1/92Fz0FZeTQjI8VehPm7qkQNKZrLPBOrh3n.mAGK	bendahara@	1	i03V5LSWnpqyAdMjHsClUwpVBsXSZEQjDP1k8vMFHRbAoGEF69geCuUTJqBJ2uko	\N	2015-06-19 05:46:15.444457
16	fajar	$2a$10$AHX/X4YXZHvL.yLu99eFaOTn9wuA9jMKeDTfU8TFnca1E48Z0AO56	fajarlibri@gmail.com	1	SkwHaHXgiMXO0UAGqBWxhOodfYu2yWi8LwgE6lGprEfLhJmcIQJ9zmVrRjRAelsb	\N	2015-09-07 02:59:10.073919
17	ahmad nurhidayat	$2a$10$bWtgAuPz2oUiQ6.9yj24ouqa6Kd.6rF.lnw1HEksRJT41r71JMXpm	ahmad.nurhidayat75@gmail.com	1	j0Qhsu9IS5oCdGZXftbcnsLYZR2Wd6uMUvaHmVymXzDA7DyTxbkNrJaveQq1O4Gi	\N	2015-09-07 03:01:35.240744
18	A	$2a$10$C5PXQNvCMW6kYxaxQZSnL.RCC5rjvPMzRLlXyRqFkx1GVDbVKB8V6	a@yahoo.com	1	AWxJmKpXjPEKR7bBYPS2ecihCtXG51aMlIDodNhf46AjMvn8sNWTVZBCu3tcLy0d	\N	2015-12-07 04:17:15.441443
19	saranamandiri01@gmail.com	$2a$10$DZP5/RxUraA.JtiHXf/mj.ISm5kvPuooEzhKc3C1UmRih6korsfT6	saranamandiri01@gmail.com	1	HPxmFbsE0cjtfPyDQEjCvRNhrRWOnb4azdBZuUsLMYvgmxLFrltWIk9eJcqABl1X	\N	2016-04-06 10:20:47.963346
20	petronas@yahoo.com	$2a$10$b17sdq0.RvZSjN9YHubYMuvOBuT3.BVSsFbSvdMYJyP.HuiCXjHFe	petronas@yahoo.com	1	NXnbmRidqGuRc5hJFLIvYehN1FierjDtxsfws9ZkzlaMSYAlbBGwHEK7PyEfdmru	\N	2016-05-26 02:59:06.68978
15	pertamina@gmail.com	$2a$10$OKta1bhnsUCisHdUPp.h1uzBYBsPK5OGmuWKA50bM2GQxqeFGcmoa	pertamina@gmail.com	1	XfSGyXWJituaC6dqj7ZV0FmeEHnrl52qoPbhTpUhxY1dNHKpMsWOzLg9rcVQuKMB	\N	2015-08-26 04:18:44.527909
\.


--
-- Data for Name: users_groups; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY users_groups (group_id, user_id) FROM stdin;
2	10
4	8
3	1
1	15
1	18
1	19
1	20
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('users_id_seq', 20, true);


--
-- Data for Name: users_permissions; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY users_permissions (perm_name, user_id) FROM stdin;
\.


--
-- Data for Name: users_resources_permissions; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY users_resources_permissions (resource_id, perm_name, user_id) FROM stdin;
\.


--
-- Data for Name: wilayahs; Type: TABLE DATA; Schema: public; Owner: web-r
--

COPY wilayahs (id, kode, nama, level_id, parent_id) FROM stdin;
1	32.00	PROVINSI JAWA BARAT	2	\N
\.


--
-- Name: wilayahs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: web-r
--

SELECT pg_catalog.setval('wilayahs_id_seq', 1, true);


--
-- Name: arinvoice_uq; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoice_uq UNIQUE (tahun_id, unit_id, no_id);


--
-- Name: arinvoices_kode_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoices_kode_key UNIQUE (kode);


--
-- Name: arinvoices_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoices_pkey PRIMARY KEY (id);


--
-- Name: arsspd_uq; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arsspds
    ADD CONSTRAINT arsspd_uq UNIQUE (arinvoice_id, pembayaran_ke);


--
-- Name: arsspds_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arsspds
    ADD CONSTRAINT arsspds_pkey PRIMARY KEY (id);


--
-- Name: arsts_item_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arsts_item
    ADD CONSTRAINT arsts_item_pkey PRIMARY KEY (sts_id, sspd_id, rekening_id);


--
-- Name: arsts_no_uq; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arsts
    ADD CONSTRAINT arsts_no_uq UNIQUE (tahun_id, unit_id, no_id);


--
-- Name: arsts_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY arsts
    ADD CONSTRAINT arsts_pkey PRIMARY KEY (id);


--
-- Name: beaker_cache_namespace_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY beaker_cache
    ADD CONSTRAINT beaker_cache_namespace_key UNIQUE (namespace);


--
-- Name: beaker_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY beaker_cache
    ADD CONSTRAINT beaker_cache_pkey PRIMARY KEY (id);


--
-- Name: external_identities_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY external_identities
    ADD CONSTRAINT external_identities_pkey PRIMARY KEY (external_id, local_user_name, provider_name);


--
-- Name: groups_group_name_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_group_name_key UNIQUE (group_name);


--
-- Name: groups_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY groups_permissions
    ADD CONSTRAINT groups_permissions_pkey PRIMARY KEY (group_id, perm_name);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: groups_resources_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY groups_resources_permissions
    ADD CONSTRAINT groups_resources_permissions_pkey PRIMARY KEY (group_id, resource_id, perm_name);


--
-- Name: groups_routes_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY groups_routes_permissions
    ADD CONSTRAINT groups_routes_permissions_pkey PRIMARY KEY (route_id, group_id);


--
-- Name: jabatans_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY jabatans
    ADD CONSTRAINT jabatans_pkey PRIMARY KEY (id);


--
-- Name: objekpajak_kode_uq; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY objekpajaks
    ADD CONSTRAINT objekpajak_kode_uq UNIQUE (subjekpajak_id, kode);


--
-- Name: objekpajaks_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY objekpajaks
    ADD CONSTRAINT objekpajaks_pkey PRIMARY KEY (id);


--
-- Name: pajaks_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY pajaks
    ADD CONSTRAINT pajaks_pkey PRIMARY KEY (id);


--
-- Name: paps_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY paps
    ADD CONSTRAINT paps_pkey PRIMARY KEY (id);


--
-- Name: params_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY params
    ADD CONSTRAINT params_pkey PRIMARY KEY (id);


--
-- Name: pegawai_users_pegawai_id_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY pegawai_users
    ADD CONSTRAINT pegawai_users_pegawai_id_key UNIQUE (pegawai_id);


--
-- Name: pegawai_users_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY pegawai_users
    ADD CONSTRAINT pegawai_users_pkey PRIMARY KEY (user_id);


--
-- Name: pegawais_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY pegawais
    ADD CONSTRAINT pegawais_pkey PRIMARY KEY (id);


--
-- Name: pkbs_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY pkbs
    ADD CONSTRAINT pkbs_pkey PRIMARY KEY (id);


--
-- Name: rekenings_kode_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY rekenings
    ADD CONSTRAINT rekenings_kode_key UNIQUE (kode);


--
-- Name: rekenings_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY rekenings
    ADD CONSTRAINT rekenings_pkey PRIMARY KEY (id);


--
-- Name: resources_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (resource_id);


--
-- Name: routes_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: subjekpajaks_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY subjekpajaks
    ADD CONSTRAINT subjekpajaks_pkey PRIMARY KEY (id);


--
-- Name: unit_rekenings_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY unit_rekenings
    ADD CONSTRAINT unit_rekenings_pkey PRIMARY KEY (id);


--
-- Name: units_kode_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_kode_key UNIQUE (kode);


--
-- Name: units_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: user_units_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY user_units
    ADD CONSTRAINT user_units_pkey PRIMARY KEY (user_id, unit_id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY users_groups
    ADD CONSTRAINT users_groups_pkey PRIMARY KEY (user_id, group_id);


--
-- Name: users_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY users_permissions
    ADD CONSTRAINT users_permissions_pkey PRIMARY KEY (user_id, perm_name);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_resources_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY users_resources_permissions
    ADD CONSTRAINT users_resources_permissions_pkey PRIMARY KEY (user_id, resource_id, perm_name);


--
-- Name: users_user_name_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);


--
-- Name: wilayahs_kode_key; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY wilayahs
    ADD CONSTRAINT wilayahs_kode_key UNIQUE (kode);


--
-- Name: wilayahs_pkey; Type: CONSTRAINT; Schema: public; Owner: web-r; Tablespace: 
--

ALTER TABLE ONLY wilayahs
    ADD CONSTRAINT wilayahs_pkey PRIMARY KEY (id);


--
-- Name: groups_unique_group_name_key; Type: INDEX; Schema: public; Owner: web-r; Tablespace: 
--

CREATE UNIQUE INDEX groups_unique_group_name_key ON groups USING btree (lower((group_name)::text));


--
-- Name: users_email_key2; Type: INDEX; Schema: public; Owner: web-r; Tablespace: 
--

CREATE UNIQUE INDEX users_email_key2 ON users USING btree (lower((email)::text));


--
-- Name: users_username_uq2; Type: INDEX; Schema: public; Owner: web-r; Tablespace: 
--

CREATE INDEX users_username_uq2 ON users USING btree (lower((user_name)::text));


--
-- Name: arinvoices_objek_pajak_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoices_objek_pajak_id_fkey FOREIGN KEY (objek_pajak_id) REFERENCES objekpajaks(id);


--
-- Name: arinvoices_rekening_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoices_rekening_id_fkey FOREIGN KEY (rekening_id) REFERENCES rekenings(id);


--
-- Name: arinvoices_subjek_pajak_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoices_subjek_pajak_id_fkey FOREIGN KEY (subjek_pajak_id) REFERENCES subjekpajaks(id);


--
-- Name: arinvoices_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arinvoices
    ADD CONSTRAINT arinvoices_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: arsspds_arinvoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsspds
    ADD CONSTRAINT arsspds_arinvoice_id_fkey FOREIGN KEY (arinvoice_id) REFERENCES arinvoices(id);


--
-- Name: arsspds_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsspds
    ADD CONSTRAINT arsspds_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: arsts_item_rekening_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsts_item
    ADD CONSTRAINT arsts_item_rekening_id_fkey FOREIGN KEY (rekening_id) REFERENCES rekenings(id);


--
-- Name: arsts_item_sspd_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsts_item
    ADD CONSTRAINT arsts_item_sspd_id_fkey FOREIGN KEY (sspd_id) REFERENCES arsspds(id);


--
-- Name: arsts_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY arsts
    ADD CONSTRAINT arsts_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: external_identities_local_user_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY external_identities
    ADD CONSTRAINT external_identities_local_user_name_fkey FOREIGN KEY (local_user_name) REFERENCES users(user_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: groups_permissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY groups_permissions
    ADD CONSTRAINT groups_permissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: groups_resources_permissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY groups_resources_permissions
    ADD CONSTRAINT groups_resources_permissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: groups_resources_permissions_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY groups_resources_permissions
    ADD CONSTRAINT groups_resources_permissions_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: groups_routes_permissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY groups_routes_permissions
    ADD CONSTRAINT groups_routes_permissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id);


--
-- Name: groups_routes_permissions_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY groups_routes_permissions
    ADD CONSTRAINT groups_routes_permissions_route_id_fkey FOREIGN KEY (route_id) REFERENCES routes(id);


--
-- Name: objekpajaks_pajak_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY objekpajaks
    ADD CONSTRAINT objekpajaks_pajak_id_fkey FOREIGN KEY (pajak_id) REFERENCES pajaks(id);


--
-- Name: objekpajaks_subjekpajak_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY objekpajaks
    ADD CONSTRAINT objekpajaks_subjekpajak_id_fkey FOREIGN KEY (subjekpajak_id) REFERENCES subjekpajaks(id);


--
-- Name: objekpajaks_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY objekpajaks
    ADD CONSTRAINT objekpajaks_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: objekpajaks_wilayah_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY objekpajaks
    ADD CONSTRAINT objekpajaks_wilayah_id_fkey FOREIGN KEY (wilayah_id) REFERENCES wilayahs(id);


--
-- Name: pajaks_rekening_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pajaks
    ADD CONSTRAINT pajaks_rekening_id_fkey FOREIGN KEY (rekening_id) REFERENCES rekenings(id);


--
-- Name: pegawai_users_pegawai_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pegawai_users
    ADD CONSTRAINT pegawai_users_pegawai_id_fkey FOREIGN KEY (pegawai_id) REFERENCES pegawais(id);


--
-- Name: pegawai_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pegawai_users
    ADD CONSTRAINT pegawai_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: pegawais_jabatan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pegawais
    ADD CONSTRAINT pegawais_jabatan_id_fkey FOREIGN KEY (jabatan_id) REFERENCES jabatans(id);


--
-- Name: pegawais_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pegawais
    ADD CONSTRAINT pegawais_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: pegawais_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY pegawais
    ADD CONSTRAINT pegawais_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: resources_owner_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_owner_group_id_fkey FOREIGN KEY (owner_group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: resources_owner_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_owner_user_id_fkey FOREIGN KEY (owner_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: resources_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT resources_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES resources(resource_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: subjekpajaks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY subjekpajaks
    ADD CONSTRAINT subjekpajaks_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: unit_rekenings_rekening_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY unit_rekenings
    ADD CONSTRAINT unit_rekenings_rekening_id_fkey FOREIGN KEY (rekening_id) REFERENCES rekenings(id);


--
-- Name: unit_rekenings_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY unit_rekenings
    ADD CONSTRAINT unit_rekenings_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: user_units_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY user_units
    ADD CONSTRAINT user_units_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES units(id);


--
-- Name: user_units_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY user_units
    ADD CONSTRAINT user_units_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY users_groups
    ADD CONSTRAINT users_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY users_groups
    ADD CONSTRAINT users_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY users_permissions
    ADD CONSTRAINT users_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_resources_permissions_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY users_resources_permissions
    ADD CONSTRAINT users_resources_permissions_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_resources_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY users_resources_permissions
    ADD CONSTRAINT users_resources_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wilayahs_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: web-r
--

ALTER TABLE ONLY wilayahs
    ADD CONSTRAINT wilayahs_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES wilayahs(id);


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

