export class ScriptList {
    constructor(container, scripts, onSelect, onDelete) {
        this.container = container;
        this.scripts = scripts;
        this.onSelect = onSelect;
        this.onDelete = onDelete;
        this.render();
    }

    render() {
        this.container.innerHTML = `
            <ul class="script-list">
                ${this.scripts.map(script => this.scriptItemTemplate(script)).join('')}
            </ul> `;
        this.bindEvents();
    }

    scriptItemTemplate(script) {
        return `
            <li class="script-item" data-id="${script.id}">
                <span>${script.name}</span>
                <button class="delete-btn" data-id="${script.id}">×</button>
            </li>`;
    }

    bindEvents() {
        this.container.querySelectorAll('.script-item').forEach(item => {
            item.addEventListener('click', (e) => {
                if (!e.target.classList.contains('delete-btn')) {
                    const script = this.scripts.find(s => s.id === parseInt(item.dataset.id));
                    this.onSelect(script);
                    this.highlightSelected(item.dataset.id);
                }
            });
        });

        this.container.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                this.onDelete(parseInt(btn.dataset.id));
            });
        });
    }

    highlightSelected(id) {
        this.container.querySelectorAll('.script-item').forEach(item => {
            item.classList.toggle('active', item.dataset.id === id);
        });
    }

    filterScripts(searchTerm) {
        const filtered = this.scripts.filter(script =>
            script.name.toLowerCase().includes(searchTerm.toLowerCase())
        );
        this.container.innerHTML = `
            <ul class="script-list">
                ${filtered.map(script => this.scriptItemTemplate(script)).join('')}
            </ul>`;
        this.bindEvents();
    }

    updateScripts(scripts) {
        this.scripts = scripts;
        this.render();
    }
}