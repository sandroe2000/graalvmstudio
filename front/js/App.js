import { Service } from '/js/Service.js';
import { Utils } from './modules/Utils.js';

export class App {

    constructor(){
        this.components = [];
        this.service = new Service();
        this.utils = new Utils();
    }

    async init(obj){

        if(!obj) return false;

        const api = new Service();
        const script = await api.findScript(obj);
        const name = script.name.substring((script.name.lastIndexOf('/') + 1), script.name.indexOf('.js'));        
        const blob = new Blob([script.code], { type: 'text/javascript' });
        const blobURL = URL.createObjectURL(blob);
        const module = await import(blobURL);
        URL.revokeObjectURL(blobURL);
        await this.render(script, module, name);        
    }

    async initLocal(script){
        
        const name = script.path.substring((script.path.lastIndexOf('/') + 1), script.path.indexOf('.js'));        
        const module = await import(script.path);        
        await this.render(script, module, name); 
    }

    async render(script, module, name){

        const target = script.target || '#app';
        let content = '';

        let component = await this.getComponentByName(name);
            component = new module[name](this);

        this.components.push(component);

        if(typeof component?.template === 'function') {
            content = await component.template();
        }

        try {
            if(script.css) await this.loadCSS(script.path.toLowerCase().replace('.js', '.css'));
        } catch (err) {
            console.warn('Deu ruim CSS ->', err);
        }

        if (content){
            document.querySelector(target).innerHTML='';//replaceChildren();
            document.querySelector(target).insertAdjacentHTML('beforeend', content);
        }

        if(typeof component?.init === 'function') {
            await component.init();
        }
    }

    async loadCSS(css) {
        let style = document.createElement('link');
            style.href = css;
            style.type = 'text/css';
            style.rel = 'stylesheet';
        let head = document.getElementsByTagName('head')[0];
            head.append(style);
    }

    getComponentByName(name){
        for(let comp in this.components){
            if(this.components[comp].constructor.name == name){
                return this.components[comp];
            }
        }        
        return null;
    }
}