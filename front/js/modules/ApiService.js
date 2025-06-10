export class ApiService {

    constructor() {
        this.baseUrl = 'http://localhost:8080/api/scripts';
    }

    async get() {
        const response = await fetch(this.baseUrl);
        return await response.json();
    }

    async getById(id) {
        const response = await fetch(`${this.baseUrl}/${id}`);
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

    async update(id, script) {
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
}