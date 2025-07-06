export class NewTable {

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
        document.querySelector('#btnAddNewTable').addEventListener('click', async (event) => {
            const tableName = document.querySelector('#txtAddNewTable').value;
            //await this.app.service.addTable(tableName);
            await this.app.service.executeByPath({
                path:'/studio/backend/service/DBService.mjs',
                name:'DBService',
                execFunction: 'insertTable',
                sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
                params: { "name": tableName }
            });
            this.app.modal.close();
            this.app.notyf.success('Your changes have been successfully saved!');
        });
    }
}