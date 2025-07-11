INSERT INTO public.js_scripts ("location",name,"path",type_file,"language",init_function_name,code) VALUES
	 ('','Home','/crmp6/frontend/Home.js','JAVASCRIPT','js',NULL,'/*JAVASCRIPT | /crmp6/frontend/Home.js*/
export class Home {

    constructor(app) {
        this.app = app;
    }

    template() {
        return `
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h5><i class="bi bi-house"></i> Home...</h5>
                </div>
            </div>
        </div>`;
    }
}'),
	 ('','layout','/crmp6/frontend/layout.css','CSS','css',NULL,'/*CSS | /crmp6/frontend/layout.css*/
.dp {
    display: grid;
    gap: 5px;
    grid-template-rows: 44px calc(100vh - (44px + 5px));
    grid-template-columns: 44px calc(100vw - (44px + (5px + 5px + 5px)));
    grid-template-areas: "dp-header dp-header"
                         "dp-aside dp-main";
    overflow: hidden;
    background: var(--bs-gray-200);
}
.dp-header {
    grid-area: dp-header;
}
.dp-aside {
    grid-area: dp-aside;
    display: flex;
    flex-direction: column;
}
.dp-aside button {
    margin-left: 5px;
    margin-bottom: 5px;
}
.dp-main {
    grid-area: dp-main;
    background-color: var(--bs-body-bg);
    border-radius: 6px;
    border: 1px solid var(--bs-border-color);
    margin-bottom: 5px;
    font-size: 0.85rem;
}
.dp-main .row{
    padding-bottom: 8px;
}
.btn-dp-aside {
    background-color: transparent;
    border: 1px solid transparent;
    color: var(--dp-color-1);
}
.btn-dp-aside:active,
.btn-dp-aside:focus {
    background-color: var(--bs-border-color);
    border: 1px solid var(--bs-border-color);
}
.btn-dp-aside:hover {
    background-color: var(--bs-border-color);
    border: 1px solid var(--bs-border-color);
}
#appOffCanvas .offcanvas-header,
#appOffCanvas .offcanvas-body {
    background-color: #E9ECEF;
    padding: 0.4rem 0.75rem;
}

#dt-length-0 {
    margin-right: 10px;
}
#dt-search-0{
    margin-left: 10px;
}

