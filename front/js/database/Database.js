/******* CUSTOMIZADO NÂO TROCAR DE VERSÃO *******/
import { Treeview } from "/assets/quercus.js/dist/treeview.js";
import Split from '/assets/split.js/dist/split.es.js';

export class Database {

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

        Split(['#mainDB', '#asideDB'], {
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
            containerId: 'treeViewDB',
            data: this.tables,
            searchEnabled: false,
            initiallyExpanded: true, 
            multiSelectEnabled: false,
            onSelectionChange: (selectedNodesData) => {
                if(selectedNodesData.length > 0 && selectedNodesData[0].type == 'folder'){
                    this.loadColumnsTableEdit(selectedNodesData[0]?.id, selectedNodesData[0]?.name);
                } else {
                    this.loadQueryEdit(selectedNodesData[0].id, selectedNodesData[0].name);
                }           
            },
            onRenderNode: (nodeData, nodeContentWrapperElement) => {
                // Clear existing content if any (important for setData calls)
                nodeContentWrapperElement.innerHTML = '';
                
                // Create an icon based on node type
                const iconSpan = document.createElement('span');
                iconSpan.classList.add('custom-node-icon'); // Apply custom CSS class for styling
                if (nodeData.type === 'folder') {
                    iconSpan.innerHTML = '<i class="bi bi-table me-2" style="color:#7C2ADC;"></i>';
                } else {
                    iconSpan.innerHTML = '<i class="bi bi-database-fill-gear me-2" style="color: var(--deep-indigo-200)"></i>';
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
            
        document.querySelector('#treeViewDB').classList.add('position-relative');
        document.querySelector('#treeViewDB').setAttribute('style', 'min-width: 230px;');
        document.querySelector('#treeViewDB').insertAdjacentHTML('afterbegin', btnAddTable);
    }

    async loadColumnsTableEdit(tableId, label){
        
        await this.app.initLocal({
                path: '/js/database/TablesEdit.js',
                target: `#mainDB`,
                params: {
                    id: tableId,
                    label: label,
                }
        });
    }

    async loadQueryEdit(queryId, label){

        await this.app.initLocal({
                path: '/js/database/QueryEdit.js',
                target: `#mainDB`,
                params: {
                    id: `${queryId}`,
                    label: label,
                }
        });
    }

    async events(){

        document.querySelector('#lnkAddnewTable').addEventListener('click', async (event) => {
            await this.app.initLocal({
                path: '/js/database/NewTable.js',
                target: '.modal',
                params: {
                    label: 'Add new table',
                    size: 'modal'
                }
            });
        });

        document.querySelector('#lnkAddnewQuery').addEventListener('click', async (event) => {
            await this.app.initLocal({
                path: '/js/database/NewQuery.js',
                target: '.modal',
                params: {
                    label: 'Add new query',
                    size: 'modal'
                }
            });
        });
    }
}