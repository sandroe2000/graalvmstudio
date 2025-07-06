import { Service } from '/js/Service.js';
import { Modal } from '/js/Modal.js';
import { OffCanvas } from '/js/OffCanvas.js';
import { Utils } from '/js/Utils.js';

export class App {

    constructor(){
        this.components = [];
        this.service = new Service();
        this.modal = new Modal();
        this.canvas = new OffCanvas();
        this.utils = new Utils();
        this.notyf = new Notyf({
            duration: 2000,
            position: {
                x: 'right',
                y: 'top',
            }
        });
    }

    async init(obj){

        if(!obj) return false;
        //const api = new Service();
        const script = await this.service.findByPathContains(obj.path);
        const js = script.filter((item) => {
            return item.path == obj.path;
        });
        const name = js[0].name;//.substring((js[0].name.lastIndexOf('/') + 1), js[0].name.indexOf('.js'));        
        const blob = new Blob([js[0].code], { type: 'text/javascript' });
        const blobURL = URL.createObjectURL(blob);
        const module = await import(blobURL);
        URL.revokeObjectURL(blobURL);
        await this.render(obj, script, module, name);        
    }

    async initLocal(obj){
        
        const name = obj.path.substring((obj.path.lastIndexOf('/') + 1), obj.path.indexOf('.js'));        
        const module = await import(obj.path);        
        await this.render(obj, null, module, name); 
    }

    async render(obj, script, module, name){

        const target = obj.target || '#app';
        let content = '';
        let html = '';
        
        let component = new module[name](this, obj.params);
        if(!await this.getComponentByName(name)){
            this.components.push(component);
        }

        try {
            if(obj.css && obj.path && !script){
                await this.loadCSS(obj.path.toLowerCase().replace('.js', '.css'));
            }
            if(obj.css && obj.path && script){
                const css = script.filter((item) => {
                    return item.path.includes( name.toLowerCase() + '.css');
                });
                const blob = new Blob([css[0].code], { type: 'text/css' });
                const blobURL = URL.createObjectURL(blob);
                await this.loadCSS(blobURL);
            }
        } catch (err) {
            console.error('FALHA AO RENDERIZAR CSS ->', err);
        }

        if(typeof component?.template === 'function') {
            content = await component.template();
        }else{
            if(script){
                html = script.filter((item) => {
                    return item.path.includes( name.toLowerCase() + '.html');
                });
            }else{
                html = await this.loadHTML(name.toLowerCase() + '.html');
            }            
            if(html){
                content = html[0]?.code;
            }
        }

        //...MODAL
        if (target == '.modal' && content) {
            await this.modal.init(obj.params);
            document.querySelector('.modal-body').innerHTML='';//replaceChildren();
            document.querySelector('.modal-body').insertAdjacentHTML('beforeend', content);
        //...OFFCANVAS
        } else if (target == '.offcanvas' && content) {//... MODA
            await this.canvas.init(obj.params);
            document.querySelector('.offcanvas-body').innerHTML='';//replaceChildren();
            document.querySelector('.offcanvas-body').insertAdjacentHTML('beforeend', content);
        } else if (content) {
            document.querySelector(target).innerHTML='';//replaceChildren();
            document.querySelector(target).insertAdjacentHTML('beforeend', content);
        }

        if(typeof component?.init === 'function') {
            await component.init();
        }
    }

    async loadCSS(css) {
        let style = document.createElement('link');
            style.rel = 'stylesheet';
            style.href = css;
        let head = document.getElementsByTagName('head')[0];
            head.append(style);
    }

    async loadHTML(html) {
        try {
            return await fetch(html, {
                method: 'GET',
                headers: {
                    'Accept': 'text/html',
                },
            }).then(response => response.text());
        } catch (err) {
            console.error('FALHA AO RENDERIZAR HTML ->', err);
        }
    }

    getComponentByName(name){
        for(let comp in this.components){
            if(this.components[comp].constructor.name == name){
                return this.components[comp];
            }
        }        
        return null;
    }

    spinnerOn(){
        const spinnerWrapper = document.querySelector('.spinner-wrapper');
        spinnerWrapper.style.opacity = '100';
        spinnerWrapper.style.display = 'flex';
    }

    async spinnerOff(){
        setTimeout(async () => {
            const spinnerWrapper = document.querySelector('.spinner-wrapper');
            async function close() {
                spinnerWrapper.style.opacity = '0';
            }
            await close();
            spinnerWrapper.style.display = 'none';
        }, 500);
    }
}