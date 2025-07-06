export class Service {

    constructor() {
        this.baseUrl = 'http://localhost:8080/api/jsscripts';
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
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(obj)
        });
        return await response.json();
    }

    async executeByLocationAndName(obj) {
        const response = await fetch(`${this.baseUrl}/${obj.location}/${obj.name}/execute`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
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
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(script)
        });
        return await response.json();
    }

    async update(script, id ) {
        const response = await fetch(`${this.baseUrl}/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(script)
        });
        return await response.json();
    }

    async deleteById(id) {
        const response = await fetch(`${this.baseUrl}/${id}`, {
            method: 'DELETE'
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
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: tableName })
        });
        return await response.json();
    }

    async getTableColumns(tableId) {
        return fetch(`${this.baseUrl}/tables/${tableId}/columns`)
            .then(response => response.json())
            .then(data => {
                if (data.status == 'success') {
                    return data.result;
                }
                return [];
            });
    }

    async updateColumn(column, tableId) {
        return fetch(`${this.baseUrl}/tables/columns/${column.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(column)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status == 'success') {
                return data.result;
            }
            throw new Error(data.message);
        });
    }

    async addColumn(column, tableId) {
        return fetch(`${this.baseUrl}/tables/columns`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(column)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status == 'success') {
                return data.result;
            }
            throw new Error(data.message);
        });
    }
    **********************/
}