package br.com.sdvs.base.model;

public record JSScript (
    Long id,
    String location,
    String name,
    String path,
    String typeFile,
    String language,  
    String initFunctionName,
    String code
) {}
