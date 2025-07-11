/******* CUSTOMIZADO NÂO TROCAR DE VERSÃO *******/
import { Treeview } from "/assets/quercus.js/dist/treeview.js";

export class Folder {

    constructor(app){
        this.app = app;
        this.files = [];
        this.editor = null;
        this.split = null;   
        this.treeViewaFiles = null;     
    }

    template(){
        //`<ul class="deep-list mt-3 ps-2" id="scriptList"></ul>`;
        return `<div id="treeViewFolder" class="custom-treeview-wrapper"></div>`
    }

    async init(){       
        await this.loadFiles();
        await this.events();        
    }

    getIcon(str){
        let icon = 'file-text';
        switch (str) {
            case 'js':
            case 'javascript':
                icon = 'javascript';
                break;
            case 'css':
                icon = 'hash';
                break;
            case 'html':
                icon = 'code-slash';
                break;
        }
        return icon;
    }

    async loadFiles(){

        //this.files = await this.app.service.buildFileTree();
        let result = await this.app.service.executeByPath({
            path:'/studio/backend/service/DBService.mjs',
            name:'DBService',
            execFunction: 'buildFileTree',
            sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
            params: {}
        });
        this.files = result.resultList;

        if(!this.files || this.files.length == 0) return false;

        this.treeViewaFiles = new Treeview({
            containerId: 'treeViewFolder',
            data: this.files,
            searchEnabled: false,
            initiallyExpanded: true, 
            multiSelectEnabled: false,
            onSelectionChange: (selectedNodesData) => {
                if(selectedNodesData.length > 0 && selectedNodesData[0].type!=='folder'){
                    this.newTab(selectedNodesData[0].path); 
                }           
            },
            onRenderNode: (nodeData, nodeContentWrapperElement) => {
                // Clear existing content if any (important for setData calls)
                nodeContentWrapperElement.innerHTML = '';
                
                // Create an icon based on node type
                const iconSpan = document.createElement('span');
                iconSpan.classList.add('custom-node-icon'); // Apply custom CSS class for styling
                if (nodeData.type === 'folder') {
                    iconSpan.innerHTML = '<i class="bi bi-folder-fill me-2" style="color:#FFD679"></i>';
                } else if (nodeData.extension === 'js') {
                    iconSpan.innerHTML = '<i class="bi bi-javascript me-2" style="color:yellow"></i>';
                } else if (nodeData.extension === 'css') {
                    iconSpan.innerHTML = '<i class="bi bi-hash me-2"></i>';
                } else if (nodeData.extension === 'html') {
                    iconSpan.innerHTML = '<i class="bi bi-code-slash me-2"></i>';
                } else if (nodeData.extension === 'file') {
                    iconSpan.innerHTML = '<i class="bi bi-file-earmark-text me-2"></i>';
                } else if (nodeData.extension === 'image') {
                    iconSpan.innerHTML = '<i class="bi bi-file-earmark-image me-2"></i>';
                } else {
                    iconSpan.innerHTML = '▪<i class="bi bi-file-earmark-x me-2"></i>';
                }
                nodeContentWrapperElement.appendChild(iconSpan);

                // Create a span for the node name
                const nameSpan = document.createElement('span');
                nameSpan.classList.add('treeview-node-text', 'custom-node-name'); // Keep treeview-node-text for search
                nameSpan.textContent = nodeData.name;
                nodeContentWrapperElement.appendChild(nameSpan);

                // Add a description/status if available
                if (nodeData.description) {
                    const descSpan = document.createElement('span');
                    descSpan.classList.add('custom-node-description');
                    descSpan.textContent = ` (${nodeData.description})`;
                    nodeContentWrapperElement.appendChild(descSpan);
                } else if (nodeData.status) {
                    const statusSpan = document.createElement('span');
                    statusSpan.classList.add('custom-node-description');
                    statusSpan.textContent = ` [${nodeData.status}]`;
                    statusSpan.classList.add(nodeData.status === 'active' ? 'custom-node-status-active' : 'custom-node-status-inactive');
                    nodeContentWrapperElement.appendChild(statusSpan);
                } else if (nodeData.size) {
                    const sizeSpan = document.createElement('span');
                    sizeSpan.classList.add('custom-node-description');
                    sizeSpan.textContent = ` (${nodeData.size})`;
                    nodeContentWrapperElement.appendChild(sizeSpan);
                }
            }
        });

        let btnAddFile = document.createElement('button');
            btnAddFile.classList.add('btn','btn-sm', 'btn-primary');
            btnAddFile.setAttribute('id', 'btnAddFile');
            btnAddFile.setAttribute('style', 'position: absolute; top: 2px; right: 7px; z-index: 1000; padding: 0.23rem 0.5rem !important');
            btnAddFile.innerHTML = '<i class="bi bi-plus"></i>';
            
        document.querySelector('#treeViewFolder').classList.add('position-relative');
        document.querySelector('#treeViewFolder').setAttribute('style', 'min-width: 230px;');
        document.querySelector('#treeViewFolder').appendChild(btnAddFile);
    }

