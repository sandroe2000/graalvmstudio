package br.com.sdvs.base.model;

// Este record representa um script SEM o campo "code"
public record JSScriptSummary(
    Long id,
    String location,
    String name,
    String path,
    String typeFile,
    String language,
    String initFunctionName
) {}
