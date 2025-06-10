package br.com.sdvs.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class JSScript {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String location;
    private String name;
    private String typeFile;

    @ColumnDefault("false")
    private boolean inDebugger;
    
    @Lob
    private String code;
    
    private LocalDateTime createdAt;
    private LocalDateTime lastModified;
}