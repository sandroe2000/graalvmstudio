export class NewQuery {

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
        document.querySelector('#btnNewQuery').addEventListener('click', async (event) => {
            /*const table_id = document.querySelector('#txtNewQueryTable').value;
            const query_name = document.querySelector('#txtNewQueryName').value;
            
            await this.app.service.executeByPath({
                path:'/studio/backend/service/DBService.mjs',
                name:'DBService',
                execFunction: 'insertQuery',
                sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
                params: { "table_id": `${table_id}`, "query_name": `${query_name}` }
            });
            this.app.modal.close();
            this.app.notyf.success('Your changes have been successfully saved!');*/
        });
    }
}