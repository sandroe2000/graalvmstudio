import { ScriptList } from './ScriptList.js';
import { ScriptEditor } from './ScriptEditor.js';
import { ApiService } from './ApiService.js';

export class Crud {
    constructor(app) {
        this.app = app;
        this.api = new ApiService();
        this.scripts = [];
        this.selectedScript = null;
    }

    async init() {
        this.app.innerHTML = this.template();
        this.bindElements();
        await this.loadScripts();
        this.scriptList = new ScriptList(
            this.scriptsContainer,
            this.scripts,
            this.handleSelectScript.bind(this),
            this.handleDeleteScript.bind(this)
        );
        this.scriptEditor = new ScriptEditor(
            this.editorContainer,
            this.handleSaveScript.bind(this)
        );
        this.bindEvents();
    }

    template() {
        return `
        <div class="app-container">
            <div class="sidebar">
                <div class="search-container">
                    <input type="text" id="search" placeholder="Buscar scripts...">
                </div>
                <div class="script-actions">
                    <input type="text" id="new-script-name" placeholder="Nome do novo script">
                    <button id="create-script">Criar Novo</button>
                </div>
                <div id="scripts-container"></div>
            </div>
            <div id="editor-container"></div>
        </div>`;
    }

    bindElements() {
        this.scriptsContainer = document.getElementById('scripts-container');
        this.editorContainer = document.getElementById('editor-container');
        this.searchInput = document.getElementById('search');
        this.newScriptNameInput = document.getElementById('new-script-name');
        this.createScriptBtn = document.getElementById('create-script');
    }

    bindEvents() {
        this.searchInput.addEventListener('input', (e) => {
            this.scriptList.filterScripts(e.target.value);
        });

        this.createScriptBtn.addEventListener('click', () => {
            this.handleCreateScript();
        });
    }

    async loadScripts() {
        try {
            this.scripts = await this.api.getScripts();
        } catch (error) {
            console.error('Error loading scripts:', error);
        }
    }

    handleSelectScript(script) {
        this.selectedScript = script;
        this.scriptEditor.loadScript(script);
    }

    async handleSaveScript(code) {
        if (!this.selectedScript) return;

        try {
            const updatedScript = await this.api.updateScript(
                this.selectedScript.id,
                { ...this.selectedScript, code }
            );

            this.scripts = this.scripts.map(s =>
                s.id === updatedScript.id ? updatedScript : s
            );
            this.scriptList.updateScripts(this.scripts);
            this.selectedScript = updatedScript;
        } catch (error) {
            console.error('Error saving script:', error);
        }
    }

    async handleCreateScript() {
        const name = this.newScriptNameInput.value.trim();
        if (!name) return;
        //debugger;
        let json = {
                name,
                code: this.scriptEditor.editor.getValue(),
                createdAt: new Date().toISOString(),
                lastModified: new Date().toISOString()
        };

        try {
            const newScript = await this.api.createScript(json);

            this.scripts = [...this.scripts, newScript];
            this.scriptList.updateScripts(this.scripts);
            this.selectedScript = newScript;
            this.scriptEditor.loadScript(newScript);
            this.newScriptNameInput.value = '';
        } catch (error) {
            console.error('Error creating script:', error);
        }
    }

    async handleDeleteScript(id) {
        try {
            await this.api.deleteScript(id);
            this.scripts = this.scripts.filter(s => s.id !== id);
            this.scriptList.updateScripts(this.scripts);

            if (this.selectedScript?.id === id) {
                this.selectedScript = null;
                this.scriptEditor.clear();
            }
        } catch (error) {
            console.error('Error deleting script:', error);
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const app = document.getElementById('app');
    const crud = new Crud(app);
    crud.init();
});