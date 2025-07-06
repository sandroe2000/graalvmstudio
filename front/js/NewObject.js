export class NewObject {

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
        document.querySelector('#appOffCanvasClose').click();
    }

    clean(){
        document.querySelector('#typeFile').value = '';
        document.querySelector('#language').value = '';
        document.querySelector('#path').value = '';
        document.querySelector('#name').value = '';
    }

    async save(){
        let file = {
            id: document.querySelector('#id').value,
            typeFile: document.querySelector('#typeFile').value,
            language: document.querySelector('#language').value,
            path: document.querySelector('#path').value,
            location: document.querySelector('#location').value,
            name: document.querySelector('#name').value,
            code: document.querySelector('#code').value
        };
        if(file?.id){
            await this.app.service.update(file, file.id);
        }else{
            await this.app.service.save(file);
        }
        await this.app.getComponentByName('Deep').setFolder();
        document.querySelector('#appOffCanvasClose').click();
    }

    async events(){

        if(this.params.event?.target.hasAttribute('data-type')){
            let item = await this.app.service.findByPath(this.params?.event.target.getAttribute('data-path'));
            document.querySelector('#id').value = item.id;
            document.querySelector('#path').value = item.path;
            document.querySelector('#name').value = item.name;
            document.querySelector('#typeFile').value = item.typeFile;
            document.querySelector('#language').value = item.language;
            document.querySelector('#code').value = item.code;
        }

        document.querySelector('#typeFile').addEventListener('change', (event) => {
            let language = document.querySelector('#language');
            switch (event.target.value) {
                case 'CONTROLLER':
                    language.value = 'js';
                    break;
                    case 'SERVICE':
                        language.value = 'js';
                        break;    
                    case 'REPOSITORY':
                        language.value = 'js';
                        break;
                    case 'JAVASCRIPT':
                        language.value = 'js';
                        break;
                    case 'CSS':
                        language.value = 'css';
                        break;
                    case 'HTML':
                        language.value = 'html';
                        break;
            }
        });
        document.querySelector('#btnSaveNewFile').addEventListener('click', async(event)=>{
            this.save();
        });
        document.querySelector('#btnCancelNewFile').addEventListener('click', () => {
            this.cancel();
        });
        document.querySelector('#btnClearNewFile').addEventListener('click', () => {
            this.clean();
        });
    }
}