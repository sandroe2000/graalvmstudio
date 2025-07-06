import Split from '/assets/split.js/dist/split.es.js';

export class Deep {

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

        Split(['#deep-expector', '#deep-main'], {
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
        await this.app.initLocal({
            path: '/js/Folder.js',
            target: '#deep-expector'
        });
    }

    resizeHandler(){
        document.querySelector('#pills-tabContent').style.width = `${document.querySelector('#deep-main').offsetWidth}px`;
        document.querySelectorAll('#pills-tabContent div.tab-pane').forEach(item => {
            item.style.width = `${document.querySelector('#deep-main').offsetWidth - 12}px`;
        });
        document.querySelectorAll('#pills-tabContent div.tab-pane div.monaco-editor').forEach(item => {
            item.style.width = `${document.querySelector('#deep-main').offsetWidth - 12}px`;
        });
        document.querySelectorAll('div.dragula-panel').forEach(item => {
            item.style.width = `${document.querySelector('#deep-main').offsetWidth - 12}px`;
        });
    }

    events(){ 

        window.removeEventListener('resize', this.resizeHandler);
        window.addEventListener('resize', this.resizeHandler);
        
        document.querySelector('#btnAsideFolder').addEventListener('click', async () => {
            await this.app.initLocal({
                path: '/js/Folder.js',
                target: '#deep-expector'
            });
        });

        document.querySelector('#btnAsideSearch').addEventListener('click', () => {
            console.log('SEARCH...');
        });
    }
}