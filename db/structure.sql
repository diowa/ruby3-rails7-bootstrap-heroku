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
-- Name: history; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS history;


--
-- Name: temporal; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA IF NOT EXISTS temporal;


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: chronomodel_boxes_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.chronomodel_boxes_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE _now timestamp;
    BEGIN
        _now := timezone('UTC', now());

        DELETE FROM history.boxes
        WHERE id = old.id AND validity = tsrange(_now, NULL);

        UPDATE history.boxes SET validity = tsrange(lower(validity), _now)
        WHERE id = old.id AND upper_inf(validity);

        DELETE FROM ONLY temporal.boxes
        WHERE id = old.id;

        RETURN OLD;
    END;

$$;


--
-- Name: chronomodel_boxes_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.chronomodel_boxes_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.id IS NULL THEN
            NEW.id := nextval('temporal.boxes_id_seq');
        END IF;

        INSERT INTO temporal.boxes ( id, "name", "created_at", "updated_at" )
        VALUES ( NEW.id, NEW."name", NEW."created_at", NEW."updated_at" );

        INSERT INTO history.boxes ( id, "name", "created_at", "updated_at", validity )
        VALUES ( NEW.id, NEW."name", NEW."created_at", NEW."updated_at", tsrange(timezone('UTC', now()), NULL) );

        RETURN NEW;
    END;

$$;


--
-- Name: chronomodel_boxes_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.chronomodel_boxes_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE _now timestamp;
    DECLARE _hid integer;
    DECLARE _old record;
    DECLARE _new record;
    BEGIN
        IF OLD IS NOT DISTINCT FROM NEW THEN
            RETURN NULL;
        END IF;

        _old := row(OLD."name", OLD."created_at");
        _new := row(NEW."name", NEW."created_at");

        IF _old IS NOT DISTINCT FROM _new THEN
            UPDATE ONLY temporal.boxes SET ( "name", "created_at", "updated_at" ) = ( NEW."name", NEW."created_at", NEW."updated_at" ) WHERE id = OLD.id;
            RETURN NEW;
        END IF;

        _now := timezone('UTC', now());
        _hid := NULL;

        SELECT hid INTO _hid FROM history.boxes WHERE id = OLD.id AND lower(validity) = _now;

        IF _hid IS NOT NULL THEN
            UPDATE history.boxes SET ( "name", "created_at", "updated_at" ) = ( NEW."name", NEW."created_at", NEW."updated_at" ) WHERE hid = _hid;
        ELSE
            UPDATE history.boxes SET validity = tsrange(lower(validity), _now)
            WHERE id = OLD.id AND upper_inf(validity);

            INSERT INTO history.boxes ( id, "name", "created_at", "updated_at", validity )
                VALUES ( OLD.id, NEW."name", NEW."created_at", NEW."updated_at", tsrange(_now, NULL) );
        END IF;

        UPDATE ONLY temporal.boxes SET ( "name", "created_at", "updated_at" ) = ( NEW."name", NEW."created_at", NEW."updated_at" ) WHERE id = OLD.id;

        RETURN NEW;
    END;

$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: boxes; Type: TABLE; Schema: temporal; Owner: -
--

