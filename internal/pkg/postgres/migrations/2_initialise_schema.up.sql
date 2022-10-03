CREATE TABLE IF NOT EXISTS todo_item
(
    creation_timestamp timestamp      NOT NULL,
    update_timestamp   timestamp,
    id                 uuid           NOT NULL PRIMARY KEY,
    text               VARCHAR        NOT NULL,
    is_done            boolean        NOT NULL DEFAULT FALSE
);

CREATE TRIGGER todo_item_creation_ts_trigger
    BEFORE INSERT
    ON todo_item
    FOR EACH ROW
EXECUTE
    PROCEDURE set_creation_timestamp();

CREATE TRIGGER todo_item_update_ts_trigger
    BEFORE UPDATE
    ON todo_item
    FOR EACH ROW
EXECUTE
    PROCEDURE set_update_timestamp();