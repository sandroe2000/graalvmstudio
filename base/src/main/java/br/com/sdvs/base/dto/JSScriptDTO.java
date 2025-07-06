package br.com.sdvs.base.dto;

public record JSScriptDTO (
    String location,
    String name,
    String path,
    String typeFile,
    String language,  
    String initFunctionName,
    String code
) {}
