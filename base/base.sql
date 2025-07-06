-- Active: 1741014617048@@127.0.0.1@5432@studio@public

CREATE DATABASE studio;

CREATE TABLE js_scripts(
    id SERIAL NOT NULL,
    location varchar(255),
    name varchar(255) NOT NULL,
    path varchar(255),
    type_file varchar(50),
    language varchar(50),
    init_function_name varchar(255),
    code text,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS st_tables (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tables_name VARCHAR(255) NOT NULL,
    created_by BIGINT NOT NULL,
    updated_by BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS st_table_columns (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tables_id BIGINT NOT NULL,
    columns_name VARCHAR(255) NOT NULL,
    data_type VARCHAR(50) NOT NULL,
    length INTEGER NOT NULL DEFAULT 0,
    default_value VARCHAR(255) NOT NULL,
    fk_table VARCHAR(255) NOT NULL,
    index_search CHAR(1) NOT NULL,
    is_required CHAR(1) NOT NULL,
    created_by BIGINT NOT NULL,
    updated_by BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_st_tables FOREIGN KEY (tables_id) REFERENCES st_tables(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS st_tables_queries (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tables_id BIGINT NOT NULL,
    query_name VARCHAR(255) NOT NULL,
    query TEXT,
    created_by BIGINT NOT NULL,
    updated_by BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_st_tables_queries  FOREIGN KEY (tables_id) REFERENCES st_tables(id) ON DELETE CASCADE
);