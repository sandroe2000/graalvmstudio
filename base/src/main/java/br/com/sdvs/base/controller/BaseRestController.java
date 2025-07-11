package br.com.sdvs.base.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RestController;

import br.com.sdvs.base.component.DatabaseModuleService;
import br.com.sdvs.base.component.JSEngine;
import br.com.sdvs.base.model.DBTreeNode;
import br.com.sdvs.base.model.JSParms;
import br.com.sdvs.base.model.JSScript;
import br.com.sdvs.base.model.TreeNode;
import br.com.sdvs.base.service.JSScriptService;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
public class BaseRestController {

    private static final Logger logger = LoggerFactory.getLogger(BaseRestController.class);
    private final JSScriptService service;
    private final DatabaseModuleService dbService;
    private final JSEngine jsEngine;

    public BaseRestController() {
        this.service = new JSScriptService();
        this.dbService = new DatabaseModuleService(this.service);
        this.jsEngine = new JSEngine(this.dbService);
    }

    @GetMapping("/tree")
    public ResponseEntity<List<TreeNode>> getFileTree() {
        logger.info("Construindo a árvore de arquivos.");
        List<TreeNode> tree = service.buildFileTree();
        return ResponseEntity.ok(tree);
    }

    @GetMapping("/dBTree")
    public ResponseEntity<List<DBTreeNode>> buildDBTree() {
        logger.info("Construindo a árvore de arquivos.");
        List<DBTreeNode> tree = service.buildDBTree(); 
        return ResponseEntity.ok(tree);
    }

    @GetMapping("/findByPath")
    public ResponseEntity<JSScript> findByPath(@RequestParam String path) {
        logger.info("Buscando script com path: {}", path);
        JSScript script = service.findByPath(path);
        return ResponseEntity.ok(script);
    }

    @GetMapping("/findByPathContains")
    public ResponseEntity<List<JSScript>> findByPathContains(@RequestParam String path) {
        logger.info("Buscando script com path: {}", path);
        List<JSScript> scripts = service.findByPathContains(path);
        return ResponseEntity.ok(scripts);
    }

    @PostMapping("/execute")
    public Map<String, Object> executeByPath(@RequestBody JSParms params) {
        return jsEngine.executeByPath(params);
    }

    @PutMapping("/{id}")
    public ResponseEntity<JSScript> updateScript(@RequestBody JSScript script, @PathVariable("id") Long id) {
        try {
            logger.info("Recebida requisição para atualizar um script: {}", script.name());
            JSScript updatedScript = service.updateScript(script, id);
            return ResponseEntity.ok(updatedScript);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }
}