CREATE TABLE temporal.boxes (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: boxes; Type: TABLE; Schema: history; Owner: -
--

CREATE TABLE history.boxes (
    hid bigint NOT NULL,
    validity tsrange NOT NULL,
    recorded_at timestamp without time zone DEFAULT timezone('UTC'::text, now()) NOT NULL
)
INHERITS (temporal.boxes);


--
-- Name: boxes_hid_seq; Type: SEQUENCE; Schema: history; Owner: -
--

CREATE SEQUENCE history.boxes_hid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: boxes_hid_seq; Type: SEQUENCE OWNED BY; Schema: history; Owner: -
--

ALTER SEQUENCE history.boxes_hid_seq OWNED BY history.boxes.hid;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: boxes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.boxes AS
 SELECT boxes.id,
    boxes.name,
    boxes.created_at,
    boxes.updated_at
   FROM ONLY temporal.boxes;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: boxes_id_seq; Type: SEQUENCE; Schema: temporal; Owner: -
--

CREATE SEQUENCE temporal.boxes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: boxes_id_seq; Type: SEQUENCE OWNED BY; Schema: temporal; Owner: -
--

ALTER SEQUENCE temporal.boxes_id_seq OWNED BY temporal.boxes.id;


--
-- Name: boxes id; Type: DEFAULT; Schema: history; Owner: -
--

ALTER TABLE ONLY history.boxes ALTER COLUMN id SET DEFAULT nextval('temporal.boxes_id_seq'::regclass);


--
-- Name: boxes hid; Type: DEFAULT; Schema: history; Owner: -
--

ALTER TABLE ONLY history.boxes ALTER COLUMN hid SET DEFAULT nextval('history.boxes_hid_seq'::regclass);


--
-- Name: boxes id; Type: DEFAULT; Schema: temporal; Owner: -
--

ALTER TABLE ONLY temporal.boxes ALTER COLUMN id SET DEFAULT nextval('temporal.boxes_id_seq'::regclass);


--
-- Name: boxes boxes_pkey; Type: CONSTRAINT; Schema: history; Owner: -
--

ALTER TABLE ONLY history.boxes
    ADD CONSTRAINT boxes_pkey PRIMARY KEY (hid);


--
-- Name: boxes boxes_timeline_consistency; Type: CONSTRAINT; Schema: history; Owner: -
--

ALTER TABLE ONLY history.boxes
    ADD CONSTRAINT boxes_timeline_consistency EXCLUDE USING gist (id WITH =, validity WITH &&);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: boxes boxes_pkey; Type: CONSTRAINT; Schema: temporal; Owner: -
--

ALTER TABLE ONLY temporal.boxes
    ADD CONSTRAINT boxes_pkey PRIMARY KEY (id);


--
-- Name: boxes_inherit_pkey; Type: INDEX; Schema: history; Owner: -
--

CREATE INDEX boxes_inherit_pkey ON history.boxes USING btree (id);


--
-- Name: boxes_instance_history; Type: INDEX; Schema: history; Owner: -
--

CREATE INDEX boxes_instance_history ON history.boxes USING btree (id, recorded_at);


--
-- Name: boxes_recorded_at; Type: INDEX; Schema: history; Owner: -
--

CREATE INDEX boxes_recorded_at ON history.boxes USING btree (recorded_at);


--
-- Name: index_boxes_temporal_on_lower_validity; Type: INDEX; Schema: history; Owner: -
--

CREATE INDEX index_boxes_temporal_on_lower_validity ON history.boxes USING btree (lower(validity));


--
-- Name: index_boxes_temporal_on_upper_validity; Type: INDEX; Schema: history; Owner: -
--

CREATE INDEX index_boxes_temporal_on_upper_validity ON history.boxes USING btree (upper(validity));


--
-- Name: index_boxes_temporal_on_validity; Type: INDEX; Schema: history; Owner: -
--

CREATE INDEX index_boxes_temporal_on_validity ON history.boxes USING gist (validity);


--
-- Name: boxes chronomodel_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER chronomodel_delete INSTEAD OF DELETE ON public.boxes FOR EACH ROW EXECUTE FUNCTION public.chronomodel_boxes_delete();


--
-- Name: boxes chronomodel_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER chronomodel_insert INSTEAD OF INSERT ON public.boxes FOR EACH ROW EXECUTE FUNCTION public.chronomodel_boxes_insert();


--
-- Name: boxes chronomodel_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER chronomodel_update INSTEAD OF UPDATE ON public.boxes FOR EACH ROW EXECUTE FUNCTION public.chronomodel_boxes_update();


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220509130857');