    async showOffcanvas(event){

        await this.app.initLocal({
            path: '/js/NewObject.js',
            target: '.offcanvas',
            params: {
                label: "Editar Arquivo",
                event: event
            }
        });
    }

    async update(noNotify){
        let tabId = document.querySelector('button.nav-link.active');
        if(!tabId) return false;
        tabId = tabId.id.replace('-tab', '');
        let id = document.querySelector('button.nav-link.active').getAttribute('data-id');
        let label = '';
        let file = this.files.filter(item => item.id == id);
        let dragulaPanel = document.querySelector(`#dragulaPanel-${id}`);

        if(id=='TAB_DB'){
            label = 'Query ';
            let code = '';
            for(let i in monaco.editor.getEditors()){
                if(monaco.editor.getEditors()[i]._domElement.getAttribute('id') == 'editorQuery'){
                    code = monaco.editor.getEditors()[i].getModel().getValue();
                }
            }
            let query = {
                id: document.querySelector('#hdnQueryId').value,
                updated_by: '1',
                query: code
            };
            await this.app.service.executeByPath({
                path:'/studio/backend/service/DBService.mjs',
                name:'DBService',
                execFunction: 'updateQuery',
                sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
                params: query
            });
        }else if(file[0]?.typeFile=='HTML' && dragulaPanel){
            label = file[0].name;
            file[0].code = dragulaPanel.innerHTML;
            await this.app.service.update(file[0], id);
        }else{ 
            label = file[0].name;
            for(let i in monaco.editor.getEditors()){
                if(monaco.editor.getEditors()[i]._domElement.getAttribute('id') == tabId){
                    file[0].code = monaco.editor.getEditors()[i].getModel().getValue();
                }
            }
            await this.app.service.update(file[0], id);
        }
        
        this.removeRecWarning(document.querySelector(`#pills-${id}-tab`));
        if(!noNotify) this.app.notyf.success(`${label} atualizado com sucesso!`);
    }

