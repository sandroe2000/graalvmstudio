package br.com.sdvs.base.component;

import java.util.Optional;
import br.com.sdvs.base.service.JSScriptService;

public class DatabaseModuleService {

    private final JSScriptService service;

    public DatabaseModuleService(JSScriptService service) {
        this.service = service;
    }

    public Optional<String> findModuleContentByPath(String path) {
        return Optional.ofNullable(this.service.findByPath(path).code());
    }

    public boolean moduleExists(String path) {
        return !this.service.findByPath(path).code().isEmpty();
    }
}
