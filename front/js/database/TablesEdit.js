export class TablesEdit {

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
                        <label for="columns_name" class="form-label">Columnn's name</label>
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
            path:'/studio/backend/service/DBService.mjs',
            name:'DBService',
            execFunction: 'select',
            sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
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
            document.querySelector('#st_columns_datatable thead').innerHTML = '';
            document.querySelector('#st_columns_datatable tbody').innerHTML = '';
        }

        // Initialize DataTable with the columns
        that.table = new DataTable('#st_columns_datatable', {
            layout:{
                topStart: null,
                topEnd: null,
                bottomStart: 'info',
                bottomEnd: 'paging'
            },
            iDisplayLength: 50,
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
                    className: 'dt-center editor-edit',
                    defaultContent: '<i class="bi bi-pen text-info"></i>',
                    orderable: false,
                    width: '40px'
                },
                {
                    data: null,
                    className: 'dt-center editor-delete',
                    defaultContent: '<i class="bi bi-trash text-danger"></i>',
                    orderable: false,
                    width: '40px'
                }
            ]
        }).on('click', 'td.editor-edit i', function (e) {
            const data = that.table.row($(this).parents('tr')).data();
            document.querySelector('#st_columns_id').value = data[0]; // Set the hidden input with the record ID
            document.querySelector('#columns_name').value = data[1];    // Set the column name
            document.querySelector('#st_columns_data_type').value = data[2]; // Set the data type
            document.querySelector('#st_columns_lenght').value = data[3]; // Set the length
            document.querySelector('#st_columns_default_value').value = data[4]; // Set the default value
            document.querySelector('#st_columns_index_search').checked = (data[5] === 'Y'); // Set the index search checkbox
            document.querySelector('#st_column_is_required').checked = (data[6] === 'Y'); // Set the required checkbox
            document.querySelector('#st_columns_fk_table').checked = (data[7] === 'Y'); // Set the foreign key checkbox
        }).on('click', 'td.editor-delete i', function (e) {
            const data = that.table.row($(this).parents('tr')).data();
            that.delete(data[0])
            console.log(`Delete record clicked: ${data[0]}`);
        });
    }

    async delete(id){

        await this.app.service.executeByPath({
            path:'/studio/backend/service/DBService.mjs',
            name:'DBService',
            execFunction: 'delete',
            sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
            params: {"id": `${id}`}
        });
        await this.loadTableColumns(this.params.id);
        this.cancel();
        this.app.notyf.success('Your changes have been successfully saved!');
    }

    cancel(){
        document.querySelector('#st_columns_id').value = ""; // Set the hidden input with the record ID
        document.querySelector('#columns_name').value = "";    // Set the column name
        document.querySelector('#st_columns_data_type').value = ""; // Set the data type
        document.querySelector('#st_columns_lenght').value = ""; // Set the length
        document.querySelector('#st_columns_default_value').value = ""; // Set the default value
        document.querySelector('#st_columns_index_search').checked = false; // Set the index search checkbox
        document.querySelector('#st_column_is_required').checked = false; // Set the required checkbox
        document.querySelector('#st_columns_fk_table').checked = false; // Set the foreign key checkbox
    }

    events() {

        document.querySelector('#btnCancelColumnTable').addEventListener('click', async (event) => {            
            this.cancel();
        });

        document.querySelector('#btnEditColumnTable').addEventListener('click', async (event) => {

            let id = document.querySelector('#st_columns_id').value;
            let columns_name = document.querySelector('#columns_name').value;
            let dataType = document.querySelector('#st_columns_data_type').value;

            if(!columns_name || !dataType) {
                alert('Please fill in all required fields.');
                return;
            }

            const columnData = {
                id: id,
                tables_id: document.querySelector('#st_columns_table_id').value,
                columns_name: columns_name,
                data_type: dataType,
                length: document.querySelector('#st_columns_lenght').value,
                default_value: document.querySelector('#st_columns_default_value').value,
                index_search: document.querySelector('#st_columns_index_search').checked ? 'Y' : 'N',
                is_required: document.querySelector('#st_column_is_required').checked ? 'Y' : 'N',
                fk_table: document.querySelector('#st_columns_fk_table').checked ? 'Y' : 'N'
            };

            if(id) {
                await this.app.service.executeByPath({
                    path:'/studio/backend/service/DBService.mjs',
                    name:'DBService',
                    execFunction: 'update',
                    sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
                    params: columnData
                });
            } else {
                //await this.app.service.addColumn(columnData, this.params.id);
                delete columnData.id;
                await this.app.service.executeByPath({
                    path:'/studio/backend/service/DBService.mjs',
                    name:'DBService',
                    execFunction: 'insert',
                    sessionId: 'c3b8621b-eac9-4029-b9fa-4cd2ac77c1f8',
                    params: columnData
                });
            }

            // Reload the table columns
            await this.loadTableColumns(this.params.id);
            this.cancel();
            this.app.notyf.success('Your changes have been successfully saved!');
        });
    }
}