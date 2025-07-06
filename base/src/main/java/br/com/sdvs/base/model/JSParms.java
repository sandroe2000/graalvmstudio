package br.com.sdvs.base.model;

import java.util.Map;
import java.util.UUID;

public class JSParms {
    
    private boolean inDebugger;
    private UUID sessionId;
    private String code;
    private String path;
    private String name;
    private String execFunction;
    private Map<String, Object> params;

    public JSParms() {}

    public JSParms(boolean inDebugger, UUID sessionId, String code, String path, String name, String execFunction, Map<String, Object> params) {
        this.inDebugger = inDebugger;
        this.sessionId = sessionId;
        this.code = code;
        this.path = path;   
        this.name = name;
        this.execFunction = execFunction;
        this.params = params;   
    }

    public boolean isInDebugger() {
        return inDebugger;
    }

    public void setInDebugger(boolean inDebugger) {
        this.inDebugger = inDebugger;
    }

    public UUID getSessionId() {
        return sessionId;
    }

    public void setSessionId(UUID sessionId) {
        this.sessionId = sessionId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getExecFunction() {
        return execFunction;
    }

    public void setExecFunction(String execFunction) {
        this.execFunction = execFunction;
    }

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (inDebugger ? 1231 : 1237);
        result = prime * result + ((sessionId == null) ? 0 : sessionId.hashCode());
        result = prime * result + ((code == null) ? 0 : code.hashCode());
        result = prime * result + ((path == null) ? 0 : path.hashCode());
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + ((execFunction == null) ? 0 : execFunction.hashCode());
        result = prime * result + ((params == null) ? 0 : params.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        JSParms other = (JSParms) obj;
        if (inDebugger != other.inDebugger)
            return false;
        if (sessionId == null) {
            if (other.sessionId != null)
                return false;
        } else if (!sessionId.equals(other.sessionId))
            return false;
        if (code == null) {
            if (other.code != null)
                return false;
        } else if (!code.equals(other.code))
            return false;
        if (path == null) {
            if (other.path != null)
                return false;
        } else if (!path.equals(other.path))
            return false;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (execFunction == null) {
            if (other.execFunction != null)
                return false;
        } else if (!execFunction.equals(other.execFunction))
            return false;
        if (params == null) {
            if (other.params != null)
                return false;
        } else if (!params.equals(other.params))
            return false;
        return true;
    }
    
}