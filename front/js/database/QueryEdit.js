import Split from '/assets/split.js/dist/split.es.js';

export class QueryEdit {

    constructor(app, params){
        this.app = app;
        this.params = params || {};
        this.sqlEditor = null;
        this.data = null;
    }

    template(){
        return `
        <style>
            .h-full {
                height: calc(100vh - 220px);
            }
            #editorQuery,
            #resultQuery {
                border-radius: var(--deep-border-radius);
                border: var(--deep-border);
                background-color: #21222C;
            }
            #resultQuery div.dt-search {
                display: none;
            }
        </style>
        <div class="container-fluid" style="padding-right: 8px; padding-left: 8px">
            <h5 class="mt-3 text-light">
                <input type="hidden" id="hdnQueryId" value="${this.params.id}" />
                <i class="bi bi-database-fill-gear me-2" style="color: var(--deep-indigo-200)"></i> ${this.params.label}
            </h5>
            <form id="frmQueryEdit">
                <div id="gridQuery" class="h-full">                
                    <div id="editorQuery"></div>
                    <div id="resultQuery" style="padding-right: 8px; padding-left: 8px">
                        <table id="datatableResultQuery" class="display nowrap compact"></table>
                    </div>
                <div>
            </form>
        </div>`;
    }

    async init(){

        Split(['#editorQuery', '#resultQuery'], {
            direction: 'vertical',
            gutterSize: 8,
            minSize: 0,
            sizes: [50, 50]
        });

        //new DataTable('#datatableResultQuery',{
        //    lengthMenu: [5, 10, 25, 50, -1]
        //});

        await this.initEditor();
    }

    async initEditor() {

        this.data = await this.app.service.executeByPath({
            path:'/studio/backend/service/DBService.mjs',
            name:'DBService',
            execFunction: 'selectQuery',
            sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
            params: {"id": `${this.params.id}`}
        });

        let container = document.querySelector('#editorQuery');

        if(!window.monaco){
            await this.loadMonaco();
        }

        this.sqlEditor = monaco.editor.create(container, {
            value: '',
            language: 'sql',
            automaticLayout: true,
            minimap: { enabled: false },
            stickyScroll: { enabled: false }
        });

        const resizeObserver = new ResizeObserver(() => {
            if (this.sqlEditor ) {
                this.sqlEditor .layout();
            }
        });

        resizeObserver.observe(container);
        
        fetch('/js/themes/Dracula.json')
            .then(data => data.json())
            .then(data => {
                monaco.editor.defineTheme('vs-dark', data);
                monaco.editor.setTheme('vs-dark');
            });

        container.innerHTML = '';
        container.appendChild(this.sqlEditor.getDomNode());
        if(this.data && this.data?.resultList[0]){
            this.sqlEditor.setValue(this.data.resultList[0].query);
        }
    }

    async loadMonaco() {
        return new Promise((resolve) => {
            
            if (window.monaco) {
                resolve();
                return;
            }

            require.config({ paths: { vs: 'https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/min/vs' } });
            require(['vs/editor/editor.main'], resolve);
        });
    }
}