    async initEditor(container, language) {
 
        if(language=='js'){
            language = 'javascript';
        }
        
        if(!window.monaco){
            await this.loadMonaco();
        }

        this.editor = monaco.editor.create(container, {
            value: '',
            language: language,
            automaticLayout: true,
            minimap: { enabled: true },
            stickyScroll: { enabled: false }
        });

        const resizeObserver = new ResizeObserver(() => {
            if (this.editor) {
                this.editor.layout();
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
        container.appendChild(this.editor.getDomNode());
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

    setRecWarning(button){
        let badge = `
            <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle">
                <span class="visually-hidden">New alerts</span>
            </span>`;
        button.insertAdjacentHTML('beforeend', badge);
    }

    removeRecWarning(button){
        let span = button.querySelector('span.position-absolute');
        if(span){
            span.remove();
        }
    }

    async loadAppTab(item){

        if( document.querySelector(`.nav-item button[data-id="${item.id}"]`) ){
            const tabfirstChild = document.querySelector(`.nav-item button[data-id="${item.id}"]`);
            if(tabfirstChild){
                let bsTab = new bootstrap.Tab(tabfirstChild);
                    bsTab.show();
            }
            return false;
        }             
        //SE NAO, CRIA A ABA
        let tab = `
            <li class="nav-item" role="presentation">                            
                <button 
                    data-id="${item.id}" 
                    class="nav-link position-relative" 
                    id="pills-${item.id}-tab" 
                    data-bs-toggle="pill" 
                    data-bs-target="#pills-${item.id}" 
                    type="button" 
                    role="tab" 
                    aria-controls="pills-${item.id}" 
                    aria-selected="true">
                    <i class="bi ${item.icon} me-2"></i>
                    <span>${item.label}</span>
                    <i class="bi bi-x ms-2"></i>
                </button>
            </li>`;

        let pane = `<div class="tab-pane fade" id="pills-${item.id}" role="tabpanel" aria-labelledby="pills-${item.id}-tab" tabindex="0"></div>`;

        document.querySelector('#pills-tab').insertAdjacentHTML('beforeend', tab);
        document.querySelector('#pills-tabContent').insertAdjacentHTML('beforeend', pane);

        document.querySelector(`#pills-${item.id}`).style.width = `${document.querySelector('#deep-main').offsetWidth}px`;
        document.querySelector(`.deep-bradcrumbs span`).textContent = '';

        //APÓS CRIAR A ABA, ABRE A ABA
        const navTab = new bootstrap.Tab(document.querySelector(`#pills-${item.id}-tab`));
              navTab.show();
        //EVENTO DE ALTERACAO DE ABA, ALTERA O CAMINHO NO BREADCRUMBS
        const tabEl = document.querySelector(`button[data-bs-target="#pills-${item.id}"`);
        tabEl.addEventListener('shown.bs.tab', event => {
            document.querySelector(`.deep-bradcrumbs span`).textContent = '';
        });

        await this.app.initLocal({
            path: item.path,
            target: `#pills-${item.id}`,
            css: item.css || false,
            params: item.params || {}
        });

    }

    async newTab(path){
        //CARREGA DADOS DO ARQUIVO
        let item = await this.app.service.findByPath(path);
        this.files.push(item);
        //SE ARQUIVO JA ESTIVER ABERTO, ABRE A ABA        
        if( document.querySelector(`.nav-item button[data-id="${item.id}"]`) ){
            const tabfirstChild = document.querySelector(`.nav-item button[data-id="${item.id}"]`);
            if(tabfirstChild){
                let bsTab = new bootstrap.Tab(tabfirstChild);
                    bsTab.show();
            }
            return false;
        }             
        //SE NAO, CRIA A ABA
        let tab = `
            <li class="nav-item" role="presentation">                            
                <button 
                    data-id="${item.id}" 
                    data-name="${item.name}" 
                    data-language="${item.language}" 
                    data-type="${item.typeFile}" 
                    data-path="${item.path}" 
                    class="nav-link position-relative" 
                    id="pills-${item.id}-tab" 
                    data-bs-toggle="pill" 
                    data-bs-target="#pills-${item.id}" 
                    type="button" 
                    role="tab" 
                    aria-controls="pills-${item.id}" 
                    aria-selected="true">
                    <i class="bi bi-${this.getIcon(item.language)} me-2"></i>
                    <span>${item.name}</span>
                    <i class="bi bi-x ms-2"></i>
                </button>
            </li>`;

        let pane = `<div class="tab-pane fade" id="pills-${item.id}" role="tabpanel" aria-labelledby="pills-${item.id}-tab" tabindex="0">
                //EDITOR//
            </div>`;

        document.querySelector('#pills-tab').insertAdjacentHTML('beforeend', tab);
        document.querySelector('#pills-tabContent').insertAdjacentHTML('beforeend', pane);

        document.querySelector(`#pills-${item.id}`).style.width = `${document.querySelector('#deep-main').offsetWidth}px`;

        let breadcrumbs = document.querySelector(`.deep-bradcrumbs span`);
            breadcrumbs.textContent = item.path;
            breadcrumbs.setAttribute('data-type', item.typeFile);
            breadcrumbs.setAttribute('data-language', item.language);
            breadcrumbs.setAttribute('data-path', item.path);
            breadcrumbs.setAttribute('data-name', item.name);
            breadcrumbs.setAttribute('data-id', item.id);

        //CARREGA EDITOR
        await this.initEditor(document.querySelector(`#pills-${item.id}`), item.language);
        this.editor.setValue(item.code);
        //EVENTO DE ALTERACAO DE CONTEUDO, ALERTA SOBRE CONTEUDO AINDA NÃO SALVO
        this.editor.getModel().onDidChangeContent((event) => {
            let button = document.querySelector(`#pills-${item.id}-tab`);
            if(!button.querySelector('span.position-absolute'))
            this.setRecWarning(button);
        });
        //APÓS CRIAR A ABA, ABRE A ABA
        const navTab = new bootstrap.Tab(document.querySelector(`#pills-${item.id}-tab`));
              navTab.show();
        //EVENTO DE ALTERACAO DE ABA, ALTERA O CAMINHO NO BREADCRUMBS
        const tabEl = document.querySelector(`button[data-bs-target="#pills-${item.id}"`);
        tabEl.addEventListener('shown.bs.tab', event => {
            let path = event.target.getAttribute('data-path');
            let name = event.target.textContent;
            let breadcrumbs = document.querySelector(`.deep-bradcrumbs span`);
                breadcrumbs.textContent = item.path;
                breadcrumbs.setAttribute('data-type', item.typeFile);
                breadcrumbs.setAttribute('data-path', item.path);
                breadcrumbs.setAttribute('data-language', item.language);
                breadcrumbs.setAttribute('data-name', item.name);
                breadcrumbs.setAttribute('data-id', item.id);
        });

        Sortable.create(document.querySelector('#pills-tab'),{});
    }

    closeTab(button){

        //let button = event.target.closest('button');
        let badge = button.querySelector('span.position-absolute');
        if(badge){
            if(confirm("Deseja salvar as alterações neste arquivo?")){
                this.update();
            }
        }

        document.querySelector(`.deep-bradcrumbs span`).textContent = '';

        let idTab = button.getAttribute('id');
        let bsTab = new bootstrap.Tab(`#${idTab}`);
        let idPanel = bsTab._config.target;
            bsTab.dispose();
            document.querySelector(`#${idTab}`).remove();
            document.querySelector(idPanel).remove();

        const tabfirstChild = document.querySelector(`#pills-tab > li > button`);
        if(tabfirstChild){
            let bsTab1 = new bootstrap.Tab(tabfirstChild);
                bsTab1.show();
        }
    }

    async visualHtml(event){

        let tab = document.querySelector('button.nav-link.active');
        if(!tab || tab.getAttribute('data-type')!='HTML') return false;
        let button = document.querySelector('button.nav-link.active');
        let id = button.getAttribute('data-id');
        let file = this.files.filter(item => item.id == id);
        let dragulaPanel = document.querySelector(`#dragulaPanel-${id}`);

        if(file[0].typeFile=='HTML' && dragulaPanel){                
            file[0].code = dragulaPanel.innerHTML;
            await this.update("NoNotify");
            dragulaPanel.remove();
            await this.initEditor(document.querySelector(`#pills-${file[0].id}`), file[0].language);
            this.editor.setValue(file[0].code);
            this.editor.getModel().onDidChangeContent((event) => {
                if(!button.querySelector('span.position-absolute'))
                this.setRecWarning(button);
            });
        }else{       
            for(let i in monaco.editor.getEditors()){
                if(monaco.editor.getEditors()[i]._domElement.getAttribute('id') == `pills-${file[0].id}`){
                    file[0].code = monaco.editor.getEditors()[i].getModel().getValue();
                    monaco.editor.getEditors()[i].dispose();
                    document.querySelector(`#pills-${file[0].id}`).innerHTML = '';
                }
            }
            await this.update("NoNotify");
            await this.app.initLocal({
                path: '/js/WYSIWYG.js',
                target: `#pills-${id}`,
                css: true,
                params: file[0]
            });
        }
    }

    async events(){  

        document.querySelector('#btnAsideSearch').addEventListener('click', async () => {
            this.loadAppTab({
                id: 'SEARCH',
                label: 'Advanced Serach',
                path: '/js/Search.js',
                icon: 'bi-search'
            });
        });
        
        document.querySelector('#btnAsideRestClient').addEventListener('click', (event) => {
            this.loadAppTab({
                id: 'REST_API',
                label: 'Rest Client',
                path: '/js/RestClient.js',
                icon: 'bi-braces'
            });
        });

        document.querySelector('#btnAsideDBClient').addEventListener('click', (event) => {
            this.loadAppTab({
                id: 'TAB_DB',
                label: 'Database',
                path: '/js/database/Database.js',
                icon: 'bi-database',
                css: true
            });
        });        

        document.querySelector('#pills-tab').addEventListener('click', (event) => {
            if(event.target.classList.contains('bi-x')){
                let obj = event.target.closest('button');
                this.closeTab(obj);
            }
        });

        document.querySelector('#btnAddFile').addEventListener('click', async(event)=>{
            await this.app.initLocal({
                path: '/js/NewObject.js',
                target: '.offcanvas',
                params: {label: "Novo Arquivo"}
            });
        });

        document.querySelector('.deep-bradcrumbs span').addEventListener('click', (event) => {
            this.showOffcanvas(event);
        });

        document.querySelector('#btnFileBarSave').addEventListener('click', async (event) => {
            await this.update();
        });

        document.addEventListener('keydown', async (event) => {
            if (event.ctrlKey && event.key === 's') {                
                event.preventDefault();
                await this.update();
            }
        });

        document.querySelector('#btnFileBarVisualHtml').addEventListener('click', async (event) => {
            let tabId = document.querySelector('button.nav-link.active');
            if(tabId || tabId.getAttribute('data-type')=='HTML'){
                this.visualHtml(event);
            }else if(tabId || tabId.getAttribute('data-type')=='JS'){
                //TODO: TESTAR SE EXISTE FUNCTION TEMPLATE NO ARQUIVO JS
                //      SE EXISTIR, ENVIA O TEMPLATE PARA EDIÇÃO via WYSIWYG
                //      ATENÇÃO PARA MECANISMO DE "SAVE"
            }
        });

        document.querySelector('#btnBarConfiguration').addEventListener('click', async (event) => {
            await this.app.initLocal({
                path: '/js/Sample.js',
                target: '.modal',
                params: {
                    label: 'SAMPLES',
                    size: 'modal-xl'
                }
            });
        });
    }
}