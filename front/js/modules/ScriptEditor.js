export class ScriptEditor {
    constructor(container, onSave) {
        this.container = container;
        this.onSave = onSave;
        this.editor = null;
        this.currentScript = null;
        this.initEditor();
    }

    async initEditor() {
        // Configuração do Monaco Editor
        await this.loadMonaco();

        this.editor = monaco.editor.create(this.container, {
            value: '',
            language: 'javascript',
            theme: 'vs-light',
            automaticLayout: true,
            minimap: { enabled: false }
        });

        this.container.innerHTML = '';
        this.container.appendChild(this.editor.getDomNode());

        // Adiciona botão de salvar
        const saveBtn = document.createElement('button');
        saveBtn.textContent = 'Salvar';
        saveBtn.className = 'save-btn';
        saveBtn.addEventListener('click', () => this.handleSave());
        this.container.prepend(saveBtn);
    }

    loadMonaco() {
        return new Promise((resolve) => {
            if (window.monaco) {
                resolve();
                return;
            }

            require.config({ paths: { vs: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.40.0/min/vs' } });
            require(['vs/editor/editor.main'], resolve);
        });
    }

    getScript() {
        if (this.editor) {
            this.editor.getValue();
        }
    }

    loadScript(script) {
        this.currentScript = script;
        if (this.editor) {
            this.editor.setValue(script.code);
        }
    }

    clear() {
        if (this.editor) {
            this.editor.setValue('');
        }
        this.currentScript = null;
    }

    handleSave() {
        debugger;
        if (!this.currentScript) return;
        const code = this.editor.getValue();
        this.onSave(code);
    }
}