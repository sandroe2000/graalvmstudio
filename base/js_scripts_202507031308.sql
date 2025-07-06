INSERT INTO public.js_scripts ("location",name,"path",type_file,"language",init_function_name,code) VALUES
	 ('','Consumers','/crmp6/frontend/Consumers.js','JAVASCRIPT','js',NULL,'/*JAVASCRIPT | /crmp6/frontend/Consumers.js*/
export class Consumers {

    constructor(app) {
        this.app = app;
    }

    template() {
        return `
        <div class="container-fluid">
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
        </div>`;
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
	 ('','LeadsService','/crmp6/backend/service/LeadsService.mjs','SERVICE','js',NULL,'/*SERVICE | /crmp6/backend/LeadsService.mjs*/
export class LeadsService {

	async init(params){

       //const Map = Java.type(''java.util.Map'');
        const Service = Java.type(''br.com.sdvs.base.service.GenericRestClient'');

        const service = new Service();
        return service.getString("https://jsonplaceholder.typicode.com/posts", null);
	}
}'),
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
            <div class="dp-main px-3 py-3" style="overflow:auto"></div>
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
        await this.setHome();
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
        document.querySelector(''#btnAsideHome'').addEventListener(''click'', async (event)=>{
            await this.setHome();
        });  

        document.querySelector(''#btnBarHelp'').addEventListener(''click'', async (event) => {
            await this.showModal();
        });    
    }
}  '),
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
	 ('','DBService','/studio/backend/service/DBService.mjs','SERVICE','js',NULL,'/*SERVICE | /crmp6/backend/ConsumersService.mjs*/
export class DBService {

    //--> TABLES
    async selectTables(params){

		const sql = `SELECT * FROM st_tables`;

        let wrGet = {};

		let rsGet = {
            values: ["id", "tables_name", "created_by", "updated_by"],
            types: ["Long", "String", "Long", "Long"]
	    };

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.select(sql, wrGet, rsGet, false);
	}

    async insertTable(params){

		const sql = `INSERT INTO st_tables (tables_name, created_by, updated_by) VALUES (?, ?, ?) RETURNING id`;

		let rsSet = {
            values: [params.name, "1", "1"],
            types: ["String", "Long", "Long"]
	    };

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.insertOrUpdate(sql, rsSet, false);
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

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.select(sql, wrGet, rsGet, false);
	}

    async insert(params){

		const sql = `INSERT INTO st_table_columns (tables_id, columns_name, data_type, length, default_value, index_search, is_required, fk_table, created_by, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id`;

		let rsSet = {
            values: [params.tables_id, params.columns_name, params.data_type, params.length, params.default_value, params.index_search, params.is_required, params.fk_table, "1", "1"],
            types: ["Long", "String", "String", "Integer", "String", "String", "String", "String", "Long", "Long"]
	    };

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.insertOrUpdate(sql, rsSet, false);
	}

    async update(params){

		const sql = `UPDATE st_table_columns SET columns_name = ?, data_type = ?, length = ?, default_value = ?, index_search = ?, is_required = ?, fk_table = ?, updated_by = ? WHERE id = ? AND tables_id = ? RETURNING id`;

		let rsSet = {
            values: [params.columns_name, params.data_type, params.length, params.default_value, params.index_search, params.is_required, params.fk_table, "1", params.id, params.tables_id],
            types: ["String", "String", "Integer", "String", "String", "String", "String", "Long", "Long", "Long"]
	    };

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.insertOrUpdate(sql, rsSet, false);
	}

    async delete(params){

		const sql = `DELETE FROM st_table_columns WHERE id = ?`;

		let wrSet = {
            values: [params.id],
            types: ["Long"]
	    };

        const Service = Java.type(''br.com.sdvs.base.dao.JSScriptDAO'');
        const service = new Service();
        return service.delete(sql, wrSet, false);
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
}');
