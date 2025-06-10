export class Deep {

    constructor(app){
        this.app = app;      
    }

    template(){
        return `
        <div class="deep">
            <div class="deep-header">               
                <nav class="navbar navbar-expand navbar-dark" aria-label="Second navbar example"> 
                    <div class="container-fluid"> 
                        <a class="navbar-brand"><img src="/images/plusoft-gray.png" style="height:30px;margin:2px 0px 0px 0px;border-radius:6px" alt="Deep"></a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation"> 
                            <span class="navbar-toggler-icon"></span> 
                        </button> 
                        <div class="collapse navbar-collapse" id="navbarsExample02"> 
                            <ul class="navbar-nav me-auto"> 
                                <li class="nav-item dropdown">
                                    <button class="btn btn-sm btn-deep-aside dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">File</button>
                                    <ul class="dropdown-menu dropdown-menu-dark">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item dropdown">
                                    <button class="btn btn-sm btn-deep-aside dropdown-toggle me-2" data-bs-toggle="dropdown" aria-expanded="false">Edit</button>
                                    <ul class="dropdown-menu dropdown-menu-dark">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                    </ul>
                                </li> 
                            </ul>  
                        </div> 
                    </div> 
                </nav>
            </div>
            <div class="deep-aside">
                <div class="btn-group dropend">
                    <button  id="btnNewFile" type="button" class="btn btn-sm btn-deep-aside" dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside" style="border-radius:4px">
                        <i class="bi bi-plus-lg"></i>
                    </button>
                    <form class="dropdown-menu p-3" data-bs-theme="dark" style="width:300px">
                        <div class="mb-3">
                            <label for="typeFile" class="form-label">Type</label>
                            <select class="form-select form-select-sm" id="typeFile">
                                <option value="">Selecione</option>
                                <option value="javascript">Controller</option>
                                <option value="javascript">Service</option>
                                <option value="javascript">Repository</option>
                                <option value="javascript">JS</option>
                                <option value="css">CSS</option>
                                <option value="html">HTML</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="location" class="form-label">Location</label>
                            <input type="text" class="form-control form-control-sm" id="location" />
                        </div>
                        <div class="mb-3">
                            <label for="fileName" class="form-label">Name</label>
                            <input type="text" class="form-control form-control-sm" id="fileName" />
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="inDebugger">
                                <label class="form-check-label" for="inDebugger">in Debugger</label>
                            </div>
                        </div>
                        <button id="btnCancelNewFile" type="button" class="btn btn-sm btn-secondary">Cancel</button>
                        <button id="btnClearNewFile" type="button" class="btn btn-sm btn-secondary">New</button>
                        <button id="btnSaveNewFile" type="button" class="btn btn-sm btn-primary">Save</button>
                    </form>
                </div>
                <button id="btnAsideFolder" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-folder"></i>
                </button>
                <button id="btnAsideSearch" type="button" class="btn btn-sm btn-deep-aside">
                    <i class="bi bi-search"></i>
                </button>
            </div>
            <div class="deep-expector"></div>
            <div class="deep-main">
                <div class="deep-tabs">
                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist"></ul>
                </div>
                <div class="deep-bradcrumbs">
                    <span></span>
                </div>
                <div class="deep-editors">
                    <div class="tab-content" id="pills-tabContent" style="100%"></div>
                </div>
            </div>
            <div class="deep-footer"></div>
        </div>`;
    }

    init(){        
        this.events();
    }

    events(){ 
        
        document.querySelector('#btnAsideFolder').addEventListener('click', async () => {
            await this.app.initLocal({
                path: '/js/Folder.js',
                target: '.deep-expector'
            });
        });

        document.querySelector('#btnAsideSearch').addEventListener('click', () => {
            console.log('SEARCH...');
        });
    }
}