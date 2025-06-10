export class Folder {

    constructor(app){
        this.app = app;
        this.files = [];
        this.editor = null;
    }

    template(){
        return `<ul class="deep-list mt-3 ps-2" id="scriptList"></ul>`;
    }

    async init(){
        await this.loadFiles();
        await this.events();
    }

    async loadFiles(){
        this.files = await this.app.service.findAll();
        this.files.forEach(element => {
            let li = `
            <li class="deep-txt" data-id="${element.id}"  data-type="${element.typeFile}">
                <i class="bi bi-${element.typeFile} ms-2 me-2"></i>
                <span>${element.location}.${element.name}</span>
            </li>`;
            document.querySelector('#scriptList').insertAdjacentHTML('beforeend', li);
        });
    }

    async events(){

        document.querySelector('#btnSaveNewFile').addEventListener('click', async(event)=>{
            this.save();
        });

        document.querySelector('#btnCancelNewFile').addEventListener('click', () => {
            this.cancel();
        });

        document.querySelector('#btnClearNewFile').addEventListener('click', () => {
            this.clean();
        });

        document.querySelector('#scriptList').addEventListener('click', async(event) => {
            if(event.target.closest('li').hasAttribute('data-id') && event.target.closest('li').hasAttribute('data-type')){
                this.newTab(event.target.closest('li').getAttribute('data-id'));
            }
        });

        document.addEventListener('keydown', async (event) => {
            
            if (event.ctrlKey && event.key === 's') {                
                event.preventDefault();
                await this.update();
            }
        });

        document.querySelector('#pills-tab').addEventListener('click', (event) => {
            if(event.target.classList.contains('bi-x')){
                this.closeTab(event);
            }
        });
    }

    async update(){

        let tabId = document.querySelector('button.nav-link.active').id.replace('-tab', '');
        let id = document.querySelector('button.nav-link.active').getAttribute('data-id');
        let file = this.files.filter(item => item.id == id);
        for(let i in monaco.editor.getEditors()){
            if(monaco.editor.getEditors()[i]._domElement.getAttribute('id') == tabId){
                file[0].code = monaco.editor.getEditors()[i].getModel().getValue();
            }
        }
        await this.app.service.update(id, file[0]);
    }

    cancel(){
        document.querySelector('#typeFile').value = '';
        document.querySelector('#location').value = '';
        document.querySelector('#fileName').value = '';
        document.querySelector('#inDebugger').checked = false;
        document.querySelector('#btnNewFile').click();
    }

    clean(){
        document.querySelector('#typeFile').value = '';
        document.querySelector('#location').value = '';
        document.querySelector('#fileName').value = '';
        document.querySelector('#inDebugger').checked = false;
    }

    async save(){

        let file = {
            typeFile: document.querySelector('#typeFile').value,
            location: document.querySelector('#location').value,
            name: document.querySelector('#fileName').value,
            inDebugger: document.querySelector('#inDebugger').checked,
            code: ''
        };

        await this.app.service.save(file);
    }

    async initEditor(container) {
        // Configuração do Monaco Editor
        await this.loadMonaco();

        this.editor = monaco.editor.create(container, {
            value: '',
            language: 'javascript',
            automaticLayout: true,
            minimap: { enabled: false }
        });

        fetch('/js/dracula.json')
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

            require.config({ paths: { vs: 'https://cdn.jsdelivr.net/npm/monaco-editor@0.40.0/min/vs' } });
            require(['vs/editor/editor.main'], resolve);
        });
    }

    async newTab(id){

        let item = await this.app.service.findById(id);

        let tab = `
            <li class="nav-item" role="presentation">                            
                <button data-id="${item.id}" data-type="${item.typeFile}" data-location="${item.location}" class="nav-link" id="pills-${item.id}-tab" data-bs-toggle="pill" data-bs-target="#pills-${item.id}" type="button" role="tab" aria-controls="pills-${item.id}" aria-selected="true">
                    <i class="bi bi-${item.typeFile} me-2"></i>
                    <span>${item.name}</span>
                    <i class="bi bi-x ms-2"></i>
                </button>
            </li>`;

        let pane = `<div class="tab-pane fade" id="pills-${item.id}" role="tabpanel" aria-labelledby="pills-${item.id}-tab" tabindex="0">
                //EDITOR//
            </div>`;

        document.querySelector('#pills-tab').insertAdjacentHTML('beforeend', tab);
        document.querySelector('#pills-tabContent').insertAdjacentHTML('beforeend', pane);
        document.querySelector(`.deep-bradcrumbs span`).textContent = item.location+"."+item.name;

        await this.initEditor(document.querySelector(`#pills-${item.id}`));
        this.editor.setValue(item.code);

        const navTab = new bootstrap.Tab(document.querySelector(`#pills-${item.id}-tab`));
              navTab.show();

        const tabEl = document.querySelector(`button[data-bs-target="#pills-${item.id}"`);
        tabEl.addEventListener('shown.bs.tab', event => {
            let location = event.target.getAttribute('data-location');
            let name = event.target.textContent;
            document.querySelector(`.deep-bradcrumbs span`).textContent = location+"."+name;
        });

    }

    closeTab(event){
        
        if(!confirm("Deseja realmente fechar este item?")) return;

        document.querySelector(`.deep-bradcrumbs span`).textContent = '';

        let idTab = event.target.closest('button').getAttribute('id');
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
}