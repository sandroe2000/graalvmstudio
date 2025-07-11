package br.com.sdvs.base.dto;

/**
 * DTO para carregar o resultado combinado da consulta JOIN entre
 * st_tables e st_tables_queries.
 * Um registro pode representar uma tabela com uma de suas queries,
 * ou uma tabela sem nenhuma query (nesse caso, queryId será null).
 */
public record TableWithQueryDTO(
    Long tableId,
    String tableName,
    Long queryId,
    String queryTitle
) {}
