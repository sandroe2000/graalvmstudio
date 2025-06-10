package br.com.sdvs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.sdvs.model.JSScript;
import br.com.sdvs.service.JSScriptService;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
@CrossOrigin(origins = "http://localhost:3000", maxAge = 3600)
@RequestMapping("/api/scripts")
public class JSScriptController {
    
    @Autowired
    private JSScriptService scriptService;
    
    @GetMapping("")
    public List<JSScript> findAll() {
        return scriptService.findAll();
    }

    @GetMapping("/{localtion}/{name}")
    public JSScript findById(@PathVariable String localtion, @PathVariable String name) {
        return scriptService.findByLocationAndName(localtion, name);
    }

    @GetMapping("/{id}")
    public JSScript findById(@PathVariable Long id) {
        return scriptService.findById(id);
    }
    
    @GetMapping("/{id}/execute")
    public String executeScript(@PathVariable Long id) {
        return scriptService.executeScript(id);
    }

    @PostMapping
    public JSScript save(@RequestBody JSScript script) {
        return scriptService.save(script);
    }
    
    @PostMapping("/execute")
    public String executeRawScript(@RequestBody String jsCode) {
        return scriptService.executeJS(jsCode);
    }

    @PutMapping("/{id}")
    public JSScript update(@PathVariable Long id, @RequestBody JSScript entity) {
        entity.setId(id);
        return scriptService.update(entity);
    }

    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable Long id){
        scriptService.deleteById(id);
    }
}