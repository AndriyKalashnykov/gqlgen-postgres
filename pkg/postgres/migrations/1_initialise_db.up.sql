CREATE FUNCTION set_creation_timestamp() RETURNS trigger
    LANGUAGE plpgsql
AS
$$
BEGIN
    NEW.creation_timestamp = now();
    RETURN NEW;
END;
$$;

CREATE FUNCTION set_update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
AS
$$
BEGIN
    NEW.update_timestamp = now();
    RETURN NEW;
END;
$$;