.span {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
'),
	 ('','ComsumersService','/crmp6/backend/service/ConsumersService.mjs','SERVICE','js',NULL,'/*SERVICE | /crmp6/backend/ConsumersService.mjs*/
export class ConsumersService {

	async init(params){

		const sql = `SELECT cpf_cnpj, data_nascimento, email_principal, empresa, nome_razao_social, tel_celular_principal FROM pessoa WHERE pessoa_id = ?`;

        let wrGet = {
            values: [params.pessoa_id],
            types: ["Long"]
	    };

		const rsGet = {
            values: ["cpf_cnpj", "data_nascimento", "email_principal", "empresa", "nome_razao_social", "tel_celular_principal"],
            types: ["String", "Date", "String", "String", "String", "String"]
	    };

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.select(sql, wrGet, rsGet, true);
	}
}'),
	 ('','Layout','/crmp6/frontend/Layout.js','JAVASCRIPT','js',NULL,'/*JAVASCRIPT | /crmp6/frontend/Layout.js*/
export class Layout {

    constructor(app) {
        this.app = app;
    }

    template(){
        return `
        <div class="dp">
            <div class="dp-header d-flex">                
                <header class="d-flex align-items-center justify-content-center justify-content-md-between" style="width:100%"> 
                    <div class="d-flex align-items-center">
                        <a class="navbar-brand" style="margin: 6px 8px">
                            <img src="/images/plusoft-gray.png" style="height:30px;margin:2px 0px 0px 0px;border-radius:6px" alt="Deep">
                        </a>                    
                        <div class="d-flex" id="navbarsHeader">                         
                            <ul class="nav col-12 col-md-auto ms-4 mb-2 justify-content-center mb-md-0"> 
                                <li class="nav-item dropdown">
                                    <button class="btn btn-sm dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">Reports</button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item dropdown">
                                    <button class="btn btn-sm dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">More</button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    </ul>
                                </li> 
                            </ul> 
                        </div>
                    </div>                    
                    <form class="d-flex me-3" style="width:33%">
                        <input type="text" class="form-control form-control-sm" id="txtSearch" placeholder="Search">
                    </form>
                    <div class="me-2">
                        <button id="btnBarHelp" type="button" class="btn btn-sm" style="padding: 3px 6px">
                            <i class="bi bi-question-circle"></i>
                        </button>
                        <button id="btnBarConfiguration" type="button" class="btn btn-sm" style="padding: 3px 6px">
                            <i class="bi bi-gear"></i>
                        </button>
                    </div> 
                </header>
            </div>
            <div class="dp-aside">        
                <button id="btnAsideHome" type="button" class="btn btn-sm btn-deep-aside" style="border-radius:4px">
                    <i class="bi bi-house"></i>
                </button>
                <button id="btnAsideLeads" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-people"></i>
                </button>
                <button id="btnAsideConsumers" type="button" class="btn btn-sm btn-deep-aside mb-4">
                    <i class="bi bi-person"></i>
                </button>
                <button id="btnAsideProposals" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-clipboard2-check"></i>
                </button>
                <button id="btnAsideInvoices" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-cash-coin"></i>
                </button>
                <button id="btnAsideItens" type="button" class="btn btn-sm btn-deep-aside mb-4">
                    <i class="bi bi-cart4"></i>
                </button>      
                <button id="btnAsideMail" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-envelope-open"></i>
                </button>
                <button id="btnAsideCalendar" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-calendar3"></i>
                </button>
                <button id="btnAsideBarChart" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-bar-chart"></i>
                </button>
            </div>
            <div class="dp-main px-3 py-3" style="overflow:auto">agrsaefaaafa</div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="appModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="appModalLabel">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title fs-5" id="appModalLabel"></h6>
                        <button type="button" class="btn-close closeModal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body"></div>
                </div>
            </div>
        </div>

        <!-- OffCanvas -->
        <div class="offcanvas offcanvas-end" tabindex="-1" id="appOffCanvas" aria-labelledby="appOffCanvasLabel" data-bs-backdrop="static">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="appOffCanvasLabel">Change Label</h5>
                <button id="appOffCanvasClose" type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">...</div>
        </div>`;
    }

    async init() {        
        //await this.setHome();
        await this.events();
    }

    async setHome(){
        await this.app.init({   
            path: ''/crmp6/frontend/Home.js'',
            name: ''Home.'',
            target: ''.dp-main''
        });     
    }

    async setLeads(){
        await this.app.init({
            path: ''/crmp6/frontend/Leads.js'',
            name: ''Leads.'',
            target: ''.dp-main''
        });
    }

    async setConsumers(){
        await this.app.init({
            path: ''/crmp6/frontend/Consumers.js'',
            name: ''Consumers.'',
            target: ''.dp-main''
        });
    }

    async setGemini(){
        await this.app.init({
            path: ''/crmp6/frontend/Gemini.js'',
            name: ''Gemini.'',
            target: ''.dp-main''
        });
    }

    async showModal(){
        await this.app.init({
            path: ''/crmp6/frontend/Consumers.js'',
            name: ''Consumers.'',
            target: ''.modal'',
            params: {
                label: ''<i class="bi bi-person"></i> CONSUMERS'', 
                size: ''modal-xl''
            }
        });
    }

    async showOffcanvas(event){       
        await this.app.init({
            path: ''/crmp6/frontend/Leads.js'',
            name: ''Leads.'',
            target: ''.offcanvas'',
            params: {
                label: "Leads",
                event: event
            }
        });
    }

    async events() {        

        document.querySelector(''#btnBarConfiguration'').addEventListener(''click'', async (event)=>{
            await this.showOffcanvas(event);
        });  
        document.querySelector(''#btnAsideLeads'').addEventListener(''click'', async (event)=>{
            await this.setLeads();
        });  
        document.querySelector(''#btnAsideConsumers'').addEventListener(''click'', async (event)=>{
            await this.setConsumers();
        });
        document.querySelector(''#btnAsideProposals'').addEventListener(''click'', async (event)=>{
            await this.setGemini();
        }); 
        document.querySelector(''#btnAsideHome'').addEventListener(''click'', async (event)=>{
            await this.setHome();
        });  

        document.querySelector(''#btnBarHelp'').addEventListener(''click'', async (event) => {
            await this.showModal();
        });    
    }
}  '),
	 ('','Leads','/crmp6/frontend/Leads.js','JAVASCRIPT','js',NULL,'/*JAVASCRIPT | /crmp6/frontend/Leads.js*/
export class Leads {

    constructor(app) {
        this.app = app;
    }

    template() {
        return `
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <h5><i class="bi bi-people"></i> Leads...</h5>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table id="example" class="display compact nowrap" width="100%"></table>
                    </div>
                </div>
            </div>
        </div>`;
    }

    async init(){
        //DEBUGGER: devtools://devtools/bundled/js_app.html?ws=127.0.0.1:9229/d015d1bf-81dc-4f23-b9de-755bcb882123
        this.app.spinnerOn();
        this.data = await this.app.service.executeByPath({
            path:''/crmp6/backend/service/LeadsService.mjs'',
            name:''LeadsService'',
            execFunction: ''init'',
            sessionId: ''d015d1bf-81dc-4f23-b9de-755bcb882123'',
            params: {}
        });

        let dataSet = [];        
        if(this.data?.result) {
            for(let data of JSON.parse(this.data.result)){
                let item = [data.id, data.userId, data.title, data.body];
                dataSet.push(item);
            }
        }

        new DataTable(''#example'', {
            lengthMenu: [5, 10, 25, 50, -1],
            data: dataSet,
            columns: [
                { title: ''Id'',  width: ''80px'', className: ''span'' },
                { title: ''user Id'', width: ''80px'', className: ''span'' },
                { title: ''Title'' , width: ''400px'', render: DataTable.render.ellipsis( 60 ) },
                { title: ''Body'', render: DataTable.render.ellipsis( 180 )}
            ]
        });
        this.app.spinnerOff(); 
    }
}'),
	 ('','Consumers','/crmp6/frontend/Consumers.js','JAVASCRIPT','js',NULL,'/*JAVASCRIPT | /crmp6/frontend/Consumers.js*/
export class Consumers {

    constructor(app) {
        this.app = app;
    }

    async init(){
        //DEBUGGER: devtools://devtools/bundled/js_app.html?ws=127.0.0.1:9229/c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8
        this.data = await this.app.service.executeByPath({
            path:''/crmp6/backend/service/ConsumersService.mjs'',
            name:''ConsumersService'',
            execFunction: ''init'',
            sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
            params: {"pessoa_id": "1"}
        });

        for(let i in this.data.resultList) {
            document.querySelector(''#cpf_cnpj'').value = this.data.resultList[i]?.cpf_cnpj;
            document.querySelector(''#data_nascimento'').value = this.data.resultList[i]?.data_nascimento;
            document.querySelector(''#email_principal'').value = this.data.resultList[i]?.email_principal;
            document.querySelector(''#empresa'').value = this.data.resultList[i]?.empresa;
            document.querySelector(''#nome_razao_social'').value = this.data.resultList[i]?.nome_razao_social;
            document.querySelector(''#tel_celular_principal'').value = this.data.resultList[i]?.tel_celular_principal;
        }
    }
}'),
	 ('','databasecontroller','/studio/frontend/database/databasecontroller.css','CSS','css',NULL,'#gridDB {
    /*display: grid;
    gap: 8px;
    grid-template-rows: calc(100vh - 165px);
    grid-template-columns: 1fr 350px;
    grid-template-areas: "mainDB asideDB";*/
    width: 100%;
    height: calc(100vh - 162px);
    overflow: hidden;
    padding: 0px 8px;
}

#mainDB {
    /*grid-area: mainDB;*/
    border-radius: var(--deep-border-radius);
    border: var(--deep-border);
    height: calc(100vh - 162px);
    overflow-y: auto;
}

#asideDB {
    /*grid-area: asideDB;*/
    position: relative;
    height: calc(100vh - 162px);
    border-radius: var(--deep-border-radius);
    border: var(--deep-border);
    background-color: #21222C;
    overflow-x: auto;
}

#panelSerachDB {
    position: relative;
    padding: 5px;
    min-width: 200px;
}

#listDB {
    padding: 6px;
    color: #FFF;
}

td.editor-edit i,
td.editor-delete i {
    cursor: pointer;
}'),
	 ('','consumers','/crmp6/frontend/consumers.html','HTML','html',NULL,'<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h5><i class="bi bi-person"></i> Consumers...</h5>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="nome_razao_social" class"form-label">Nome/Razão Social</label>
            <input type="text" class="form-control form-control-sm" id="nome_razao_social" readonly />
        </div>
        <div class="col-md-4">
            <label for="data_nascimento" class"form-label">Nascimento</label>
            <input type="text" class="form-control form-control-sm" id="data_nascimento" readonly />
        </div>

        <div class="col-md-4">
            <label for="empresa" class"form-label">Empresa</label>
            <input type="text" class="form-control form-control-sm" id="empresa" readonly />
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label for="cpf_cnpj" class"form-label">CPF/CNPJ</label>
            <input type="text" class="form-control form-control-sm" id="cpf_cnpj" readonly />
        </div>
        <div class="col-md-4">
            <label for="email_principal" class"form-label">E-mail</label>
            <input type="text" class="form-control form-control-sm" id="email_principal" readonly />
        </div>
        <div class="col-md-4">
            <label for="tel_celular_principal" class"form-label">celular</label>
            <input type="text" class="form-control form-control-sm" id="tel_celular_principal" readonly />
        </div>
    </div>
</div>'),
	 ('','Studio','/studio/frontend/Studio.js','JAVASCRIPT','js',NULL,'import Split from ''http://localhost:3000/assets/split.js/dist/split.es.js'';

export class Studio {

    constructor(app){
        this.app = app;     
    }

    template(){
        return `
        <div class="deep">
            <div class="deep-header d-flex">  
                <a class="navbar-brand" style="margin: 6px 8px">
                    <img src="/images/logos.png" style="height:30px;margin:2px 0px 0px 0px;border-radius:6px" alt="Deep">
                </a>             
                <header class="d-flex align-items-center justify-content-center justify-content-md-between" style="width:100%">                     
                    <div class="d-flex" id="navbarsHeader">                         
                        <!--ul class="nav col-12 col-md-auto ms-4 mb-2 justify-content-center mb-md-0"> 
                            <li class="nav-item dropdown">
                                <button class="btn btn-sm dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">File</button>
                                <ul class="dropdown-menu dropdown-menu-dark">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item" href="#">Another action</a></li>
                                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <button class="btn btn-sm dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">Edit</button>
                                <ul class="dropdown-menu dropdown-menu-dark">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item" href="#">Another action</a></li>
                                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                                </ul>
                            </li> 
                        </ul--> 
                    </div>                    
                    <form class="d-flex me-3" style="width:33%">
                        <button id="btnArrowLeft" type="button" class="btn btn-sm" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Go back" style="padding: 3px 6px">
                            <i class="bi bi-arrow-left"></i>
                        </button>
                        <button id="btnArrowRight" type="button" class="btn btn-sm me-2" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Go forward" style="padding: 3px 6px">
                            <i class="bi bi-arrow-right"></i>
                        </button>
                        <input type="text" class="form-control form-control-sm" id="txtSearch" placeholder="Search" />
                    </form>
                    <div class="me-2">
                        <button id="btnFileBarVisualHtml" type="button" class="btn btn-sm" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Visual HTML" style="padding: 3px 6px">
                            <i class="bi bi-filetype-html"></i>
                        </button>
                        <button id="btnFileBarSave" type="button" class="btn btn-sm" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Save" style="padding: 3px 6px">
                            <i class="bi bi-floppy-fill"></i>
                        </button>
                        <button id="btnBarConfiguration" type="button" class="btn btn-sm" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Configuration" style="padding: 3px 6px">
                            <i class="bi bi-gear"></i>
                        </button>
                    </div> 
                </header>
            </div>
            <div class="deep-aside mt-2">               
                <button id="btnAsideSearch" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-search"></i>
                </button>
                <button id="btnAsideFolder" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-folder-fill"></i>
                </button>                
                <button  id="btnAsideDBClient" type="button" class="btn btn-sm btn-deep-aside" style="border-radius:4px">
                    <i class="bi bi-database"></i>
                </button>
                <button  id="btnAsideRestClient" type="button" class="btn btn-sm btn-deep-aside" style="border-radius:4px">
                    <i class="bi bi-braces"></i>
                </button>
            </div>
            <div class="deep-principal split">
                <div id="deep-expector"></div>
                <div id="deep-main">
                    <div class="deep-tabs" style="padding-left: 2px">
                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist"></ul>
                    </div>
                    <div class="deep-bradcrumbs style="padding-left: 30px">
                        <span id="txtBradcrumbs" style="max-width: fit-content;"></span>
                    </div>
                    <div class="deep-editors">
                        <div class="tab-content" id="pills-tabContent"></div>
                    </div>
                </div>
            </div>
            <div class="deep-footer"></div>
        </div>`;
    }

    async init(){  
         
        let that = this;
        await this.setFolder(); 

        Split([''#deep-expector'', ''#deep-main''], {
            gutterSize: 8,
            minSize: 0,
            sizes: [15, 85],
            onDrag: function (sizes) { 
                that.resizeHandler();
            }
        });

        this.events();
    }

    async setFolder(){
        //await this.app.initLocal({
        //    path: ''/js/Folder.js'',
        //    target: ''#deep-expector''
        //});
        await this.app.init({  
            path: ''/studio/frontend/StudioController.js'',
            name:''StudioController.'',
            target: ''#deep-expector''
        });
    }

    resizeHandler(){
        document.querySelector(''#pills-tabContent'').style.width = `${document.querySelector(''#deep-main'').offsetWidth}px`;
        document.querySelectorAll(''#pills-tabContent div.tab-pane'').forEach(item => {
            item.style.width = `${document.querySelector(''#deep-main'').offsetWidth - 12}px`;
        });
        document.querySelectorAll(''#pills-tabContent div.tab-pane div.monaco-editor'').forEach(item => {
            item.style.width = `${document.querySelector(''#deep-main'').offsetWidth - 12}px`;
        });
        document.querySelectorAll(''div.dragula-panel'').forEach(item => {
            item.style.width = `${document.querySelector(''#deep-main'').offsetWidth - 12}px`;
        });
    }

    events(){ 

        window.removeEventListener(''resize'', this.resizeHandler);
        window.addEventListener(''resize'', this.resizeHandler);
        
        document.querySelector(''#btnAsideFolder'').addEventListener(''click'', async () => {
            //await this.app.initLocal({
            //    path: ''/js/Folder.js'',
            //    target: ''#deep-expector''
            //});
            await this.app.init({  
                path: ''/studio/frontend/StudioController.js'',
                name:''StudioController.'',
                target: ''#deep-expector''
            });
        });

        document.querySelector(''#btnAsideSearch'').addEventListener(''click'', () => {
            console.log(''SEARCH...'');
        });
    }
}'),
	 ('','Row','/studio/frontend/wysiwyg/properties/Row.js','JAVASCRIPT','js',NULL,'export class Row {

    constructor(app, element){
        this.app = app;
        this.element = element;
        this.currentId = element?.getAttribute(''id'') || this.app.utils.uuidv4();
        this.currentClass = element?.getAttribute(''class'') || "";
        this.currentStyle = element?.getAttribute(''style'') || "";
    }

    template(){
        return `
        <div class="container">
            <h5 class="mb-3">Row</h5>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">id</label>
                <div class="col-md-8">
                    <input type="text" class="form-control form-control-sm" id="colId" value="${this.currentId}" readonly>
                </div>
            </div>
            <div class="row mb-2">              
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">class</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control form-control-sm" id="colClass" value="${this.currentClass.replace(''on-active'', '''').trim()}" /> 
                </div>               
            </div>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">style</label>
                <div class="col-md-8">
                    <textarea class="form-control form-control-sm" rows="5" id="colStyle">${this.currentStyle}</textarea>
                </div>
            </div>
        </div>`;
    }

    async init(){
        await this.events();
    }

    async events(){
        document.querySelector(''#colStyle'').addEventListener(''change'', (event) => {
            this.element.setAttribute(''style'', event.target.value);
        });
        document.querySelector(''#colClass'').addEventListener(''change'', (event) => {
            this.element.setAttribute(''class'', event.target.value);
        });
    }
}');
INSERT INTO public.js_scripts ("location",name,"path",type_file,"language",init_function_name,code) VALUES
	 ('','Search','/studio/frontend/Search.js','JAVASCRIPT','js',NULL,'export class Search{

    constructor(app){
        this.app = app
    }

    template(){
        return `
        <div class="row mx-2 g-1">
            <div class="col">                    
                    <input class="form-control form-control-sm" type="text" placeholder="Search">
            </div>
            <div class="col-auto">
                <button type="button" class="btn btn-sm btn-secondary" id="btnMainSearch">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </div>
        <div class="search-result"></div>`;
    }

    init(){
        this.search = document.querySelector(''.search'')
        this.searchInput = document.querySelector(''.search-input'')
        this.searchButton = document.querySelector(''.search-button'')
    }
}'),
	 ('','RestClient','/studio/frontend/RestClient.js','JAVASCRIPT','js',NULL,'export class RestClient {

    constructor(app) {
        this.app = app;
    }

    template() {
        return `
        <div class="container-fluid">
            <div class="row">
                <div class="col-12" style="color:#FFF">
                    <h1 class="text-center">Rest Client</h1>
                    <p class="text-center">This is a placeholder for the Rest Client interface.</p>
                </div>
            </div>
        </div>`;
    }

    async init(){

    }
}'),
	 ('','FormTables','/studio/frontend/database/FormTables.js','JAVASCRIPT','js',NULL,'export class FormTables {

    constructor(app) {
        this.app = app; 
    }

    template() {
        return `
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <input type="text" id="txtAddNewTable" class="form-control form-control-sm" placeholder="Table name...">
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12 text-center">
                    <button id="btnAddNewTable" class="btn btn-sm btn-primary" style="width:30% !important">Save</button>
                </div>
            </div>
        </div>`;
    }

    async init() {  
        this.events();
    }   

    events() {
        document.querySelector(''#btnAddNewTable'').addEventListener(''click'', async (event) => {
            const tableName = document.querySelector(''#txtAddNewTable'').value;
            //await this.app.service.addTable(tableName);
            await this.app.service.executeByPath({
                path:''/studio/backend/service/DBService.mjs'',
                name:''DBService'',
                execFunction: ''insertTable'',
                sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
                params: { "name": tableName }
            });
            this.app.modal.close();
            this.app.notyf.success(''Your changes have been successfully saved!'');
        });
    }
}'),
	 ('','StudioController','/studio/frontend/StudioController.js','JAVASCRIPT','js',NULL,'/******* CUSTOMIZADO NÂO TROCAR DE VERSÃO *******/
import { Treeview } from "http://localhost:3000/assets/quercus.js/dist/treeview.js";

export class StudioController {

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
        let icon = ''file-text'';
        switch (str) {
            case ''js'':
            case ''javascript'':
                icon = ''javascript'';
                break;
            case ''css'':
                icon = ''hash'';
                break;
            case ''html'':
                icon = ''code-slash'';
                break;
        }
        return icon;
    }

    async loadFiles(){

        let result = await this.app.service.executeByPath({
            path:''/studio/backend/service/DBService.mjs'',
            name:''DBService'',
            execFunction: ''buildFileTree'',
            sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
            params: {}
        });

        this.files = result.resultList;

        if(!this.files || this.files.length == 0) return false;

        this.treeViewaFiles = new Treeview({
            containerId: ''treeViewFolder'',
            data: this.files,
            searchEnabled: true,
            initiallyExpanded: true, 
            multiSelectEnabled: false,
            onSelectionChange: (selectedNodesData) => {
                if(selectedNodesData.length > 0 && selectedNodesData[0].type!==''folder''){
                    this.newTab(selectedNodesData[0].path); 
                }           
            },
            onRenderNode: (nodeData, nodeContentWrapperElement) => {
                // Clear existing content if any (important for setData calls)
                nodeContentWrapperElement.innerHTML = '''';
                
                // Create an icon based on node type
                const iconSpan = document.createElement(''span'');
                iconSpan.classList.add(''custom-node-icon''); // Apply custom CSS class for styling
                if (nodeData.type === ''folder'') {
                    iconSpan.innerHTML = ''<i class="bi bi-folder-fill me-2" style="color:#FFD679"></i>'';
                } else if (nodeData.extension === ''js'') {
                    iconSpan.innerHTML = ''<i class="bi bi-javascript ms-2 me-2" style="color:yellow"></i>'';
                } else if (nodeData.extension === ''css'') {
                    iconSpan.innerHTML = ''<i class="bi bi-hash ms-2 me-2"></i>'';
                } else if (nodeData.extension === ''html'') {
                    iconSpan.innerHTML = ''<i class="bi bi-code-slash ms-2 me-2"></i>'';
                } else if (nodeData.extension === ''file'') {
                    iconSpan.innerHTML = ''<i class="bi bi-file-earmark-text ms-2 me-2"></i>'';
                } else if (nodeData.extension === ''image'') {
                    iconSpan.innerHTML = ''<i class="bi bi-file-earmark-image ms-2 me-2"></i>'';
                } else {
                    iconSpan.innerHTML = ''▪<i class="bi bi-file-earmark-x ms-2 me-2"></i>'';
                }
                nodeContentWrapperElement.appendChild(iconSpan);

                // Create a span for the node name
                const nameSpan = document.createElement(''span'');
                nameSpan.classList.add(''treeview-node-text'', ''custom-node-name''); // Keep treeview-node-text for search
                nameSpan.textContent = nodeData.name;
                nodeContentWrapperElement.appendChild(nameSpan);

                // Add a description/status if available
                if (nodeData.description) {
                    const descSpan = document.createElement(''span'');
                    descSpan.classList.add(''custom-node-description'');
                    descSpan.textContent = ` (${nodeData.description})`;
                    nodeContentWrapperElement.appendChild(descSpan);
                } else if (nodeData.status) {
                    const statusSpan = document.createElement(''span'');
                    statusSpan.classList.add(''custom-node-description'');
                    statusSpan.textContent = ` [${nodeData.status}]`;
                    statusSpan.classList.add(nodeData.status === ''active'' ? ''custom-node-status-active'' : ''custom-node-status-inactive'');
                    nodeContentWrapperElement.appendChild(statusSpan);
                } else if (nodeData.size) {
                    const sizeSpan = document.createElement(''span'');
                    sizeSpan.classList.add(''custom-node-description'');
                    sizeSpan.textContent = ` (${nodeData.size})`;
                    nodeContentWrapperElement.appendChild(sizeSpan);
                }
            }
        });

        let btnAddFile = document.createElement(''button'');
            btnAddFile.classList.add(''btn'',''btn-sm'', ''btn-primary'');
            btnAddFile.setAttribute(''id'', ''btnAddFile'');
            btnAddFile.setAttribute(''style'', ''position: absolute; top: 2px; right: 7px; z-index: 1000; padding: 0.23rem 0.5rem !important'');
            btnAddFile.innerHTML = ''<i class="bi bi-plus"></i>'';
            
        document.querySelector(''#treeViewFolder'').classList.add(''position-relative'');
        document.querySelector(''#treeViewFolder'').setAttribute(''style'', ''min-width: 230px;'');
        document.querySelector(''#treeViewFolder'').appendChild(btnAddFile);
    }

    async showOffcanvas(event){

        await this.app.init({  
            path: ''/studio/frontend/FormFiles.js'',
            name:''FormFiles.'',
            target: ''.offcanvas'',
            params: {
                label: "Editar Arquivo",
                event: event
            }
        });
}

    async update(noNotify){
        let tabId = document.querySelector(''button.nav-link.active'');
        if(!tabId) return false;
        tabId = tabId.id.replace(''-tab'', '''');
        let id = document.querySelector(''button.nav-link.active'').getAttribute(''data-id'');
        let label = '''';
        let file = this.files.filter(item => item.id == id);
        let dragulaPanel = document.querySelector(`#dragulaPanel-${id}`);

        if(id==''TAB_DB''){
            label = ''Query '';
            let code = '''';
            for(let i in monaco.editor.getEditors()){
                if(monaco.editor.getEditors()[i]._domElement.getAttribute(''id'') == ''editorQuery''){
                    code = monaco.editor.getEditors()[i].getModel().getValue();
                }
            }
            let query = {
                id: document.querySelector(''#hdnQueryId'').value,
                updated_by: ''1'',
                query: code
            };
            await this.app.service.executeByPath({
                path:''/studio/backend/service/DBService.mjs'',
                name:''DBService'',
                execFunction: ''updateQuery'',
                sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
                params: query
            });
        }else if(file[0].typeFile==''HTML'' && dragulaPanel){
            label = file[0].name;
            file[0].code = dragulaPanel.innerHTML;
            await this.app.service.update(file[0], id);
        }else{ 
            label = file[0].name;
            for(let i in monaco.editor.getEditors()){
                if(monaco.editor.getEditors()[i]._domElement.getAttribute(''id'') == tabId){
                    file[0].code = monaco.editor.getEditors()[i].getModel().getValue();
                }
            }
            await this.app.service.update(file[0], id);
        }
        
        this.removeRecWarning(document.querySelector(`#pills-${id}-tab`));
        if(!noNotify) this.app.notyf.success(`${label} atualizado com sucesso!`);
    }

    async initEditor(container, language) {
 
        if(language==''js''){
            language = ''javascript'';
        }
        
        if(!window.monaco){
            await this.loadMonaco();
        }

        this.editor = monaco.editor.create(container, {
            value: '''',
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
        
        fetch(''/js/themes/Dracula.json'')
            .then(data => data.json())
            .then(data => {
                monaco.editor.defineTheme(''vs-dark'', data);
                monaco.editor.setTheme(''vs-dark'');
            });

        container.innerHTML = '''';
        container.appendChild(this.editor.getDomNode());
    }

    async loadMonaco() {
        return new Promise((resolve) => {
            
            if (window.monaco) {
                resolve();
                return;
            }

            require.config({ paths: { vs: ''https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/min/vs'' } });
            require([''vs/editor/editor.main''], resolve);
        });
    }

    setRecWarning(button){
        let badge = `
            <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle">
                <span class="visually-hidden">New alerts</span>
            </span>`;
        button.insertAdjacentHTML(''beforeend'', badge);
    }

    removeRecWarning(button){
        let span = button.querySelector(''span.position-absolute'');
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

        document.querySelector(''#pills-tab'').insertAdjacentHTML(''beforeend'', tab);
        document.querySelector(''#pills-tabContent'').insertAdjacentHTML(''beforeend'', pane);

        document.querySelector(`#pills-${item.id}`).style.width = `${document.querySelector(''#deep-main'').offsetWidth}px`;
        document.querySelector(`.deep-bradcrumbs span`).textContent = '''';

        //APÓS CRIAR A ABA, ABRE A ABA
        const navTab = new bootstrap.Tab(document.querySelector(`#pills-${item.id}-tab`));
              navTab.show();
        //EVENTO DE ALTERACAO DE ABA, ALTERA O CAMINHO NO BREADCRUMBS
        const tabEl = document.querySelector(`button[data-bs-target="#pills-${item.id}"`);
        tabEl.addEventListener(''shown.bs.tab'', event => {
            document.querySelector(`.deep-bradcrumbs span`).textContent = '''';
        });

        await this.app.init({  
            path: item.path,
            name: `${item.name}.`,
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

        document.querySelector(''#pills-tab'').insertAdjacentHTML(''beforeend'', tab);
        document.querySelector(''#pills-tabContent'').insertAdjacentHTML(''beforeend'', pane);

        document.querySelector(`#pills-${item.id}`).style.width = `${document.querySelector(''#deep-main'').offsetWidth}px`;

        let breadcrumbs = document.querySelector(`.deep-bradcrumbs span`);
            breadcrumbs.textContent = item.path;
            breadcrumbs.setAttribute(''data-type'', item.typeFile);
            breadcrumbs.setAttribute(''data-language'', item.language);
            breadcrumbs.setAttribute(''data-path'', item.path);
            breadcrumbs.setAttribute(''data-name'', item.name);
            breadcrumbs.setAttribute(''data-id'', item.id);

        //CARREGA EDITOR
        await this.initEditor(document.querySelector(`#pills-${item.id}`), item.language);
        this.editor.setValue(item.code);
        //EVENTO DE ALTERACAO DE CONTEUDO, ALERTA SOBRE CONTEUDO AINDA NÃO SALVO
        this.editor.getModel().onDidChangeContent((event) => {
            let button = document.querySelector(`#pills-${item.id}-tab`);
            if(!button.querySelector(''span.position-absolute''))
            this.setRecWarning(button);
        });
        //APÓS CRIAR A ABA, ABRE A ABA
        const navTab = new bootstrap.Tab(document.querySelector(`#pills-${item.id}-tab`));
              navTab.show();
        //EVENTO DE ALTERACAO DE ABA, ALTERA O CAMINHO NO BREADCRUMBS
        const tabEl = document.querySelector(`button[data-bs-target="#pills-${item.id}"`);
        tabEl.addEventListener(''shown.bs.tab'', event => {
            let path = event.target.getAttribute(''data-path'');
            let name = event.target.textContent;
            let breadcrumbs = document.querySelector(`.deep-bradcrumbs span`);
                breadcrumbs.textContent = item.path;
                breadcrumbs.setAttribute(''data-type'', item.typeFile);
                breadcrumbs.setAttribute(''data-path'', item.path);
                breadcrumbs.setAttribute(''data-language'', item.language);
                breadcrumbs.setAttribute(''data-name'', item.name);
                breadcrumbs.setAttribute(''data-id'', item.id);
        });

        Sortable.create(document.querySelector(''#pills-tab''),{});
    }

    closeTab(button){

        //let button = event.target.closest(''button'');
        let badge = button.querySelector(''span.position-absolute'');
        if(badge){
            if(confirm("Deseja salvar as alterações neste arquivo?")){
                this.update();
            }
        }

        document.querySelector(`.deep-bradcrumbs span`).textContent = '''';

        let idTab = button.getAttribute(''id'');
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

        let tab = document.querySelector(''button.nav-link.active'');
        if(!tab || tab.getAttribute(''data-type'')!=''HTML'') return false;
        let button = document.querySelector(''button.nav-link.active'');
        let id = button.getAttribute(''data-id'');
        let file = this.files.filter(item => item.id == id);
        let dragulaPanel = document.querySelector(`#dragulaPanel-${id}`);

        if(file[0].typeFile==''HTML'' && dragulaPanel){                
            file[0].code = dragulaPanel.innerHTML;
            await this.update("NoNotify");
            dragulaPanel.remove();
            await this.initEditor(document.querySelector(`#pills-${file[0].id}`), file[0].language);
            this.editor.setValue(file[0].code);
            this.editor.getModel().onDidChangeContent((event) => {
                if(!button.querySelector(''span.position-absolute''))
                this.setRecWarning(button);
            });
        }else{       
            for(let i in monaco.editor.getEditors()){
                if(monaco.editor.getEditors()[i]._domElement.getAttribute(''id'') == `pills-${file[0].id}`){
                    file[0].code = monaco.editor.getEditors()[i].getModel().getValue();
                    monaco.editor.getEditors()[i].dispose();
                    document.querySelector(`#pills-${file[0].id}`).innerHTML = '''';
                }
            }
            await this.update("NoNotify");

            await this.app.init({  
                path: ''/studio/frontend/wysiwyg/WYSIWYG.js'',
                name:''WYSIWYG.'',
                target: `#pills-${id}`,
                css: true,
                params: file[0]
            });
        }
    }

    async events(){  

        document.querySelector(''#btnAsideSearch'').addEventListener(''click'', async () => {
            this.loadAppTab({
                id: ''SEARCH'',
                name: ''Search'',
                label: ''Advanced Search'',
                path: ''/studio/frontend/Search.js'',
                icon: ''bi-search''
            });
        });
        
        document.querySelector(''#btnAsideRestClient'').addEventListener(''click'', (event) => {
            this.loadAppTab({
                id: ''REST_API'',
                label: ''Rest Client'',
                name: ''RestClient'',
                path: ''/studio/frontend/RestClient.js'',
                icon: ''bi-braces''
            });
        });

        document.querySelector(''#btnAsideDBClient'').addEventListener(''click'', (event) => {
            this.loadAppTab({
                id: ''TAB_DB'',
                name: ''DatabaseController'',
                label: ''Database Client'',
                path: ''/studio/frontend/database/DatabaseController.js'',
                icon: ''bi-database'',
                css: true
            });
        });        

        document.querySelector(''#pills-tab'').addEventListener(''click'', (event) => {
            if(event.target.classList.contains(''bi-x'')){
                let obj = event.target.closest(''button'');
                this.closeTab(obj);
            }
        });

        document.querySelector(''#btnAddFile'').addEventListener(''click'', async(event)=>{
            await this.app.init({ 
                path: ''/studio/frontend/FormFiles.js'',
                name: ''FormFiles.'',
                target: ''.offcanvas'',
                params: {label: "Novo Arquivo"}
            });
        });

        document.querySelector(''.deep-bradcrumbs span'').addEventListener(''click'', (event) => {
            this.showOffcanvas(event);
        });

        document.querySelector(''#btnFileBarSave'').addEventListener(''click'', async (event) => {
            await this.update();
        });

        document.addEventListener(''keydown'', async (event) => {
            if (event.ctrlKey && event.key === ''s'') {                
                event.preventDefault();
                await this.update();
            }
        });

        document.querySelector(''#btnFileBarVisualHtml'').addEventListener(''click'', async (event) => {
            let tabId = document.querySelector(''button.nav-link.active'');
            if(tabId || tabId.getAttribute(''data-type'')==''HTML''){
                this.visualHtml(event);
            }else if(tabId || tabId.getAttribute(''data-type'')==''JS''){
                //TODO: TESTAR SE EXISTE FUNCTION TEMPLATE NO ARQUIVO JS
                //      SE EXISTIR, ENVIA O TEMPLATE PARA EDIÇÃO via WYSIWYG
                //      ATENÇÃO PARA MECANISMO DE "SAVE"
            }
        });

        document.querySelector(''#btnBarConfiguration'').addEventListener(''click'', async (event) => {
            await this.app.init({ 
                path: ''/js/Sample.js'',
                target: ''.modal'',
                params: {
                    label: ''SAMPLES'',
                    size: ''modal-xl''
                }
            });
        });
    }
}'),
	 ('','FormQueries','/studio/frontend/database/FormQueries.js','JAVASCRIPT','js',NULL,'export class FormQueries {

    constructor(app) {
        this.app = app; 
    }

    template() {
        return `
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <select id="txtNewQueryTable" class="form-select form-select-sm">
                        <option value="">Select table</option>
                    </select>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12">
                    <input type="text" id="txtNewQueryName" class="form-control form-control-sm" placeholder="Query name...">
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12 text-center">
                    <button id="btnNewQuery" class="btn btn-sm btn-primary" style="width:30% !important">Save</button>
                </div>
            </div>
        </div>`;
    }

    async init() {  
        this.events();
    }   

    events() {
        document.querySelector(''#btnNewQuery'').addEventListener(''click'', async (event) => {
            /*const table_id = document.querySelector(''#txtNewQueryTable'').value;
            const query_name = document.querySelector(''#txtNewQueryName'').value;
            
            await this.app.service.executeByPath({
                path:''/studio/backend/service/DBService.mjs'',
                name:''DBService'',
                execFunction: ''insertQuery'',
                sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
                params: { "table_id": `${table_id}`, "query_name": `${query_name}` }
            });
            this.app.modal.close();
            this.app.notyf.success(''Your changes have been successfully saved!'');*/
        });
    }
}'),
	 ('','WYSIWYG','/studio/frontend/wysiwyg/WYSIWYG.js','JAVASCRIPT','js',NULL,'export class WYSIWYG {

    constructor(app, params){
        this.app = app;
        this.drakeCopy = null;
        this.drakeColOrder = null;
        this.drakeRowOrder = null;
        this.params = params;
    }

    template(){
        return `
        <div id="toolBar" class="tool-bar card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <i class="bi bi-arrows-move" style="font-size: 0.75rem;"></i>
            </div>
            <div class="card-body scrollbar">
                <button type="button" id="btnDragDivContainer" class="btn btn-deep-aside btn-sm mb-1" aria-label="container" title="Container">
                    <i class="bi bi-collection"></i>
                </button>
                <button type="button" id="btnDragDivRow" class="btn btn-deep-aside btn-sm mb-1" aria-label="row" title="Row">
                    <i class="bi bi-layout-sidebar-inset"></i>
                </button>
                <button type="button" id="btnDragDivCol" class="btn btn-deep-aside btn-sm mb-1" aria-label="col" title="Col">
                    <i class="bi bi-layout-three-columns"></i>
                </button>
                <button type="button" id="btnDragTab" class="btn btn-deep-aside btn-sm mb-1" aria-label="tab" title="NavTabs">
                    <i class="bi bi-folder2"></i>
                </button>
                <button type="button" id="btnDragDropdown" class="btn btn-deep-aside btn-sm mb-1" aria-label="dropdown" title="Dropdown">
                    <i class="bi bi-menu-button-fill"></i>
                </button>
                <button type="button" id="btnDragTable" class="btn btn-deep-aside btn-sm mb-1" aria-label="table" title="Table">
                    <i class="bi bi-table"></i>
                </button> 
                <button type="button" id="btnDragCard" class="btn btn-deep-aside btn-sm mb-1" aria-label="card" title="Card">
                    <i class="bi bi-postcard"></i>
                </button>                
                <button type="button" id="btnDragLabel" class="btn btn-deep-aside btn-sm mb-1" aria-label="label"  title="Label">
                    <i class="bi bi-type"></i>
                </button>
                <button type="button" id="btnDragInputText" class="btn btn-deep-aside btn-sm mb-1" aria-label="text"  title="Input Text">
                    <i class="bi bi-input-cursor"></i>
                </button>
                <button type="button" id="btnDragInputGroup" class="btn btn-deep-aside btn-sm mb-1" aria-label="input-group" title="Input Group">
                    <i class="bi bi-vr"></i>
                </button>                
                <button type="button" id="btnDragTextArea" class="btn btn-deep-aside btn-sm mb-1" aria-label="textarea" title="Textarea">
                    <i class="bi bi-textarea-resize"></i>
                </button>
                <button type="button" id="btnDragRadio" class="btn btn-deep-aside btn-sm mb-1" aria-label="radio" title="Radio">
                    <i class="bi bi-record-circle-fill"></i>
                </button>
                <button type="button" id="btnDragCheck" class="btn btn-deep-aside btn-sm mb-1" aria-label="check" title="Check">
                    <i class="bi bi-check-square"></i>
                </button>
                <button type="button" id="btnDragButton" class="btn btn-deep-aside btn-sm mb-1" aria-label="button" title="Button">
                    <i class="bi bi-square-fill"></i>
                </button>                               
            </div>
        </div>
        <div id="propertiesMenu" class="card hide">
            <div class="card-header d-flex justify-content-between align-items-center">
                <i class="bi bi-arrows-move" style="font-size: 0.75rem;"></i>
            </div>
            <div class="card-body scrollbar"></div>
        </div>
        <div class="dragula-panel" id="dragulaPanel-${this.params.id}"></div>`;
    }

    async init(){

        this.app.utils.dragElement(document.querySelector(''#toolBar''));
        this.app.utils.dragElement(document.querySelector(''#propertiesMenu''));
        this.startDragula();
        if(this.params && this.params?.code){
            let dragulaPanel = document.querySelector(`#dragulaPanel-${this.params.id}`);
                dragulaPanel.insertAdjacentHTML(''afterbegin'', this.params?.code);
            this.loadContainers(dragulaPanel);
        }
        //await this.createtoolBar();
        await this.events();
    }

    startDragula(){
        let dragulaPanel = document.querySelector(`#dragulaPanel-${this.params.id}`);
        this.drakeCopy = dragula([document.querySelector(''div#toolBar div.card-body''), dragulaPanel], {
            revertOnSpill: true,
            copy: (el, source) => {
               return source === document.querySelector(''div#toolBar div.card-body'');
            },
            accepts: (el, target) => {
                //TODO: VALIDAR ESTAS REGRAS
                /*if (target.getAttribute(''id'')==`dragulaPanel-${this.params.id}` && el.getAttribute(''aria-label'')==''container''){
                    return true;
                } else if (target.hasAttribute(''class'') && target.getAttribute(''class'').indexOf(''row'') > -1 && el.getAttribute(''aria-label'')==''col''){
                    return true;
                } else if (target.hasAttribute(''class'') && target.getAttribute(''class'').indexOf(''row'') > -1 &&  el.hasAttribute(''class'') && target.getAttribute(''class'').indexOf(''col'') > -1) {
                    return true;
                }else if (target.hasAttribute(''class'') && target.getAttribute(''class'').indexOf(''col'') > -1) {
                    return true;
                }*/
                return true;
            }
        }).on(''drop'', (el, target, source, sibling) => {
            this.addField(el, target, sibling);
            target.removeChild(el);
        });

        this.drakeColOrder = dragula([dragulaPanel]);
        this.drakeRowOrder = dragula([dragulaPanel]);
    }

    loadContainers(node){
        this.recursiveThis(node, this.setContainer, this);
    }

    setFocus(id){
        this.focus = document.querySelector(`[id="${id}"]`);
        this.clearInFocus();        
        this.focus.closest(''div'').classList.add(''in-focus'');
    }

    clearInFocus(){
        document.querySelectorAll(`#dragulaPanel-${this.params.id} div`).forEach(element => {
            element.classList.remove(''in-focus'');
        });
    }

    clearAttributes(){
        document.querySelector(''#frmField'')?.reset();
    }

    setRows(){
        if([''textarea'', ''select-multiple''].includes(this.focus.type)){
            document.querySelector(''#frmField_rows'').disabled = false;
            if(this.focus.type==''textarea''){
                document.querySelector(''#frmField_rows'').value = this.focus.getAttribute(''rows'');
            }
            if(this.focus.type==''select-multiple''){
                document.querySelector(''#frmField_rows'').value = this.focus.getAttribute(''size'');
            }

            document.querySelector(''#frmField_rows'').addEventListener(''input'', (event) => {
                if(this.focus.type==''textarea''){
                    this.focus.setAttribute(''rows'', document.querySelector(''#frmField_rows'').value);
                }
                if(this.focus.type==''select-multiple''){
                    this.focus.setAttribute(''size'', document.querySelector(''#frmField_rows'').value);
                }
            });
        }else{
            document.querySelector(''#frmField_rows'').disabled = true;
            document.querySelector(''#frmField_rows'').value = '''';
        }
    }
    removeOnActive(node){

        if( node.nodeType === 1 && node.hasAttribute(''class'')){
            node.classList.remove(''on-active'');
        }
    }

    addField(el, target, sibling){

        if(!el.hasAttribute(''aria-label'')) return false;

        let id = this.app.utils.uuidv4();
        let str = '''';

        switch (el.getAttribute(''aria-label'')) {
            case ''container'':
                str = this.getContainer(id);
                break;
            case ''row'':
                str = this.getRow(id);
                break;
            case ''col'':
                str = this.getCol(id);
                break;
            case ''label'':
                str = this.getLabel(id);
                break;
            case ''text'':
                str = this.getInputText(id);
                break;
            case ''button'':
                str = this.getButton(id);
                break;
            case ''tab'':
                str = this.getTab(id);
                break;
            case ''dropdown'':
                str = this.getDropdown(id);
                break;
        }
        //console.log(sibling);
        if(sibling){
            sibling.insertAdjacentHTML(''beforebegin'', str);
        }else{
            target.insertAdjacentHTML(''beforeend'', str);
        }
        this.setContainer(document.querySelector(`#${id}`), this);
        document.querySelector(`#${id}`).closest(''div'').click();
    }

    setContainer(node, that){
        let _new = node;
        if(_new != null 
            && _new.nodeType === 1 
            && _new.hasAttribute(''class'') 
            && _new.getAttribute(''class'').indexOf(''container'') > -1) {
                that.drakeCopy.containers.push(_new);
                that.drakeColOrder.containers.push(_new);
        }
        if(_new != null 
            && _new.nodeType === 1 
            && _new.hasAttribute(''class'') 
            && _new.getAttribute(''class'').indexOf(''row'') > -1) {
                that.drakeCopy.containers.push(_new);
                that.drakeColOrder.containers.push(_new);
        }
        if(_new != null 
            && _new.nodeType === 1 
            && _new.hasAttribute(''class'') 
            && _new.getAttribute(''class'').indexOf(''col'') > -1) {
                that.drakeCopy.containers.push(_new);
                that.drakeRowOrder.containers.push(_new);
                that.felipeSugar(_new);  
        }
    }

    //FELIPE ODEIA PROCURAR INPUT HIDDEN NO OMNI, RSRSRSR
    felipeSugar(_new){
        if(_new.querySelector(''span[class*="badge"]'')){
            _new.removeChild(_new.querySelector(''span[class*="badge"]''));
        }
        if(_new.querySelectorAll(''input[type="hidden"]'').length > 0 && !_new.querySelector(''.badge'')){
            let badge = ''<span class="badge text-bg-warning z-3">h</span>'';
            _new.insertAdjacentHTML(''beforeend'', badge);
        }
    }

    getContainer(id){
        return `<div id="${id}" class="container"></div>`;
    }

    getRow(id){
        return `<div id="${id}" class="row"></div>`;
    }

    getCol(id){
        return `<div id="${id}" class="col-md-4"></div>`;
    }

    getLabel(id){
        return `<label id="${id}" class="form-label" contenteditable="true">Change this label</label>`;
    }

    getInputText(id){
        return `<input type="text" id="${id}" class="form-control" />`;
    }

    getButton(id){
        return `<button type="button" id="${id}" class="btn btn-primary">Primary</button>`;
    }

    getTab(id){
        return `
            <nav>
                <div class="nav nav-tabs" id="navTab${id}" role="tablist">
                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Home</button>
                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Profile</button>
                </div>
            </nav>
            <div class="tab-content" id="tabContent${id}">
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0"><h1>Home</h1></div>
                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0"><h1>Profile</h1></div>
            </div>`;
    }

    getDropdown(id){
        return `
            <div class="dropdown">
                <button id="${id}" class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Dropdown button
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">Action</a></li>
                    <li><a class="dropdown-item" href="#">Another action</a></li>
                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                </ul>
            </div>`;
    }

    recursive(node, func) {
        func(node);
        node = node.firstChild;
        while (node) {
            this.recursive(node, func);
            node = node.nextSibling;
        }
    }
    recursiveThis(node, func, that) {
        func(node, that);
        node = node.firstChild;
        while (node) {
            that.recursiveThis(node, func, that);
            node = node.nextSibling;
        }
    }

    async events(){

        let dragulaPanel = document.querySelector(`#dragulaPanel-${this.params.id}`);

        document.addEventListener(''keydown'', async (event) => {

            event.stopPropagation();
            //event.preventDefault();

            if(event.key == ''Delete'' && document.querySelector(''.on-active'')){
                const onActive = document.querySelector(''.on-active'');
                if(onActive.getAttribute(''id'')==`dragulaPanel-${this.params.id}`) return false;
                onActive.parentNode.removeChild(onActive);
            }

            if (event.ctrlKey && (event.key === ''c'' || event.key === ''C'')) {
                if(document.querySelector(''.on-active'') && document.querySelector(''.on-active'').getAttribute(''id'') != `dragulaPanel-${this.params.id}`){
                    const onActive = document.querySelector(''.on-active'');
                    navigator.clipboard.writeText(onActive.outerHTML);
                }
            }

            if (event.ctrlKey && (event.key === ''v'' || event.key === ''V'')) {
                if(document.querySelector(''.on-active'')){
                    const onActive = document.querySelector(''.on-active'');
                    const clipboard = await navigator.clipboard.readText();
                    onActive.insertAdjacentHTML(''beforeend'', clipboard);
                    this.recursiveThis(dragulaPanel, this.setContainer, this);
                }
            }

            if (event.ctrlKey && (event.key === ''z'' || event.key === ''Z'')) {
                console.log(''UNDO...'');
            }

            if (event.ctrlKey && (event.key === ''y'' || event.key === ''Y'')) {
                console.log(''REDO...'');
            }
        });

        dragulaPanel.addEventListener(''click'', (event) => {

            event.stopPropagation();
            event.preventDefault();

            let menu = document.querySelector(''#propertiesMenu'');
                menu.classList.add(''hide'');
                menu.style.top = ''0px'';
                menu.style.left = ''0px'';

            this.recursive(dragulaPanel, this.removeOnActive);
            event.target.classList.add(''on-active'');
        });

        dragulaPanel.addEventListener(''contextmenu'', async (event) => {
            event.preventDefault();

            if(event.target.getAttribute(''id'')==''dragulaPanel'') return false;

            this.recursive(dragulaPanel, this.removeOnActive);
            event.target.classList.remove(''on-active''); 
            
            let contextMenuH = document.querySelector(''#propertiesMenu'').offsetHeight || 280;
            let contextMenuW = document.querySelector(''#propertiesMenu'').offsetWidth || 450;

            let w = window.innerWidth;
            let h = window.innerHeight;
            let y = event.clientY + contextMenuH > h ? event.clientY - contextMenuH : event.clientY;
            let x = event.clientX + contextMenuW > w ? event.clientX - contextMenuW : event.clientX;
            let menu = document.querySelector(''#propertiesMenu'');
                menu.style.top = `${y}px`;
                menu.style.left = `${x}px`;
                menu.classList.remove(''hide'');

            await this.app.initLocal({
                target: ''#propertiesMenu .card-body'',
                path: ''/js/properties/Properties.js'',
                app: true,
                params: event.target
            });

        }, false);
    }
}'),
	 ('','DatabaseController','/studio/frontend/database/DatabaseController.js','JAVASCRIPT','js',NULL,'/******* CUSTOMIZADO NÂO TROCAR DE VERSÃO *******/
import { Treeview } from "http://localhost:3000/assets/quercus.js/dist/treeview.js";
import Split from ''http://localhost:3000/assets/split.js/dist/split.es.js'';

export class DatabaseController {

    constructor(app) {
        this.app = app;
        this.tables = null;
    }

    template(){
        return `        
        <div class="split" id="gridDB">
            <div id="mainDB"></div>
            <div id="asideDB">
                <div id="panelSerachDB">
                    <div id="treeViewDB" class="custom-treeview-wrapper"></div>
                </div>
            </div>
        </div>`;
    }

    async init(){

        Split([''#mainDB'', ''#asideDB''], {
            gutterSize: 8,
            minSize: 0,
            sizes: [70, 30]
        });

        await this.loadTablesAndQueries();
        await this.events();
    }

    async loadTablesAndQueries(){

        this.tables = await this.app.service.buildDBTree();

        //if(!this.tables || this.tables.length == 0) return false;

        this.treeViewaFiles = new Treeview({
            containerId: ''treeViewDB'',
            data: this.tables,
            searchEnabled: true,
            initiallyExpanded: true, 
            multiSelectEnabled: false,
            onSelectionChange: (selectedNodesData) => {
                if(selectedNodesData.length > 0 && selectedNodesData[0].type == ''folder''){
                    this.loadColumnsTableEdit(selectedNodesData[0]?.id, selectedNodesData[0]?.name);
                } else {
                    this.loadQueryEdit(selectedNodesData[0].id, selectedNodesData[0].name);
                }           
            },
            onRenderNode: (nodeData, nodeContentWrapperElement) => {
                // Clear existing content if any (important for setData calls)
                nodeContentWrapperElement.innerHTML = '''';
                
                // Create an icon based on node type
                const iconSpan = document.createElement(''span'');
                iconSpan.classList.add(''custom-node-icon''); // Apply custom CSS class for styling
                if (nodeData.type === ''folder'') {
                    iconSpan.innerHTML = ''<i class="bi bi-table me-2" style="color:#7C2ADC;"></i>'';
                } else {
                    iconSpan.innerHTML = ''<i class="bi bi-database-fill-gear me-2" style="color: var(--deep-indigo-200)"></i>'';
                }
                nodeContentWrapperElement.appendChild(iconSpan);

                // Create a span for the node name
                const nameSpan = document.createElement(''span'');
                nameSpan.classList.add(''treeview-node-text'', ''custom-node-name''); // Keep treeview-node-text for search
                nameSpan.textContent = nodeData.name;
                nodeContentWrapperElement.appendChild(nameSpan);

                // Add a description/status if available
                if (nodeData.description) {
                    const descSpan = document.createElement(''span'');
                    descSpan.classList.add(''custom-node-description'');
                    descSpan.textContent = ` (${nodeData.description})`;
                    nodeContentWrapperElement.appendChild(descSpan);
                } else if (nodeData.status) {
                    const statusSpan = document.createElement(''span'');
                    statusSpan.classList.add(''custom-node-description'');
                    statusSpan.textContent = ` [${nodeData.status}]`;
                    statusSpan.classList.add(nodeData.status === ''active'' ? ''custom-node-status-active'' : ''custom-node-status-inactive'');
                    nodeContentWrapperElement.appendChild(statusSpan);
                } else if (nodeData.size) {
                    const sizeSpan = document.createElement(''span'');
                    sizeSpan.classList.add(''custom-node-description'');
                    sizeSpan.textContent = ` (${nodeData.size})`;
                    nodeContentWrapperElement.appendChild(sizeSpan);
                }
            }
        });

        let btnAddTable = `<div class="dropdown" style="position: absolute; top: 2px; right: 7px; z-index: 1000">
                <button class="btn btn-sm btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="padding: 0.23rem 0.5rem !important">
                    <i class="bi bi-table"></i>
                </button>
                <ul class="dropdown-menu">
                    <li>                        
                        <a id="lnkAddnewTable" class="dropdown-item" href="#">
                            <i class="bi bi-table me-2" style="color:#7C2ADC;"></i> Add new Table
                        </a>
                    </li>
                    <li>
                        <a id="lnkAddnewQuery" class="dropdown-item" href="#">
                            <i class="bi bi-database-fill-gear me-2" style="color: var(--deep-indigo-200)"></i> Add new Query
                        </a>
                    </li>
                    <li><a id="lnkAddnewTrigger" class="dropdown-item" href="#">
                        <i class="bi bi-database-exclamation me-2" style="color:#FFFF00"></i> Add new Trigger</a>
                    </li>
                </ul>
            </div>`;
            
        document.querySelector(''#treeViewDB'').classList.add(''position-relative'');
        document.querySelector(''#treeViewDB'').setAttribute(''style'', ''min-width: 230px;'');
        document.querySelector(''#treeViewDB'').insertAdjacentHTML(''afterbegin'', btnAddTable);
    }

    async loadColumnsTableEdit(tableId, label){
        
        //await this.app.initLocal({
        //    path: ''/js/database/TablesEdit.js'',
        //    target: `#mainDB`,
        //    params: {
        //        id: tableId,
        //        label: label,
        //    }
        //});
        await this.app.init({  
            path: ''/studio/frontend/database/FormColumns.js'',
            name: ''FormColumns.'',
            target: `#mainDB`,
            params: {
                id: tableId,
               label: label,
            }
        });
    }

    async loadQueryEdit(queryId, label){

        //await this.app.initLocal({
        //    path: ''/js/database/QueryEdit.js'',
        //    target: `#mainDB`,
        //    params: {
        //        id: `${queryId}`,
        //        label: label,
        //    }
        //});
        await this.app.init({  
            path: ''/studio/frontend/database/QueryEditor.js'',
            name: ''QueryEditor.'',
            target: `#mainDB`,
            params: {
                id: `${queryId}`,
                label: label,
            }
        });
    }

    async events(){

        document.querySelector(''#lnkAddnewTable'').addEventListener(''click'', async (event) => {
            //await this.app.initLocal({
            //    path: ''/js/database/NewTable.js'',
            //    target: ''.modal'',
            //    params: {
            //        label: ''Add new table'',
            //        size: ''modal''
            //    }
            //});
            await this.app.init({  
                path: ''/studio/frontend/database/FormTables.js'',
                name: ''FormTables.'',
                target: ''.modal'',
                params: {
                    label: ''Add new table'',
                    size: ''modal''
                }
            });
        });

        document.querySelector(''#lnkAddnewQuery'').addEventListener(''click'', async (event) => {
            //await this.app.initLocal({
            //    path: ''/js/database/NewQuery.js'',
            //    target: ''.modal'',
            //    params: {
            //        label: ''Add new query'',
            //        size: ''modal''
            //    }
            //});
            await this.app.init({  
                path: ''/studio/frontend/database/FormQueries.js'',
                name: ''FormQueries.'',
                target: ''.modal'',
                params: {
                    label: ''Add new query'',
                    size: ''modal''
                }
            });
        });
    }
}'),
	 ('','FormColumns','/studio/frontend/database/FormColumns.js','JAVASCRIPT','js',NULL,'export class FormColumns {

    constructor(app, params) {
        this.app = app; 
        this.data = null;
        this.params = params || {};
        this.table = null;
    }

    template() {
        return `
        <div class="container-fluid">
            <h5 class="mt-3 text-light"><i class="bi bi-table me-2" style="color:#7C2ADC;"></i> ${this.params.label}</h5>
            <form id="frmTableEdit">
                <div class="row g-2 mt-2">                
                    <div class="col-md-4">
                        <input type="hidden" id="st_columns_id" />
                        <input type="hidden" id="st_columns_table_id" value="${this.params.id}" />
                        <label for="columns_name" class="form-label">Columnn''s name</label>
                        <input type="text" id="columns_name" class="form-control form-control-sm" />                    
                    </div>
                    <div class="col-md-2">
                        <label for="st_columns_data_type" class="form-label">Type</label>
                        <select id="st_columns_data_type" class="form-select form-select-sm">
                            <option value="">Select</option>
                            <option value="INT">int</option>
                            <option value="BIGINT">bigint</option>
                            <option value="VARCHAR">varchar</option>    
                            <option value="TEXT">text</option>
                            <option value="DATE">date</option>
                            <option value="TIMESTAMP">timestamp</option>
                            <option value="DECIMAL">decimal</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label for="st_columns_lenght" class="form-label">lenght</label>
                        <input type="number" min="0" id="st_columns_lenght" class="form-control form-control-sm" />
                    </div>
                    <div class="col-md-4">
                        <label for="st_columns_default_value" class="form-label">Default</label>
                        <input type="text" id="st_columns_default_value" class="form-control form-control-sm" />
                    </div>
                </div>
                <div class="row g-2 mt-2 align-items-center">
                    <div class="col-md-8">                    
                        <div class="form-check form-check-inline form-switch">
                            <input class="form-check-input" type="checkbox" role="switch" id="st_columns_index_search" />
                            <label class="form-check-label" for="st_columns_index_search">Index for serach?</label>
                        </div>
                        <div class="form-check form-check-inline form-switch">
                            <input class="form-check-input" type="checkbox" role="switch" id="st_column_is_required" />
                            <label class="form-check-label" for="st_column_is_required">id required?</label>
                        </div>
                        <div class="form-check form-check-inline form-switch">
                            <input class="form-check-input" type="checkbox" role="switch" id="st_columns_fk_table" />
                            <label class="form-check-label" for="st_columns_fk_table">Foreign key?</label>
                        </div>
                    </div> 
                    <div class="col-auto ms-auto">
                        <button id="btnCancelColumnTable" class="btn btn-sm btn-secondary">Cancel</button>
                        <button id="btnEditColumnTable" class="btn btn-sm btn-primary">Save</button>
                        <button id="btnCreateTableOnDB" class="btn btn-sm btn-bd-violet">Create on DB</button>
                    </div>
                </div>
            </form>
            <div class="row mt-4">
                <div class="col-md-12" style="color: #fff;">
                    <div class="table-responsive">
                        <table id="st_columns_datatable" class="display compact nowrap" width="100%"></table>
                    </div>
                </div>
            </div>
        </div>
        <style>
            #dt-length-0 {
                margin-right: 10px;
            }
            #dt-search-0 {
                margin-left: 10px;
            }
        </style>
        `;
    }

    async init() {  

        await this.loadTableColumns(this.params.id);
        this.events();
    }   

    async loadTableColumns(tableId) {

        let that = this;
        // Load table columns from the database
        this.data = await this.app.service.executeByPath({
            path:''/studio/backend/service/DBService.mjs'',
            name:''DBService'',
            execFunction: ''select'',
            sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
            params: {"tables_id": `${tableId}`}
        });

        let dataSet = [];
        if(this.data) {
            for(let data of this.data?.resultList){
                let item = [data.id, data.columns_name, data.data_type, data.length, data.default_value, data.index_search, data.is_required, data.fk_table];
                dataSet.push(item);
            }
        }

        if(that.table){
            that.table.clear();
            that.table.destroy();
            document.querySelector(''#st_columns_datatable thead'').innerHTML = '''';
            document.querySelector(''#st_columns_datatable tbody'').innerHTML = '''';
        }

        // Initialize DataTable with the columns
        that.table = new DataTable(''#st_columns_datatable'', {
            lengthMenu: [5, 10, 25, 50, -1],
            data: dataSet,
            columns: [
                { title: "Id",visible: false, searchable: false },
                { title: "Name", orderable: false },
                { title: "Type", orderable: false },
                { title: "Length", orderable: false },
                { title: "Default", orderable: false },
                { title: "Index Search", orderable: false },
                { title: "Required", orderable: false },
                { title: "Foreign Key", orderable: false },
                {
                    data: null,
                    className: ''dt-center editor-edit'',
                    defaultContent: ''<i class="bi bi-pen text-info"></i>'',
                    orderable: false,
                    width: ''40px''
                },
                {
                    data: null,
                    className: ''dt-center editor-delete'',
                    defaultContent: ''<i class="bi bi-trash text-danger"></i>'',
                    orderable: false,
                    width: ''40px''
                }
            ]
        }).on(''click'', ''td.editor-edit i'', function (e) {
            const data = that.table.row($(this).parents(''tr'')).data();
            document.querySelector(''#st_columns_id'').value = data[0]; // Set the hidden input with the record ID
            document.querySelector(''#columns_name'').value = data[1];    // Set the column name
            document.querySelector(''#st_columns_data_type'').value = data[2]; // Set the data type
            document.querySelector(''#st_columns_lenght'').value = data[3]; // Set the length
            document.querySelector(''#st_columns_default_value'').value = data[4]; // Set the default value
            document.querySelector(''#st_columns_index_search'').checked = (data[5] === ''Y''); // Set the index search checkbox
            document.querySelector(''#st_column_is_required'').checked = (data[6] === ''Y''); // Set the required checkbox
            document.querySelector(''#st_columns_fk_table'').checked = (data[7] === ''Y''); // Set the foreign key checkbox
        }).on(''click'', ''td.editor-delete i'', function (e) {
            const data = that.table.row($(this).parents(''tr'')).data();
            that.delete(data[0])
            console.log(`Delete record clicked: ${data[0]}`);
        });
    }

    async delete(id){

        await this.app.service.executeByPath({
            path:''/studio/backend/service/DBService.mjs'',
            name:''DBService'',
            execFunction: ''delete'',
            sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
            params: {"id": `${id}`}
        });
        await this.loadTableColumns(this.params.id);
        this.cancel();
        this.app.notyf.success(''Your changes have been successfully saved!'');
    }

    cancel(){
        document.querySelector(''#st_columns_id'').value = ""; // Set the hidden input with the record ID
        document.querySelector(''#columns_name'').value = "";    // Set the column name
        document.querySelector(''#st_columns_data_type'').value = ""; // Set the data type
        document.querySelector(''#st_columns_lenght'').value = ""; // Set the length
        document.querySelector(''#st_columns_default_value'').value = ""; // Set the default value
        document.querySelector(''#st_columns_index_search'').checked = false; // Set the index search checkbox
        document.querySelector(''#st_column_is_required'').checked = false; // Set the required checkbox
        document.querySelector(''#st_columns_fk_table'').checked = false; // Set the foreign key checkbox
    }

    events() {

        document.querySelector(''#btnCancelColumnTable'').addEventListener(''click'', async (event) => {            
            this.cancel();
        });

        document.querySelector(''#btnEditColumnTable'').addEventListener(''click'', async (event) => {

            let id = document.querySelector(''#st_columns_id'').value;
            let columns_name = document.querySelector(''#columns_name'').value;
            let dataType = document.querySelector(''#st_columns_data_type'').value;

            if(!columns_name || !dataType) {
                alert(''Please fill in all required fields.'');
                return;
            }

            const columnData = {
                id: id,
                tables_id: document.querySelector(''#st_columns_table_id'').value,
                columns_name: columns_name,
                data_type: dataType,
                length: document.querySelector(''#st_columns_lenght'').value,
                default_value: document.querySelector(''#st_columns_default_value'').value,
                index_search: document.querySelector(''#st_columns_index_search'').checked ? ''Y'' : ''N'',
                is_required: document.querySelector(''#st_column_is_required'').checked ? ''Y'' : ''N'',
                fk_table: document.querySelector(''#st_columns_fk_table'').checked ? ''Y'' : ''N''
            };

            if(id) {
                await this.app.service.executeByPath({
                    path:''/studio/backend/service/DBService.mjs'',
                    name:''DBService'',
                    execFunction: ''update'',
                    sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
                    params: columnData
                });
            } else {
                //await this.app.service.addColumn(columnData, this.params.id);
                delete columnData.id;
                await this.app.service.executeByPath({
                    path:''/studio/backend/service/DBService.mjs'',
                    name:''DBService'',
                    execFunction: ''insert'',
                    sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
                    params: columnData
                });
            }

            // Reload the table columns
            await this.loadTableColumns(this.params.id);
            this.cancel();
            this.app.notyf.success(''Your changes have been successfully saved!'');
        });
    }
}'),
	 ('','wysiwyg','/studio/frontend/wysiwyg/wysiwyg.css','CSS','css',NULL,'.hide {
    display: none;
}
div.tool-bar {
    position: absolute;
    top: 70px;
    left: 250px;
    width: 60px;
    height: 530px;
    resize: both;
    overflow: auto;
    z-index: 9999998;
    border: 1px solid var(--deep-border-color-1);
}
div.tool-bar.card div.card-header {
    cursor: move;
    padding: 0.25rem 0.50rem !important;
    background-color: var(--deep-bg-color);
    border-bottom: 1px solid var(--deep-border-color-1) !important;
}
div.tool-bar.card div.card-body {
    padding: 4px 0px !important;
    background-color: var(--deep-bg-color);
    text-align: center;
}
#propertiesMenu{
    position: absolute;
    top: 62px;
    left: 230px;
    width: 450px;
    height: 280px;
    resize: both;
    overflow: auto;
    z-index: 9999999;
    border: 1px solid var(--deep-border-color-1);
}
div#propertiesMenu.card div.card-header {
    cursor: move;
    padding: 0.25rem 0.50rem !important;
    background-color: var(--deep-bg-color);
    border-bottom: 1px solid transparent !important;
}
div#propertiesMenu.card div.card-body {
    padding: 4px 10px !important;
    background-color: var(--deep-bg-color);
    overflow-x: hidden;
}
.dragula-panel {
    width: 100%;
    height: calc(100vh - 165px);
    margin: 5px;
    padding: 5px;
    overflow-y: auto;
    overflow-x: auto;
    padding-bottom: 60px;
}
div.tool-bar.card .btn-light {
    --bs-btn-border-color: var(--deep-border-color-1) !important;
}
div.dragula-panel div.row {
    margin-bottom: 5px;
    margin-left: 0px;
    margin-right: 0px;
}
div.dragula-panel div[class*="container"],
div.dragula-panel div.row,
div.dragula-panel div[class*="col-"] {
    position: relative;
    min-height: 40px;
    border: 1px dashed var(--deep-border-color-1);
    padding: 8px;
}
div.dragula-panel span[class*="badge"] {
    position: absolute;
    top: 4px;
    right: 4px;
    opacity: 0.3;
}
.on-active {
    border: 1px dashed orange !important;
    background-color: var(--bs-body-bg);
}
[contenteditable="true"]:focus {
    outline: none;
}

.row {
    color: var(--deep-color-1);
}'),
	 ('','Col','/studio/frontend/wysiwyg/properties/Col.js','JAVASCRIPT','js',NULL,'export class Col {

    constructor(app, element){
        this.app = app;
        this.element = element;
        this.currentClass = element?.getAttribute(''class'') || "";
        this.currentStyle = element?.getAttribute(''style'') || "";
        this.currentId = element?.getAttribute(''id'');
    }

    template(){
        return `
        <div class="container">
            <h5 class="mb-3">Col</h5>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">id</label>
                <div class="col-md-8">
                    <input type="text" class="form-control form-control-sm" id="colId" value="${this.currentId}" readonly>
                </div>
            </div>
            <div class="row mb-2">              
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">class</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control form-control-sm" id="colClass" value="${this.currentClass.replace(''on-active'', '''').trim()}" /> 
                </div>               
            </div>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">style</label>
                <div class="col-md-8">
                    <textarea class="form-control form-control-sm" rows="5" id="colStyle">${this.currentStyle}</textarea>
                </div>
            </div>
        </div>`;
    }

    async init(){
        await this.events();
    }

    async events(){

        document.querySelector(''#colStyle'').addEventListener(''change'', (event) => {
            this.element.setAttribute(''style'', event.target.value);
        });

        document.querySelector(''#colClass'').addEventListener(''change'', (event) => {
            this.element.setAttribute(''class'', event.target.value);
        });
    }
}');
INSERT INTO public.js_scripts ("location",name,"path",type_file,"language",init_function_name,code) VALUES
	 ('','Container','/studio/frontend/wysiwyg/properties/Container.js','JAVASCRIPT','js',NULL,'export class Container {

    constructor(app, element){
        this.app = app;
        this.element = element;
        this.currentId = element?.getAttribute(''id'') || this.app.utils.uuidv4();
        this.currentClass = element?.getAttribute(''class'') || "";
        this.currentStyle = element?.getAttribute(''style'') || "";
    }

    template(){
        return `
        <div class="container">
            <h5 class="mb-3">Row</h5>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">id</label>
                <div class="col-md-8">
                    <input type="text" class="form-control form-control-sm" id="colId" value="${this.currentId}" readonly>
                </div>
            </div>
            <div class="row mb-2">              
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">class</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control form-control-sm" id="colClass" value="${this.currentClass.replace(''on-active'', '''').trim()}" /> 
                </div>               
            </div>
            <div class="row mb-2">
                <label class="col-sm-4 col-form-label col-form-label-sm" for="colSize">style</label>
                <div class="col-md-8">
                    <textarea class="form-control form-control-sm" rows="5" id="colStyle">${this.currentStyle}</textarea>
                </div>
            </div>
        </div>`;
    }

    async init(){
        await this.events();
    }

    async events(){
        document.querySelector(''#colStyle'').addEventListener(''change'', (event) => {
            this.element.setAttribute(''style'', event.target.value);
        });
        document.querySelector(''#colClass'').addEventListener(''change'', (event) => {
            this.element.setAttribute(''class'', event.target.value);
        });
    }
}'),
	 ('','Properties','/studio/frontend/wysiwyg/properties/Properties.js','JAVASCRIPT','js',NULL,'export class Properties {

    constructor(app, params){
        this.app = app;
        this.params = params;
    }

    template(){
        return "<div id=''propertiesBody'' style=''overflow: auto''></div>";
    }

    async init(){

        let element = this.params;
        let tagName = element.tagName;        
        document.querySelector(''#propertiesBody'').innerHTML = '''';

        switch (tagName) {
            case ''DIV'':
                if(element.classList.contains(''container'') || element.classList.contains(''container-fluid'')){
                    await this.app.initLocal({
                        path: ''/js/properties/Container.js'',
                        target: ''#propertiesBody'',
                        params: element
                    });
                }else if(element.classList.contains(''row'')){
                    await this.app.initLocal({
                        path: ''/js/properties/Row.js'',
                        target: ''#propertiesBody'',
                        params: element
                    });
                }else if(element.getAttribute("class").indexOf("col-") > -1){
                    await this.app.initLocal({
                        path: ''/js/properties/Col.js'',
                        target: ''#propertiesBody'',
                        params: element
                    });
                }
                break;
            case ''INPUT'':
                console.log("Properties init INPUT", element);
                break;
            case ''LABEL'':
                console.log("Properties init LABEL", element);
                break;
        }
    }
}'),
	 ('','Service','/studio/frontend/service/Service.js','JAVASCRIPT','js',NULL,'export class Service {

    constructor() {
        this.baseUrl = ''http://localhost:8080/api/jsscripts'';
    }

    async buildFileTree() {
        const response = await fetch(`${this.baseUrl}/tree`);
        return await response.json();
    }

    async buildDBTree() {
        const response = await fetch(`${this.baseUrl}/dBTree`);
        return await response.json();
    }

    async findAll() {
        const response = await fetch(this.baseUrl);
        return await response.json();
    }

    async findById(id) {
        const response = await fetch(`${this.baseUrl}/${id}`);
        return await response.json();
    }

    async executeByPath(obj){
        const response = await fetch(`${this.baseUrl}/execute`, {
            method: ''POST'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify(obj)
        });
        return await response.json();
    }

    async executeByLocationAndName(obj) {
        const response = await fetch(`${this.baseUrl}/${obj.location}/${obj.name}/execute`, {
            method: ''POST'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify(obj.data)
        });
        return await response.json();
    }

    async findByPath(path) {
        const response = await fetch(`${this.baseUrl}/findByPath/?path=${path}`);
        return await response.json();
    }

    async findByPathContains(path) {
        const response = await fetch(`${this.baseUrl}/findByPathContains/?path=${path}`);
        return await response.json();
    }

    async save(script) {
        const response = await fetch(this.baseUrl, {
            method: ''POST'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify(script)
        });
        return await response.json();
    }

    async update(script, id ) {
        const response = await fetch(`${this.baseUrl}/${id}`, {
            method: ''PUT'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify(script)
        });
        return await response.json();
    }

    async deleteById(id) {
        const response = await fetch(`${this.baseUrl}/${id}`, {
            method: ''DELETE''
        });
        //return await response.json();
    }

    async executeById(id) {
        const response = await fetch(`${this.baseUrl}/${id}/execute`);
        return await response.text();
    }

    /********************** DATABASE METHODS 

    async getTables() {
        const response = await fetch(`${this.baseUrl}/tables`);
        return await response.json();
    }

    async addTable(tableName) {
        const response = await fetch(`${this.baseUrl}/tables`, {
            method: ''POST'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify({ name: tableName })
        });
        return await response.json();
    }

    async getTableColumns(tableId) {
        return fetch(`${this.baseUrl}/tables/${tableId}/columns`)
            .then(response => response.json())
            .then(data => {
                if (data.status == ''success'') {
                    return data.result;
                }
                return [];
            });
    }

    async updateColumn(column, tableId) {
        return fetch(`${this.baseUrl}/tables/columns/${column.id}`, {
            method: ''PUT'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify(column)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status == ''success'') {
                return data.result;
            }
            throw new Error(data.message);
        });
    }

    async addColumn(column, tableId) {
        return fetch(`${this.baseUrl}/tables/columns`, {
            method: ''POST'',
            headers: { ''Content-Type'': ''application/json'' },
            body: JSON.stringify(column)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status == ''success'') {
                return data.result;
            }
            throw new Error(data.message);
        });
    }
    **********************/
}'),
	 ('','studio','/studio/frontend/studio.css','CSS','css',NULL,':root {
    --deep-border-radius: 6px;
    --deep-border-color: #31323C;
    --deep-border-color-1: #494a58;
    --deep-border: 1px solid #31323C; 
    --deep-border-tab: 1px solid #383A45;
    --deep-border-top-tab-active: #94527E;
    --deep-bg-color-tab-out-focus: #191A21;
    --deep-bg-color: #21222C;
    --deep-bg-color-inside: #282A36;
    --deep-bg-color-footer: #191A21;
    --deep-color-1: #6272A4;
    --deep-indigo: #6610f2;
    --deep-indigo-100: #E0CFFC;
    --deep-indigo-200: #C29FFA;
    --deep-indigo-300: #A370F7;
    --deep-indigo-400: #8540F5;
    --deep-indigo-500: #6610F2;
    --deep-indigo-600: #520DC2;
    --deep-indigo-700: #3D0A91;
    --deep-indigo-800: #290661;
    --deep-indigo-900: #140330;

}
.deep {
    display: grid;
    gap: 5px;
    grid-template-rows: 44px calc(100vh - (44px + 24px + (5px + 5px))) 24px;
    grid-template-columns: 44px calc(100vw - (44px + (5px + 5px)));
    grid-template-areas: "deep-header  deep-header"
                         "deep-aside   deep-principal"
                         "deep-footer  deep-footer";
    overflow: hidden;
    background: var(--deep-bg-color);
}
.deep-header {
    grid-area: deep-header;
}
.deep-aside {
    grid-area: deep-aside;
    display: flex;
    flex-direction: column;
}
.deep-aside button { 
    margin-left: 5px;
    margin-bottom: 5px;
}
#deep-expector {
    border-radius: var(--deep-border-radius);
    border: var(--deep-border);
    overflow-x: auto;
}
.deep-principal {
    grid-area: deep-principal;
}
#deep-expector li {
    white-space:nowrap;
}
#deep-main {
    background-color: var(--deep-bg-color-inside);
    border-radius: var(--deep-border-radius);
    border: var(--deep-border);
    width: calc(100vw - (265px + 44px + 5px + 5px + 5px));
}
.deep-footer {
    grid-area: deep-footer;
    background-color: var(--deep-bg-color-footer);
}
.deep-tabs {
    display: flex;
    height: 36px;
    width: 100%;
}
.deep-bradcrumbs {
    display: flex;
    height: 38px;
    width: 100%;
    color: var(--deep-color-1);
    font-size: .8rem;
    padding-left: 10px;
}
.deep-bradcrumbs span {
    flex: 1;
    align-self: center;
}
.deep-editors {
    display: flex;
    height: 100%;
    width: 100%;
}
.deep-txt {
    color: var(--deep-color-1);
    font-size: .8rem;
}
.deep-list{
    list-style: none;
}
.nav-pills .nav-link.active, 
.nav-pills .show > .nav-link {
    color: var(--bs-nav-pills-link-active-color);
    background-color: transparent;
    border: var(--deep-border-tab);
    border-top: 1px solid var(--deep-border-top-tab-active);
}
.nav-pills .nav-link {
    margin: 5px 3px;
    padding: 0.25rem 0.7rem;
    font-weight: 500;
    color: var(--deep-color-1);
    background-color: var(--deep-bg-color);
    border: 1px solid var(--deep-bg-color);
}
.bi-javascript {
    color: yellow;
}
.bi-hash {
    color: blueviolet;
}
.bi-code-slash {
    color: olivedrab;
}
.btn-deep-aside {
    background-color: transparent;
    border: 1px solid transparent;
    color: var(--deep-color-1);
}
.btn:hover {
    color: var(--deep-color-1);
}
.btn-check:checked+.btn, 
.btn.active, 
.btn.show, 
.btn:first-child:active, 
:not(.btn-check)+.btn:active {
    color: var(--deep-color-1);
}
.btn-deep-aside:active,
.btn-deep-aside:focus {
    background-color: #39394C;
    border: 1px solid #39394C;
}
.btn-deep-aside:hover {
    background-color: #39394C;
    border: 1px solid #39394C;
}
.navbar {
    padding: 0 0;
}

::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}
  
::-webkit-scrollbar-track {
    background: rgb(233, 233, 233);
    border-radius: 20px; 
}
   
::-webkit-scrollbar-thumb {
    background: #c7c8ca;
    border-radius: 20px;
}
  
::-webkit-scrollbar-thumb:hover {
    background: rgb(185, 185, 185); 
}

.monaco-editor {
    height: 100% !important;
    width: 100% !important;
}

.tab-pane{
    width: calc(100% - 12px);
    height: calc(100vh - 165px);
}

.dropdown-menu {
    --bs-dropdown-font-size: 0.8rem;
}

[data-bs-theme=dark] {
    color-scheme: dark;
    --bd-purple: #4c0bce;
    --bd-violet: #9561fb;
    --bd-violet-bg: #712cf9;
    --bs-body-color: #dee2e6;
    --bs-body-color-rgb: 222, 226, 230;
    --bs-body-bg: #282a36;/*#212529;*/
    --bs-body-bg-rgb: 33, 37, 41;
    --bs-emphasis-color: #fff;
    --bs-emphasis-color-rgb: 255, 255, 255;
    --bs-secondary-color: rgba(222, 226, 230, 0.75);
    --bs-secondary-color-rgb: 222, 226, 230;
    --bs-secondary-bg: #343a40;
    --bs-secondary-bg-rgb: 52, 58, 64;
    --bs-tertiary-color: rgba(222, 226, 230, 0.5);
    --bs-tertiary-color-rgb: 222, 226, 230;
    --bs-tertiary-bg: #2b3035;
    --bs-tertiary-bg-rgb: 43, 48, 53;
    --bs-primary-text-emphasis: #6ea8fe;
    --bs-secondary-text-emphasis: #a7acb1;
    --bs-success-text-emphasis: #75b798;
    --bs-info-text-emphasis: #6edff6;
    --bs-warning-text-emphasis: #ffda6a;
    --bs-danger-text-emphasis: #ea868f;
    --bs-light-text-emphasis: #f8f9fa;
    --bs-dark-text-emphasis: #dee2e6;
    --bs-primary-bg-subtle: #031633;
    --bs-secondary-bg-subtle: #161719;
    --bs-success-bg-subtle: #051b11;
    --bs-info-bg-subtle: #032830;
    --bs-warning-bg-subtle: #332701;
    --bs-danger-bg-subtle: #2c0b0e;
    --bs-light-bg-subtle: #343a40;
    --bs-dark-bg-subtle: #1a1d20;
    --bs-primary-border-subtle: #084298;
    --bs-secondary-border-subtle: #41464b;
    --bs-success-border-subtle: #0f5132;
    --bs-info-border-subtle: #087990;
    --bs-warning-border-subtle: #997404;
    --bs-danger-border-subtle: #842029;
    --bs-light-border-subtle: #495057;
    --bs-dark-border-subtle: #343a40;
    --bs-heading-color: inherit;
    --bs-link-color: #6ea8fe;
    --bs-link-hover-color: #8bb9fe;
    --bs-link-color-rgb: 110, 168, 254;
    --bs-link-hover-color-rgb: 139, 185, 254;
    --bs-code-color: #e685b5;
    --bs-highlight-color: #dee2e6;
    --bs-highlight-bg: #664d03;
    --bs-border-color: #495057;
    --bs-border-color-translucent: rgba(255, 255, 255, 0.15);
    --bs-form-valid-color: #75b798;
    --bs-form-valid-border-color: #75b798;
    --bs-form-invalid-color: #ea868f;
    --bs-form-invalid-border-color: #ea868f;
}

.deep-bradcrumbs span {
    cursor: pointer;
}

.split {
    display: flex;
    flex-direction: row;
}

.gutter {
    background-color: transparent;
    background-repeat: no-repeat;
    background-position: 50%;
}

.gutter.gutter-horizontal {
    background-image: url(''data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAeCAYAAADkftS9AAAAIklEQVQoU2M4c+bMfxAGAgYYmwGrIIiDjrELjpo5aiZeMwF+yNnOs5KSvgAAAABJRU5ErkJggg=='');
    cursor: col-resize;
}

.gutter.gutter-vertical {
    background-image: url(''data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAFAQMAAABo7865AAAABlBMVEVHcEzMzMzyAv2sAAAAAXRSTlMAQObYZgAAABBJREFUeF5jOAMEEAIEEFwAn3kMwcB6I2AAAAAASUVORK5CYII='');
    cursor: row-resize;
}

.dropdown-menu-dark {
    --bs-dropdown-bg: var(--bs-body-bg);
}

.custom-treeview-wrapper {
    background-color: transparent;
    border: 0px;
    padding: 0px 5px;
    border-radius: 5px;
    max-width: 600px;
    margin: 5px auto;
    box-shadow: none;
    font-size: 0.85rem;
}

.custom-treeview-wrapper > ul {
    padding-left: 30px;
}
.custom-treeview-wrapper .treeview-node-content {
    padding: 0; 
}

.treeview-search-input{
    padding: .35rem .5rem !important;
}
.treeview-expander-placeholder {
    width: 10px;
}

.bi-database {
    color: #3DC9B0;
}

.bi-braces {
    color: #FF6F61;
}

.bi-folder-fill {
    color: #FFD679 !important;
}

.bi-search {
    color: #FFF !important;
}

.form-label,
.form-check-label {
    color: var(--deep-color-1);
}

div.dt-container .dt-length, 
div.dt-container .dt-search, 
div.dt-container .dt-info, 
div.dt-container .dt-processing, 
div.dt-container .dt-paging {
    color: var(--deep-color-1) !important;
}

.btn-bd-violet {
    --bs-btn-font-weight: 600;
    --bs-btn-color: var(--bs-white);
    --bs-btn-bg: var(--bd-violet-bg);
    --bs-btn-border-color: var(--bd-violet-bg);
    --bs-btn-hover-color: var(--bs-white);
    --bs-btn-hover-bg: #6628e0;
    --bs-btn-hover-border-color: #6628e0;
    --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
    --bs-btn-active-color: var(--bs-btn-hover-color);
    --bs-btn-active-bg: #5a23c7;
    --bs-btn-active-border-color: #5a23c7;
}

.monaco-editor, 
.monaco-diff-editor, 
.monaco-component {
    --vscode-focusBorder: #282A36 !important;
}'),
	 ('','QueryEditor','/studio/frontend/database/QueryEditor.js','JAVASCRIPT','js',NULL,'import Split from ''http://localhost:3000/assets/split.js/dist/split.es.js'';

export class QueryEditor {

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

        Split([''#editorQuery'', ''#resultQuery''], {
            direction: ''vertical'',
            gutterSize: 8,
            minSize: 0,
            sizes: [50, 50]
        });

        //new DataTable(''#datatableResultQuery'',{
        //    lengthMenu: [5, 10, 25, 50, -1]
        //});

        await this.initEditor();
    }

    async initEditor() {

        this.data = await this.app.service.executeByPath({
            path:''/studio/backend/service/DBService.mjs'',
            name:''DBService'',
            execFunction: ''selectQuery'',
            sessionId: ''c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8'',
            params: {"id": `${this.params.id}`}
        });

        let container = document.querySelector(''#editorQuery'');

        if(!window.monaco){
            await this.loadMonaco();
        }

        this.sqlEditor = monaco.editor.create(container, {
            value: '''',
            language: ''sql'',
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
        
        fetch(''/js/themes/Dracula.json'')
            .then(data => data.json())
            .then(data => {
                monaco.editor.defineTheme(''vs-dark'', data);
                monaco.editor.setTheme(''vs-dark'');
            });

        container.innerHTML = '''';
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

            require.config({ paths: { vs: ''https://cdn.jsdelivr.net/npm/monaco-editor@0.52.2/min/vs'' } });
            require([''vs/editor/editor.main''], resolve);
        });
    }
}'),
	 ('','FormFiles','/studio/frontend/FormFiles.js','JAVASCRIPT','js',NULL,'export class FormFiles {

    constructor(app, params) {
        this.app = app;
        this.params = params;
    }

    template() {
        return `
        <form>
            <input type="hidden" id="id" />
            <input type="hidden" id="language" />
            <input type="hidden" id="code" />
            <input type="hidden" id="location" />
            <input type="hidden" id="initFunctionName" value="init" />
            <div class="mb-3">
                <label for="typeFile" class="form-label">Type</label>
                <select class="form-select form-select-sm" id="typeFile">
                    <option value="">Selecione</option>
                    <option value="CONTROLLER">Controller</option>
                    <option value="SERVICE">Service</option>
                    <option value="REPOSITORY">Repository</option>
                    <option value="JAVASCRIPT">JS</option>
                    <option value="CSS">CSS</option>
                    <option value="HTML">HTML</option>
                </select>                
            </div>
            <div class="mb-3">
                <label for="path" class="form-label">Path(Complete path and name)</label>
                <input type="text" class="form-control form-control-sm" id="path" />
            </div>
            <div class="mb-3">
                <label for="fileName" class="form-label">Name</label>
                <input type="text" class="form-control form-control-sm" id="name" />
            </div>
            <button id="btnCancelNewFile" type="button" class="btn btn-sm btn-secondary">Cancel</button>
            <button id="btnClearNewFile" type="button" class="btn btn-sm btn-secondary">Clear</button>
            <button id="btnSaveNewFile" type="button" class="btn btn-sm btn-primary">Save</button>
        </form>`;
    }

    async init() {
        this.events();
    }

    cancel(){
        this.clean()
        document.querySelector(''#appOffCanvasClose'').click();
    }

    clean(){
        document.querySelector(''#typeFile'').value = '''';
        document.querySelector(''#language'').value = '''';
        document.querySelector(''#path'').value = '''';
        document.querySelector(''#name'').value = '''';
    }

    async save(){
        let file = {
            id: document.querySelector(''#id'').value,
            typeFile: document.querySelector(''#typeFile'').value,
            language: document.querySelector(''#language'').value,
            path: document.querySelector(''#path'').value,
            location: document.querySelector(''#location'').value,
            name: document.querySelector(''#name'').value,
            code: document.querySelector(''#code'').value
        };
        if(file?.id){
            await this.app.service.update(file, file.id);
        }else{
            await this.app.service.save(file);
        }
        await this.app.getComponentByName(''Studio'').setFolder();
        document.querySelector(''#appOffCanvasClose'').click();
    }

    async events(){

        if(this.params.event?.target.hasAttribute(''data-type'')){
            let item = await this.app.service.findByPath(this.params?.event.target.getAttribute(''data-path''));
            document.querySelector(''#id'').value = item.id;
            document.querySelector(''#path'').value = item.path;
            document.querySelector(''#name'').value = item.name;
            document.querySelector(''#typeFile'').value = item.typeFile;
            document.querySelector(''#language'').value = item.language;
            document.querySelector(''#code'').value = item.code;
        }

        document.querySelector(''#typeFile'').addEventListener(''change'', (event) => {
            let language = document.querySelector(''#language'');
            switch (event.target.value) {
                case ''CONTROLLER'':
                    language.value = ''js'';
                    break;
                    case ''SERVICE'':
                        language.value = ''js'';
                        break;    
                    case ''REPOSITORY'':
                        language.value = ''js'';
                        break;
                    case ''JAVASCRIPT'':
                        language.value = ''js'';
                        break;
                    case ''CSS'':
                        language.value = ''css'';
                        break;
                    case ''HTML'':
                        language.value = ''html'';
                        break;
            }
        });
        document.querySelector(''#btnSaveNewFile'').addEventListener(''click'', async(event)=>{
            this.save();
        });
        document.querySelector(''#btnCancelNewFile'').addEventListener(''click'', () => {
            this.cancel();
        });
        document.querySelector(''#btnClearNewFile'').addEventListener(''click'', () => {
            this.clean();
        });
    }
}'),
	 ('','Gemini','/crmp6/frontend/Gemini.js','JAVASCRIPT','js',NULL,'import { GoogleGenerativeAI } from "https://esm.run/@google/generative-ai";

export class Gemini {

    constructor(app) {
        this.app = app;
    }

    template(){
        return `
        <style>
            body, html { margin: 0; padding: 0; height: 100%; overflow: hidden; font-family: Arial, sans-serif; }
            .container-fluid { display: flex; flex-direction: column; height: 100%; background-color: #1e1e1e; color: #d4d4d4;}
            .header { padding: 10px 20px; background-color: #333; border-bottom: 2px solid #000; flex-shrink: 0; }
            .header h1 { margin: 0; font-size: 1.2em; }
            .header p { margin: 5px 0 0; font-size: 0.9em; }
            .header input { margin-top: 10px; padding: 5px; width: 300px; background-color: #444; color: #fff; border: 1px solid #666;}
            .main-content { display: flex; flex-grow: 1; min-height: 0; }
            .editor-area { flex-grow: 3; display: flex; flex-direction: column; min-width: 0; }
            .context-area { flex-grow: 1; display: flex; flex-direction: column; border-left: 2px solid #000; min-width: 0; }
            .area-title { background-color: #252526; padding: 8px; font-weight: bold; flex-shrink: 0; }
            #editor-container, #contextFilesInput {
                width: 100%;
                height: 100%;
                box-sizing: border-box;
            }
            /* NOVO: Estilo para a área de texto de contexto */
            #contextFilesInput {
                background-color: #1e1e1e;
                color: #d4d4d4;
                border: none;
                padding: 10px;
                font-family: monospace;
                font-size: 14px;
                resize: none;
            }
        </style>
        <div class="container-fluid">
            <div class="header">
                <h1>Monaco + Gemini: Autocomplete com Contexto Completo</h1>
                <p>Cole o código de outras classes na área "Contexto do Projeto" para melhores sugestões.</p>
                <input type="text" id="apiKeyInput" placeholder="COLE SUA CHAVE DE API DO GEMINI AQUI">
            </div>
            <div class="main-content">
                <div class="editor-area">
                    <div class="area-title">Arquivo Ativo (main.js)</div>
                    <div id="editor-container"></div>
                </div>
                <div class="context-area">
                    <div class="area-title">Contexto do Projeto (outras classes/arquivos)</div>
                    <textarea id="contextFilesInput" placeholder="Cole aqui o código de outros arquivos, como ''utils.js'' ou ''user-class.js''. Use comentários para separar os arquivos, por exemplo: &#10;// --- FILE: utils.js ---&#10;...código..."></textarea>
                </div>
            </div>
        </div>`;
    }

    init(){

        let generativeAI;
        let monacoEditor;

        require.config({ paths: { ''vs'': ''https://cdn.jsdelivr.net/npm/monaco-editor@0.49.0/min/vs'' }});

        require([''vs/editor/editor.main''], () => {
            // Exemplo de código para a área de contexto
            const contextExample = `
            // --- FILE: user-class.js ---
            class User {
                constructor(name, email) {
                    this.name = name;
                    this.email = email;
                    this.createdAt = new Date();
                }

                getProfileInfo() {
                    return \\`Nome: \\${this.name}, Email: \\${this.email}\\`;
                }
            }

            // --- FILE: api-client.js ---
            async function performApiCall(endpoint, data) {
                console.log(\\`Chamando \\${endpoint} com os dados:\\`, data);
                // simula uma chamada de API
                return { success: true, data: { id: 123 } };
            }`;
            document.getElementById(''contextFilesInput'').value = contextExample;

            monacoEditor = monaco.editor.create(document.getElementById(''editor-container''), {
                value: [
                    ''// Estamos em main.js'',
                    ''// Tente instanciar a classe User ou usar a função performApiCall'',
                    '''',
                    ''const newUser = new '' // Tente acionar o autocomplete aqui
                ].join(''\\n''),
                language: ''javascript'',
                theme: ''vs-dark'',
                automaticLayout: true,
                fontSize: 14
            });

            monaco.languages.registerCompletionItemProvider(''javascript'', {
                triggerCharacters: [''.'', ''('', '' '', ''\\n''],
                provideCompletionItems: async (model, position) => {
                    const apiKey = document.getElementById(''apiKeyInput'').value;
                    if (!apiKey) return { suggestions: [] };
                    
                    if (!generativeAI) generativeAI = new GoogleGenerativeAI(apiKey);

                    // NOVO: Coletar o contexto adicional
                    const contextCode = document.getElementById(''contextFilesInput'').value;
                    
                    const textUntilPosition = model.getValueInRange({
                        startLineNumber: 1,
                        startColumn: 1,
                        endLineNumber: position.lineNumber,
                        endColumn: position.column,
                    });

                    // NOVO: Estruturar um prompt muito mais rico e detalhado
                    const prompt = `
                        Você é um assistente de programação especialista em JavaScript que analisa um projeto inteiro para fornecer o melhor autocomplete.

                        A seguir estão os arquivos de contexto do projeto. Use-os para entender as classes e funções disponíveis:
                        --- CONTEXTO DO PROJETO ---
                        ${contextCode}
                        --- FIM DO CONTEXTO ---

                        Agora, aqui está o arquivo que o usuário está editando ativamente. Complete o código a partir da posição do cursor.
                        Responda apenas com o código de preenchimento, sem explicações.

                        --- ARQUIVO ATIVO (main.js) ---
                        ${textUntilPosition}
                        --- FIM DO ARQUIVO ATIVO ---

                        CÓDIGO DE PREENCHIMENTO:`;
                    
                    console.log("Enviando prompt com contexto completo para o Gemini...");
                    
                    try {
                        const geminiModel = generativeAI.getGenerativeModel({ model: "gemini-1.5-flash" });
                        const result = await geminiModel.generateContent(prompt);
                        const response = await result.response;
                        const generatedText = response.text();
                        
                        console.log("Resposta recebida:", generatedText);
                        if (!generatedText) return { suggestions: [] };

                        const suggestion = {
                            label: { label: generatedText.split(''\\n'')[0], description: ''Sugestão com Contexto (Gemini)'' },
                            kind: monaco.languages.CompletionItemKind.Snippet,
                            insertText: generatedText,
                            insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet,
                            range: new monaco.Range(position.lineNumber, position.column, position.lineNumber, position.column),
                            documentation: ''Gerado por IA (Gemini 2.5 Pro) com contexto do projeto.'',
                        };

                        return { suggestions: [suggestion] };
                    } catch (error) {
                        console.error("Erro na API do Gemini:", error);
                        return { suggestions: [] };
                    }
                }
            });
        });
    }
}'),
	 ('','LeadsService','/crmp6/backend/service/LeadsService.mjs','SERVICE','js',NULL,'/*SERVICE | /crmp6/backend/LeadsService.mjs*/
export class LeadsService {

	async init(params){
        const Service = Java.type(''br.com.sdvs.base.service.GenericRestClient'');
        const service = new Service();
        return service.getString("https://jsonplaceholder.typicode.com/posts", null);
	}
} '),
	 ('','DBService','/studio/backend/service/DBService.mjs','SERVICE','js',NULL,'/*SERVICE | /crmp6/backend/ConsumersService.mjs*/
export class DBService {

    constructor(){
        const JSScriptDAO = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const JSScriptService = Java.type(''br.com.sdvs.base.service.JSScriptService'');
       
        this.dao = new JSScriptDAO();
        this.service = new JSScriptService();
    }

    //-- TREEVIEW
    async buildFileTree(params){
        return this.service.buildFileTree();
	}

    //--> TABLES
    async selectTables(params){

		const sql = `SELECT * FROM st_tables`;

        let wrGet = {};

		let rsGet = {
            values: ["id", "tables_name", "created_by", "updated_by"],
            types: ["Long", "String", "Long", "Long"]
	    };

        
        return this.dao.select(sql, wrGet, rsGet, false);
	}

    async insertTable(params){
        
		const sql = `INSERT INTO st_tables (tables_name, created_by, updated_by) VALUES (?, ?, ?) RETURNING id`;

		let rsSet = {
            values: [params.name, "1", "1"],
            types: ["String", "Long", "Long"]
	    };

        let newTable = await this.dao.insertOrUpdate(sql, rsSet, false);

        let newColumns = [{
            tables_id: `${newTable[0].id}`,
            columns_name: "id",
            data_type: "BIGINT",
            length: "0",
            default_value: "",
            index_search: "N",
            is_required: "S",
            fk_table: "N",
        },{
            tables_id: `${newTable[0].id}`,
            columns_name: "created_by",
            data_type: "BIGINT",
            length: "0",
            default_value: "",
            index_search: "N",
            is_required: "S",
            fk_table: "N",
        },{
            tables_id: `${newTable[0].id}`,
            columns_name: "updated_by",
            data_type: "BIGINT",
            length: "0",
            default_value: "",
            index_search: "N",
            is_required: "S",
            fk_table: "N",
        },{
            tables_id: `${newTable[0].id}`,
            columns_name: "created_at",
            data_type: "TIMESTAMP",
            length: "0",
            default_value: "CURRENT_TIMESTAMP",
            index_search: "N",
            is_required: "S",
            fk_table: "N",
        },{
            tables_id: `${newTable[0].id}`,
            columns_name: "updated_at",
            data_type: "TIMESTAMP",
            length: "0",
            default_value: "CURRENT_TIMESTAMP",
            index_search: "N",
            is_required: "S",
            fk_table: "N",
        }];

        for(let column of newColumns){
            await this.insert(column);
        }

        let newQuery = {
            tables_id: `${newTable[0].id}`,
            query_name: `${params.name}_SELECT_BY_CRITERIA`,
            query: `SELECT * FROM ${params.name} #CRITERIA#`,
            created_by: "1",
            updated_by: "1"
        };
        await this.insertQuery(newQuery);
	}

    //--> COLUMNS

	async select(params){

		const sql = `SELECT * FROM st_table_columns WHERE tables_id = ?`;

        let wrGet = {
            values: [params.tables_id],
            types: ["Long"]
	    };

		let rsGet = {
            values: ["id", "columns_name", "data_type", "length", "default_value", "index_search", "is_required", "fk_table"],
            types: ["Long", "String", "String", "Integer", "String", "String", "String", "String"]
	    };

        return this.dao.select(sql, wrGet, rsGet, false);
	}

    async insert(params){

		const sql = `INSERT INTO st_table_columns (tables_id, columns_name, data_type, length, default_value, index_search, is_required, fk_table, created_by, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id`;

		let rsSet = {
            values: [params.tables_id, params.columns_name, params.data_type, params.length, params.default_value, params.index_search, params.is_required, params.fk_table, "1", "1"],
            types: ["Long", "String", "String", "Integer", "String", "String", "String", "String", "Long", "Long"]
	    };

        return this.dao.insertOrUpdate(sql, rsSet, false);
	}

    async update(params){

		const sql = `UPDATE st_table_columns SET columns_name = ?, data_type = ?, length = ?, default_value = ?, index_search = ?, is_required = ?, fk_table = ?, updated_by = ? WHERE id = ? AND tables_id = ? RETURNING id`;

		let rsSet = {
            values: [params.columns_name, params.data_type, params.length, params.default_value, params.index_search, params.is_required, params.fk_table, "1", params.id, params.tables_id],
            types: ["String", "String", "Integer", "String", "String", "String", "String", "Long", "Long", "Long"]
	    };

        return this.dao.insertOrUpdate(sql, rsSet, false);
	}

    async delete(params){

		const sql = `DELETE FROM st_table_columns WHERE id = ?`;

		let wrSet = {
            values: [params.id],
            types: ["Long"]
	    };

        return this.dao.delete(sql, wrSet, false);
	}

    //--> QUERIES
    async selectQuery(params){

		const sql = `SELECT id, tables_id, query_name, query FROM st_tables_queries WHERE id = ?`;

        let wrGet = {
            values: [params.id],
            types: ["Long"]
	    };

		let rsGet = {
            values: ["id", "tables_id", "query_name", "query"],
            types: ["Long", "Long", "String", "String"]
	    };

        return this.dao.select(sql, wrGet, rsGet, false);
	}

    async insertQuery(params){

		const sql = `INSERT INTO st_tables_queries (tables_id, query_name, query, created_by, updated_by) VALUES (?, ?, ?, ?, ?) RETURNING id`;

		let rsSet = {
            values: [params.tables_id, params.query_name, params.query, "1", "1"],
            types: ["Long", "String", "String", "Long", "Long"]
	    };

        return this.dao.insertOrUpdate(sql, rsSet, false);
	}

    async updateQuery(params){

		const sql = `UPDATE st_tables_queries SET query = ?, updated_by = ? WHERE id = ? RETURNING id`;

		let rsSet = {
            values: [params.query, params.updated_by, params.id],
            types: ["String", "Long", "Long"]
	    };

        return this.dao.insertOrUpdate(sql, rsSet, false);
	}
}');
